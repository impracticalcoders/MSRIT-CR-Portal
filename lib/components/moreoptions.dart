
import 'package:crportal/services/authservice.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreOptions extends StatefulWidget {
  @override
  _MoreOptionsState createState() => _MoreOptionsState();
}

class _MoreOptionsState extends State<MoreOptions> {
  Choice _selectedChoice ;

  void _select(Choice choice) {
    setState(() {
      _selectedChoice = choice;
    });
  }

  List<Choice> choices =  <Choice>[
  
   
    Choice(
      title: 'About', 
      icon: Icons.info,
      onPressed: (context){
          showAboutDialog(context: context);
        },
    ),
    Choice(
      title: 'View Source Code', 
      icon: Icons.code,
      onPressed: (context)async{
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
      onPressed: (context){
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
    return 
    PopupMenuButton<Choice>(
        onSelected: _select,
        itemBuilder: (BuildContext context) {
          return choices.map((Choice choice) {
            return PopupMenuItem<Choice>(
              value: choice,
              child: ChoiceCard(choice: choice,),
            );
          }).toList();
        },
      );
          
        
  }
}

class Choice {
  Choice({this.title, this.icon,this.onPressed});
   String title;
   IconData icon;
   Function onPressed;
}


class ChoiceCard extends StatelessWidget {
  ChoiceCard({Key key, this.choice}) : super(key: key);

  Choice choice;

        
  @override
  Widget build(BuildContext context) {
    return  FlatButton(
        child: Row(children: <Widget>[
         Expanded(child: Text(choice.title,style: TextStyle(fontSize: 15),)),
         Icon(choice.icon),
        
        ],),
        onPressed: () => choice.onPressed(context),
    );
    
  }
}
