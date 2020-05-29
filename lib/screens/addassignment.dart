import 'package:flutter/material.dart';

class AddAssignment extends StatefulWidget {
  AddAssignment({Key key}) : super(key: key);

  @override
  _AddAssignmentState createState() => _AddAssignmentState();
}

class _AddAssignmentState extends State<AddAssignment> {
  bool isLoading = false;
  bool showLoading = true;
  TextEditingController _titlecontroller,
      _descriptioncontroller,
      _subjectcodecontroller,
      _moredetailslinkcontroller,
      _submissionlinkcontroller;
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  var finaldate;

  void callDatePicker() async {
    var order = await getDate();
    setState(() {
      finaldate = order;
    });
  }

  Future<DateTime> getDate() {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime(2022),
      initialEntryMode: DatePickerEntryMode.input,
      builder: (BuildContext context, Widget child) {
        return child;
      },
    );
  }

  @override
  void initState() {
    super.initState();

    this._titlecontroller = new TextEditingController();
    this._descriptioncontroller = new TextEditingController();
    this._moredetailslinkcontroller = new TextEditingController();
    this._subjectcodecontroller = new TextEditingController();
    this._submissionlinkcontroller=new TextEditingController();
  }

  Widget _entryField(String title, {TextEditingController controllervar}) {
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

  Widget _deadlineSelector(){
   return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Deadline ${(finaldate == null) ? '' : ' - $finaldate '}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              SizedBox(
                height: 10,
              ),
              new RaisedButton(
                onPressed: callDatePicker,
                child: new Text(
                  '${(finaldate == null) ? 'Set Deadline' : 'Change'}',
                ),
              ),
            ],
          ),
        );
  } 
  Widget _descriptionField(String title, {TextEditingController controllervar}) {
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
    return 
    ListView(
      children: <Widget>[
        _entryField("Title", controllervar: _titlecontroller),
        _entryField("Subject Code", controllervar: _subjectcodecontroller),
        _deadlineSelector(),
        _descriptionField("Description", controllervar: _descriptioncontroller),
        
        _entryField("Attachments URL",
            controllervar: _moredetailslinkcontroller),
        _entryField("Submission Link",
            controllervar: _submissionlinkcontroller),
      ],
    physics: BouncingScrollPhysics(),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Assignment'),
        actions: <Widget>[
          FlatButton(
            child: Text("ADD"),
            onPressed: () {},
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
