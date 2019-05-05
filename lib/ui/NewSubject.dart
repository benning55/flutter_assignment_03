import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewSubject extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NewSubjectState();
  }
}

class NewSubjectState extends State<NewSubject> {

  final _formKey = GlobalKey<FormState>();
  Firestore _firestore = Firestore();


  @override
  Widget build(BuildContext context) {
    TextEditingController data = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Subject'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            moveToLastScreen();
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
            child: ListView(
              children: <Widget>[
                TextFormField(
                  controller: data,
                  decoration: InputDecoration(
                    labelText: "Subject",
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please fill subject';
                    }
                  },
                ),
                RaisedButton(
                  onPressed: () {
                    debugPrint(data.text);
                    print(data.text);
                    if (_formKey.currentState.validate()) {
                      _firestore.collection('todo').add(
                        {'title': data.text, 'done': 0}
                      ).then((r){
                        moveToLastScreen();
                      });
                    }
                  },
                  child: Text("Save"),
                )
              ],
            )),
      ),
    );
  }

  void moveToLastScreen() {
    Navigator.pop(context);
  }
}
