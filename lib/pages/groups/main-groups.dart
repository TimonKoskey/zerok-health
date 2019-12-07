import 'package:flutter/material.dart';
import './groups-list.dart';

import './create-group.dart';

class GroupsContainer extends StatefulWidget {
  @override
  _GroupsContainerState createState() => _GroupsContainerState();
}

class _GroupsContainerState extends State<GroupsContainer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: GroupsList(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateGroup()),
          );
        },
        label: Text('new group'),
        icon: Icon(
          Icons.add,
        ),
        backgroundColor: Colors.green,
      ),
    );
  }
}