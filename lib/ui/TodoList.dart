import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TodoList extends StatefulWidget {
  @override
  TodoListWidgetState createState() => new TodoListWidgetState();
}

class TodoListWidgetState extends State<TodoList> {

  Widget getTaskListView() {
    TextStyle titleStyle = Theme.of(context).textTheme.subhead;
    Firestore _firestore = Firestore();

    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.hasData && snapshot.data.documents.length != 0) {
        return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                color: Colors.white,
                elevation: 2.0,
                child: ListTile(
                  title: Text(snapshot.data.documents.elementAt(index).data['title']),
                  trailing: Checkbox(
                    value: snapshot.data.documents.elementAt(index).data['done'] != 0,
                    onChanged: (bool value) {
                      setState(() {
                        _firestore.collection('todo')
                        .document(snapshot.data.documents.elementAt(index).documentID)
                        .setData({
                          'title': snapshot.data.documents
                          .elementAt(index).data['title'],
                          'done': 1
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
    stream: _firestore.collection('todo').where('done', isEqualTo: 0).snapshots(),
    );
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Todo"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                //push to task page
                debugPrint('Add button');
                Navigator.pushNamed(context, "/newSub");
              },
            )
          ],
        ),
        body: Center(
          child: getTaskListView(),
        ),
      );
    }
}
