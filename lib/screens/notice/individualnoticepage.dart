import 'package:crportal/models/notice.dart';
import 'package:crportal/screens/notice/editnotice.dart';
import 'package:crportal/services/newnotice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class IndividualNoticePage extends StatefulWidget {
  final Notice notice;
  final String classcode;

  IndividualNoticePage({Key key, this.notice, this.classcode})
      : super(key: key);

  @override
  _IndividualNoticePageState createState() =>
      _IndividualNoticePageState();
}

class _IndividualNoticePageState extends State<IndividualNoticePage> {
  bool isLoading = false;
  bool showLoading = true;

  @override
  void initState() {
    super.initState();
  }

  String _formatDate(DateTime date) {
    final format = DateFormat.Hm('en_US').add_MMMMEEEEd();
    return format.format(date);
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
                      "${widget.notice.title}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Date ' + _formatDate(widget.notice.date.toDate()),
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
                    SizedBox(height: 5,),
                    Text(
                      "Description",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 12,),
                    Text(
                      "${widget.notice.description}",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                      textAlign: TextAlign.left,
                     // maxLines: 18,
                      
                    ),
                    SizedBox(height: 5,),
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
                    (widget.notice.moreDetailsLink != "")
                        ? ListTile(
                            title: Text(
                              "More Details",
                              
                              textAlign: TextAlign.left,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                              "${widget.notice.moreDetailsLink}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                              textAlign: TextAlign.left,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.attachment),
                              onPressed: () =>
                                  _launchURL(widget.notice.moreDetailsLink),
                            ))
                        : Container(
                            child: Text("No link attached"),
                          ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                )),
          )),
    ));
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
    deleteNoticefromDB(
      noticeID: widget.notice.id,
      classcode: widget.classcode,
    ).then((statusCode) {
      setState(() {
        this.isLoading = false;
      });
      switch (statusCode) {
        case 1:
          print('Deleted');
          Fluttertoast.showToast(
              msg: "Notice Deleted",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Notice Details",
            style: TextStyle(fontFamily: 'Archia', fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => EditNotice(
                              notice: widget.notice,
                              classcode: widget.classcode,
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
          slivers: <Widget>[_profileCard(), _descriptionCard(), _linksCard()],
        ));
  }
}
