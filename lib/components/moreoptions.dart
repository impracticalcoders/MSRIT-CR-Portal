import 'package:crportal/services/authservice.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreOptions extends StatefulWidget {
  String classcode;
  MoreOptions({this.classcode = ' '});
  @override
  _MoreOptionsState createState() => _MoreOptionsState();
}

class _MoreOptionsState extends State<MoreOptions> {
  Choice _selectedChoice;

  void _select(Choice choice) {
    setState(() {
      _selectedChoice = choice;
    });
  }

  List<Choice> choices = <Choice>[
    Choice(
      title: 'About',
      icon: Icons.info,
      onPressed: (context) {
        showAboutDialog(
            context: context,
            applicationIcon: CircleAvatar(
              backgroundColor: Colors.deepPurple,
              child: Icon(Icons.assignment, color: Colors.white),
            ),
            applicationName: "CR Portal",
            children: <Widget>[
              Text("Developed by"),
              ListTile(
                contentPadding: EdgeInsets.all(1),
                title: Text("Aakash Pothepalli"),
                leading: IconButton(
                    icon: Image.asset("assets/GitHubdark.png"),
                    onPressed: () async {
                      const url =
                          'https://github.com/aakashpothepalli';
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    }),
              ),
              ListTile(
                contentPadding: EdgeInsets.all(1),
                title: Text("Suraj Kumar"),
                leading: IconButton(
                  icon: Image.asset("assets/GitHubdark.png"),
                   onPressed: () async {
                      const url =
                          'https://github.com/psk907';
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    }
                ),
              ),
            ]);
      },
    ),
    Choice(
        title: 'Go to Website',
        icon: Icons.open_in_browser,
        onPressed: (context) async {
          const url = 'https://ritassignmentstracker.tk/';
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            throw 'Could not launch $url';
          }
        }),
    Choice(
      title: 'View Source Code',
      icon: Icons.code,
      onPressed: (context) async {
        const url = 'https://github.com/teamimpracticalcoders/MSRIT-CR-Portal';
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
      },
    ),
    Choice(
      title: 'Sign Out',
      icon: Icons.exit_to_app,
      onPressed: (context) {
        AuthService().signOut();
        Navigator.pushReplacement(
            context,
            new MaterialPageRoute(
                builder: (context) => AuthService().handleAuth()));
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Choice>(
      onSelected: _select,
      itemBuilder: (BuildContext context) {
        return choices.map((Choice choice) {
          return PopupMenuItem<Choice>(
            value: choice,
            child: ChoiceCard(
              choice: choice,
            ),
          );
        }).toList();
      },
    );
  }
}

class Choice {
  Choice({this.title, this.icon, this.onPressed});
  String title;
  IconData icon;
  Function onPressed;
}

class ChoiceCard extends StatelessWidget {
  ChoiceCard({Key key, this.choice}) : super(key: key);

  Choice choice;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Row(
        children: <Widget>[
          Expanded(
              child: Text(
            choice.title,
            style: TextStyle(fontSize: 15),
          )),
          Icon(choice.icon),
        ],
      ),
      onPressed: () => choice.onPressed(context),
    );
  }
}
