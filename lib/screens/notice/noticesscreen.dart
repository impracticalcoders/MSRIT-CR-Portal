import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crportal/components/noticecard.dart';
import 'package:crportal/models/notice.dart';
import 'package:crportal/screens/notice/addnotice.dart';
import 'package:flutter/material.dart';

class NoticesScreen extends StatefulWidget {
    final String classcode;

  NoticesScreen({Key key, this.classcode}) : super(key: key);

  @override
  _NoticesScreenState createState() => _NoticesScreenState();
}

class _NoticesScreenState extends State<NoticesScreen> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection('classCodes')
                  .document(widget.classcode)
                  .collection("notices")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Notice> currentNotices = snapshot.data.documents
                      .map((doc) => Notice.fromJson(doc))
                      .toList();

                  if (currentNotices.length == 0)
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.speaker_phone,
                            size: 80,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: 35,
                          ),
                          Text(
                            'No Notices',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    );
                  currentNotices
                      .sort((a, b) => -a.date.compareTo(b.date));
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (index >= currentNotices.length) return null;
                     
                        return NoticeCard(notice: currentNotices[index],classcode: widget.classcode,);
                      
                    },
                  );
                } 
                
                else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
          
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Add'),
        icon: Icon(Icons.add_circle_outline),
        onPressed: (){
Navigator.of(context).push(new MaterialPageRoute<Null>(
      builder: (BuildContext context) {
        return new AddNotice(classcode: widget.classcode,);
      },
    fullscreenDialog: true
  ));

        },
      ),
    );
  }

}
