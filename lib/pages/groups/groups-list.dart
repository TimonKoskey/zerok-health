import 'package:flutter/material.dart';
import './group-messages.dart';

class GroupsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
              leading: FlutterLogo(size: 56.0),
              title: Text('Example group 1 name'),
              subtitle: Text('Last update from group'),
              trailing: Icon(Icons.more_vert),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Messages()),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: FlutterLogo(size: 56.0),
              title: Text('Example group 2 name'),
              subtitle: Text('Last update from group'),
              trailing: Icon(Icons.more_vert),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Messages()),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: FlutterLogo(size: 56.0),
              title: Text('Example group 3 name'),
              subtitle: Text('Last update from group'),
              trailing: Icon(Icons.more_vert),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Messages()),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: FlutterLogo(size: 56.0),
              title: Text('Example group 4 name'),
              subtitle: Text('Last update from group'),
              trailing: Icon(Icons.more_vert),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Messages()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}