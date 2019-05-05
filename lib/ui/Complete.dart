import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Complete extends StatefulWidget {
  @override
  CompleteWidgetState createState() => new CompleteWidgetState();
}

class CompleteWidgetState extends State<Complete> {

  Firestore _firestore = Firestore();

  Widget getTaskListView() {
    TextStyle titleStyle = Theme.of(context).textTheme.subhead;

    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.hasData && snapshot.data.documents.length != 0){
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                color: Colors.white,
                elevation: 2.0,
                child: ListTile(
                  title: Text(snapshot.data.documents.elementAt(index).data['title']),
                  trailing: Checkbox(
                    value: snapshot.data.documents.elementAt(index).data['done'] == 1,
                    onChanged: (bool value) {
                      setState(() {
                       _firestore.collection('todo')
                       .document(snapshot.data.documents.elementAt(index).documentID)
                       .setData({
                         'title': snapshot.data.documents.elementAt(index).data['title'],
                         'done': 0
                       });
                      });
                    },
                  ),
                ),
              );
            });
        }
        else{
          return Center(child: Text('No data found...'));
        }
      },
      stream: _firestore.collection('todo').where('done', isEqualTo: 1).snapshots(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
      return Scaffold(
          appBar: AppBar(
            title: const Text("Todo"),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  _deleteAllNote();
                },
              )
            ],
          ),
          body: Center(
            child: getTaskListView(),
          ));
    }

    _deleteAllNote(){
      return _firestore.collection('todo')
      .where('done', isEqualTo: 1).getDocuments()
      .then((d){
        d.documents.forEach((r){
          r.reference.delete();
        });
      });
    }
}
