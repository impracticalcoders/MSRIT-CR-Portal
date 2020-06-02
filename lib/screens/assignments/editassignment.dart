import 'package:crportal/components/uploadbutton.dart';
import 'package:crportal/models/assignment.dart';
import 'package:crportal/services/newassignmentbloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditAssignment extends StatefulWidget {
  final String classcode;
  final String assignmentid;
  final Assignment assignment;
  EditAssignment({Key key, this.classcode, this.assignmentid, this.assignment})
      : super(key: key);

  @override
  _EditAssignmentState createState() => _EditAssignmentState();
}

class _EditAssignmentState extends State<EditAssignment> {
  bool isLoading = false;
  bool showLoading = false;
  TextEditingController _titlecontroller,
      _descriptioncontroller,
      _subjectcodecontroller,
      _moredetailslinkcontroller,
      _submissionlinkcontroller;
  final _formKey = GlobalKey<FormState>();

  DateTime pickeddate;
  TimeOfDay time;
  DateTime dayandtime;


  void callDatePicker() async {
    var order = await getDate();
    if(order!=null)
    setState(() {
      pickeddate = order;
    });
  }

  Future<DateTime> getDate() {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime(2025),
      initialEntryMode: DatePickerEntryMode.calendar,
      builder: (BuildContext context, Widget child) {
        return child;
      },
    );
  }

  String _formatDate(DateTime date) {
    final format = DateFormat.Hm('en_US').add_MMMMEEEEd();
    return format.format(date);
  }

  @override
  void initState() {
    super.initState();
    this._titlecontroller =
        new TextEditingController(text: widget.assignment.title);
    this._descriptioncontroller =
        new TextEditingController(text: widget.assignment.description);
    this._moredetailslinkcontroller =
        new TextEditingController(text: widget.assignment.moreDetailsLink);
    this._subjectcodecontroller =
        new TextEditingController(text: widget.assignment.subjectCode);
    this._submissionlinkcontroller =
        new TextEditingController(text: widget.assignment.submitLink);
    setState(() {
      pickeddate = widget.assignment.deadline.toDate();
      time=TimeOfDay.fromDateTime(widget.assignment.deadline.toDate());
    });
  }  
  
  

  onPressSubmit() {
    if (!_formKey.currentState.validate()) {
    } else {
      setState(() {
        this.isLoading = true;
        this.dayandtime = new DateTime(
            this.pickeddate.year,
            this.pickeddate.month,
            this.pickeddate.day,
            this.time.hour,
            this.time.minute);
      });
      editAssignmentinDB(widget.assignmentid,
              classcode: widget.classcode,
              title: _titlecontroller.text,
              deadline: dayandtime,
              description: _descriptioncontroller.text,
              subjcode: _subjectcodecontroller?.text ?? "NESC",
              moredetailsurl: _moredetailslinkcontroller?.text ?? '',
              submissionurl: _submissionlinkcontroller?.text ?? '')
          .then((statusCode) {
        setState(() {
          this.isLoading = false;
        });
        switch (statusCode) {
          case 1:
            print('Updated');
            Fluttertoast.showToast(
                msg: "Details updated",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                textColor: Colors.white,
                fontSize: 16.0);
            Navigator.pop(context);
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
  }

  Widget _entryField(String title,
      {TextEditingController controllervar, bool isRequired = true}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
              validator: (value) {
                if (isRequired && value.isEmpty) {
                  return 'Please fill in this field';
                }
                return null;
              },
              // obscureText: isPassword,
              controller: controllervar,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  // fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

    Widget _deadlineSelector() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Deadline ${(dayandtime == null) ? '' : ' - ${_formatDate(dayandtime)} '}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ],
      ),
    );
  }

  _pickTime() async {
    TimeOfDay t = await showTimePicker(context: context, initialTime: time);
    if (t != null)
      setState(() {
        time = t;
      });
  }
  Widget _descriptionField(String title,
      {TextEditingController controllervar}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please fill in this field';
                }
                return null;
              },
              keyboardType: TextInputType.multiline,
              maxLines: 18,
              controller: controllervar,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  // fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _formfieldswidgets() {
    return Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            _entryField("Title", controllervar: _titlecontroller),
            _entryField("Subject Code",
                controllervar: _subjectcodecontroller, isRequired: false),
            _deadlineSelector(),
            ListTile(
              title: Text(
                  "${DateFormat.EEEE("en_US").add_yMMMMd().format(pickeddate)}"),
              trailing: Icon(Icons.calendar_today),
              onTap: callDatePicker,
            ),
            ListTile(
              title: Text("${time.format(context)}"),
              trailing: Icon(Icons.access_time),
              onTap: _pickTime,
            ),
            _descriptionField("Description",
                controllervar: _descriptioncontroller),
            _entryField("Attachments URL",
                controllervar: _moredetailslinkcontroller, isRequired: false),
            UploadButton(attachmentController:_moredetailslinkcontroller),

            _entryField("Submission Link",
                controllervar: _submissionlinkcontroller, isRequired: false),
          ],
          physics: BouncingScrollPhysics(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(tag:'edit${widget.assignment.AssignmentID}',child:Text('Edit Assignment')),
        actions: <Widget>[
          FlatButton(
            child: isLoading
                ? CupertinoActivityIndicator()
                : Text(
                    'Update',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
            onPressed: () {
              onPressSubmit();
            },
          )
        ],
      ),
      body: Center(
        child:
            Padding(padding: EdgeInsets.all(10), child: _formfieldswidgets()),
      ),
    );
  }
}
