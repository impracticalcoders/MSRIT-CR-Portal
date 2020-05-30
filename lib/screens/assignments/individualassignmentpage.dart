import 'package:crportal/models/assignment.dart';
import 'package:crportal/screens/assignments/editassignment.dart';
import 'package:crportal/services/newassignmentbloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class IndividualAssignmentPage extends StatefulWidget {
  final Assignment assignment;
  final String classcode;

  IndividualAssignmentPage({Key key, this.assignment, this.classcode})
      : super(key: key);

  @override
  _IndividualAssignmentPageState createState() =>
      _IndividualAssignmentPageState();
}

class _IndividualAssignmentPageState extends State<IndividualAssignmentPage> {
  bool isLoading = false;
  bool showLoading = true;

  String classcode;

  @override
  void initState() {
    _loadClassDetails();
    super.initState();
  }

  _loadClassDetails() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String _classcode = await pref.get("ClassCode");
    setState(() {
      this.classcode = _classcode;
      this.isLoading = false;
    });
  }

  String _formatDate(DateTime date) {
    final format = DateFormat.Hm('en_US').add_MMMMEEEEd();
    return format.format(date);
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  onPressDelete() {
    setState(() {
      this.isLoading = true;
    });
    deleteAssignmentfromDB(
      widget.assignment.AssignmentID,
      classcode: classcode,
    ).then((statusCode) {
      setState(() {
        this.isLoading = false;
      });
      switch (statusCode) {
        case 1:
          print('Deleted');
          Fluttertoast.showToast(
              msg: "Assignment Deleted",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              textColor: Colors.white,
              fontSize: 16.0);
          Navigator.pop(context);
          break;
        case 2:
          print('check your internet connection');
          Fluttertoast.showToast(
              msg: "Check your Internet Connection",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              textColor: Colors.white,
              fontSize: 16.0);
          break;
        case 3:
          print('please try again later');
          Fluttertoast.showToast(
              msg: "Please try again later",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              textColor: Colors.white,
              fontSize: 16.0);
          break;
      }
    });
  }

  SliverToBoxAdapter _profileCard() {
    return SliverToBoxAdapter(
        child: Padding(
      padding: EdgeInsets.only(top: 11),
      child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          child: Container(
            height: 160,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      "${widget.assignment.title}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "${widget.assignment.subjectCode}",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                    Text(
                      'Due ' + _formatDate(widget.assignment.deadline.toDate()),
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                  ],
                )),
          )),
    ));
  }

  SliverToBoxAdapter _descriptionCard() {
    return SliverToBoxAdapter(
        child: Padding(
      padding: EdgeInsets.only(top: 11),
      child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          child: Container(
            // height: 160,
            margin: EdgeInsets.all(5),
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Description",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "${widget.assignment.description}",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                      textAlign: TextAlign.left,
                      // maxLines: 18,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                )),
          )),
    ));
  }

  SliverToBoxAdapter _linksCard() {
    return SliverToBoxAdapter(
        child: Padding(
      padding: EdgeInsets.only(top: 11),
      child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          child: Container(
            margin: EdgeInsets.all(10),
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Links",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    (widget.assignment.moreDetailsLink != "")
                        ? ListTile(
                            title: Text(
                              "More Details",
                              
                              textAlign: TextAlign.left,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                              "${widget.assignment.moreDetailsLink}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                              textAlign: TextAlign.left,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.attachment),
                              onPressed: () =>
                                  _launchURL(widget.assignment.moreDetailsLink),
                            ))
                        : Container(
                            child: Text("No link attached"),
                          ),
                    SizedBox(
                      height: 10,
                    ),
                    (widget.assignment.submitLink != "")
                        ? ListTile(
                            title:Text(
                              "Submission Link",
                              textAlign: TextAlign.left,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                              "${widget.assignment.submitLink}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                              textAlign: TextAlign.left,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.attachment),
                              onPressed: () =>
                                  _launchURL(widget.assignment.submitLink),
                            ))
                        : Container(
                            child: Text("No link attached"),
                          ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                )),
          )),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: widget.assignment.AssignmentID,
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                "Assignment Details",
                style: TextStyle(
                    fontFamily: 'Archia', fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => EditAssignment(
                                  assignment: widget.assignment,
                                  classcode: classcode,
                                  assignmentid: widget.assignment.AssignmentID,
                                )));
                  },
                ),
                IconButton(
                  icon: isLoading
                      ? CupertinoActivityIndicator()
                      : Icon(Icons.delete_forever),
                  onPressed: () {
                    onPressDelete();
                  },
                ),
              ],
              elevation: 0.0,
            ),
            body: CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: <Widget>[
                _profileCard(),
                _descriptionCard(),
                _linksCard()
              ],
            )));
  }
}
