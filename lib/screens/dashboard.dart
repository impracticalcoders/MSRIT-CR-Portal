import 'package:crportal/screens/assignments/assignmentsscreen.dart';
import 'package:crportal/screens/exams/testsscreen.dart';
import 'package:crportal/screens/notice/noticesscreen.dart';
import 'package:crportal/services/authservice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with SingleTickerProviderStateMixin {
    TabController _tabController;
    bool isLoading = true;
    String branch=' ',sem=' ',sec=' ';
    String classcode='NA';
     @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this);
    _loadClassDetails();
    super.initState();
  }

  _loadClassDetails() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String branch = await pref.get("Branch");
    String sem = await pref.get("Sem");
    String sec = await pref.get("Sec");
      setState(() {
        this.branch = branch;
        this.sem=sem;
        this.sec=sec;
        this.classcode=branch+sem+sec;
        this.isLoading = false;
      });
  }
  

  @override
  Widget build(BuildContext context) {
    return isLoading?
    CupertinoActivityIndicator():
    Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(branch+' '+sem+' '+sec),
        actions: <Widget>[IconButton(
          icon: Icon(
            Icons.exit_to_app,
            color: Colors.red,
          ),
          onPressed: () async {
            AuthService().signOut();
            Navigator.pushReplacement(
                context,
                new MaterialPageRoute(
                    builder: (context) => AuthService().handleAuth()));
          },
        ),],
         bottom: TabBar(
                unselectedLabelColor: Colors.white,
                labelColor: Colors.blue[50],
                tabs: [
                  new Tab(
                    icon: new Icon(Icons.speaker_phone),
                    text: 'Notices',
                  ),
                  new Tab(
                    icon: new Icon(Icons.assignment),
                    text: 'Assignments',
                  ),
                  new Tab(
                    icon: new Icon(Icons.change_history),
                    text: 'Tests',
                  ),
                ],
                controller: _tabController,
                indicatorColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.tab,
              ),
              bottomOpacity: 1,
              elevation: 1.0,
      ),
      body:  TabBarView(
              physics: BouncingScrollPhysics(),
              children: [
                NoticesScreen(classcode: classcode),
                AssignmentsScreen(classcode: classcode,),
                TestsScreen(classcode: classcode,)
              ],
              controller: _tabController,
            ),
    );
  }
}
