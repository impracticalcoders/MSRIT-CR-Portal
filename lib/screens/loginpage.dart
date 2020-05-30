import 'package:crportal/services/authservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = new GlobalKey<FormState>();
  final crListApiUrl =
      'https://spreadsheets.google.com/feeds/cells/1sLH-CtLYAVcEM1y681hBPhof9mnhlM7itOKGUVCA-n0/1/public/full?alt=json';
  final deptListApiUrl =
      'https://spreadsheets.google.com/feeds/cells/1sLH-CtLYAVcEM1y681hBPhof9mnhlM7itOKGUVCA-n0/2/public/full?alt=json';
  String phoneNo, verificationId, smsCode, rawPhoneNo, dept, sem, sec;
  List<String> crList = new List();
  bool codeSent = false;
  bool isLoading = true;
  List<DropdownMenuItem<String>> deptItems = new List();
  List<DropdownMenuItem<String>> secItems = new List();
  List<DropdownMenuItem<String>> semItems = new List();
  void initState() {
    super.initState();
    _getcrlist();
    _getdeptlist();
    _generatesectionslist();
    _generatesemesterslist();
  }

  _getcrlist() async {
    var response = await http.get(crListApiUrl);
    var data = jsonDecode(response.body);
    // print(data);
    List<dynamic> items = data['feed']['entry'];

    setState(() {
      this.crList =
          items.map((item) => item['content']['\$t'].toString()).toList();

      this.isLoading = false;
    });
    print(this.crList);
  }

  _getdeptlist() async {
    var response = await http.get(deptListApiUrl);
    var data = jsonDecode(response.body);
    // print(data);
    List<dynamic> items = data['feed']['entry'];

    setState(() {
      this.deptItems = items
          .map((item) => new DropdownMenuItem(
                value: item['content']['\$t'].toString(),
                child: Text(item['content']['\$t'].toString()),
              ))
          .toList();

      this.isLoading = false;
    });
  }

  _generatesemesterslist() {
    for (int i = 1; i <= 8; i++) {
      semItems.add(DropdownMenuItem(
        value: i.toString(),
        child: Text(i.toString()),
      ));
    }
  }
  
  _generatesectionslist() {
    for (int i = 'A'.codeUnitAt(0); i <= 'Z'.codeUnitAt(0); i++) {
      secItems.add(DropdownMenuItem(
        value: String.fromCharCode(i),
        child: Text(String.fromCharCode(i)),
      ));
    }
  }

  bool _checkifCR(String phnumberentered) {
    if (crList.contains(dept+sem+sec+phnumberentered))
      return true;
    else
      return false;
  }

   //Save to device
  Future<void> saveData(String _sem,String _sec,String _dept) async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.setString('Branch', _dept);
    prefs.setString('Sem', _sem);
    prefs.setString('Sec', _sec);
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: formKey,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 100,),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 25),
                  child: CircleAvatar(
                    child: Image.asset('assets/userDefault.png'),
                    radius: 80.0,
                  )),
              Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: ListTile(
                      leading: Icon(Icons.phone),
                      title: TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: ' Enter your phone number',
                          prefixText: '+91',
                        ),
                        onChanged: (val) {
                          setState(() {
                            this.phoneNo = '+91' + val;
                            this.rawPhoneNo = val;
                          });
                        },
                        autovalidate: true,
                        validator: (val){
                          if(val.length!=10){
                            return  'Enter a valid phone number';
                          }
                          return null;
                        },
                      ))),
              Padding(
                  padding: EdgeInsets.only(top: 10, left: 25.0, right: 25.0),
                  child: ListTile(
                      leading: Icon(Icons.business),
                      title: DropdownButton<String>(
                        items: deptItems,
                        onChanged: (value) {
                          setState(() {
                            dept = value;
                          });
                        },
                        value: dept,
                        isExpanded: true,
                        hint: Text('Choose your branch'),
                      ))),
              Padding(
                  padding: EdgeInsets.only(top: 10, left: 25.0, right: 25.0),
                  child: ListTile(
                      leading: Icon(Icons.av_timer),
                      title: DropdownButton<String>(
                        items: semItems,
                        onChanged: (value) {
                          setState(() {
                            sem = value;
                          });
                        },
                        value: sem,
                        isExpanded: true,
                        hint: Text('Choose your semester'),
                      ))),
              Padding(
                  padding: EdgeInsets.only(top: 10, left: 25.0, right: 25.0),
                  child: ListTile(
                      leading: Icon(Icons.supervisor_account),
                      title: DropdownButton<String>(
                        items: secItems,
                        onChanged: (value) {
                          setState(() {
                            sec = value;
                          });
                        },
                        value: sec,
                        isExpanded: true,
                        hint: Text('Choose your section'),
                      ))),
              codeSent
                  ? Padding(
                      padding: EdgeInsets.only(left: 25.0, right: 25.0),
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            hintText: 'Enter OTP',
                            prefixIcon: Icon(Icons.vpn_key)),
                        onChanged: (val) {
                          setState(() {
                            this.smsCode = val;
                          });
                        },
                      ))
                  : Container(),
              Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 10),
                  child: RaisedButton(
                      child: Center(
                          child: codeSent
                              ? Text(
                                  'Login',
                                  style: TextStyle(fontSize: 20),
                                )
                              : Text(
                                  'Verify',
                                  style: TextStyle(fontSize: 20),
                                )),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      onPressed: () {
                        if (sem!=null&&dept!=null&&sec!=null&&_checkifCR(this.rawPhoneNo)) {
                          print("CR found");
                          Fluttertoast.showToast(
                              msg:
                                  "Your number is authorized for a CR Account.\nAttempting auto-verfication of OTP",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              textColor: Colors.white,
                              fontSize: 16.0);

                          AuthService().savePhoneNumber(this.phoneNo);
                          codeSent
                              ? AuthService()
                                  .signInWithOTP(smsCode, verificationId)
                              : verifyPhone(phoneNo);
                          saveData(sem, sec, dept);
                        } else {
                          print("Not a CR");
                          Fluttertoast.showToast(
                              msg:
                                  "Your number is not authorized for a CR Account in this class",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      }))
            ],
          ))),
    );
  }

  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthService().signIn(authResult);
    };

    final PhoneVerificationFailed verificationfailed =
        (AuthException authException) {
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      setState(() {
        this.codeSent = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }
}
