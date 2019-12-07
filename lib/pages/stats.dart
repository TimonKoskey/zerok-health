import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import './bloodpressure.dart';
import './bpform.dart';

class DiaryContainerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            // RaisedButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => BloodPressureFormContainer(),
            //       ),
            //     );
            //   },
            //   textColor: Colors.white,
            //   padding: const EdgeInsets.all(0.0),
            //   child: Container(
            //     decoration: const BoxDecoration(
            //       gradient: LinearGradient(
            //         colors: <Color>[
            //           Color(0xFF0D47A1),
            //           Color(0xFF1976D2),
            //           Color(0xFF42A5F5),
            //         ],
            //       ),
            //     ),
            //     padding: const EdgeInsets.all(10.0),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: <Widget>[
            //         Icon(FontAwesomeIcons.plus),
            //         Text(
            //           'Add New Entry',
            //           style: TextStyle(fontSize: 20),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            Expanded(
              child: StatsPage(),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BloodPressureFormContainer(),
            ),
          );
        },
        // label: Text('new entry'),
        child: Icon(
          Icons.add,
        ),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

class StatsPage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<StatsPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('patient records').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LinearProgressIndicator();
        } else {
          var pressureList = List();
          snapshot.data.documents.forEach((data) {
            var newData = BloodPressure.fromSnapShot(data);
            pressureList.add(newData);
          });

          pressureList.sort((b, a) => a.id.compareTo(b.id));
          return Container(
              child: ListView.builder(
            itemCount: pressureList.length,
            itemBuilder: (context, index) {
              return _buildDairyEntryCard(context, pressureList[index]);
            },
          ));
        }
      },
    );
  }
}

Widget _buildDairyEntryCard(BuildContext context, BloodPressure pressure) {
  BloodPressure pressureRecord;
  pressureRecord = pressure;
  DateTime dateTime = pressure.date.toDate();

  Color color = Theme.of(context).primaryColor;
  return SizedBox(
    child: Card(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(new DateFormat.yMMMd().format(dateTime)),
              Text(new DateFormat.jm().format(dateTime)),
            ],
          ),
          Divider(),
          _buttonSection(color, pressureRecord),
          // Divider(),
          // ListTile(
          //   title: Text(pressureRecord.id.toString(),
          //   style: TextStyle(color: Colors.green[500])
          //   )
          // ),
        ],
      ),
    ),
  );
}

Widget _buttonSection(Color color, BloodPressure pressure) {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buttonColumn(color, 'Systolic BP', pressure.systolicPressure, 'mmHg'),
        _buttonColumn(
            color, 'Diastolic BP', pressure.diastolicPressure, 'mmHg'),
        _buttonColumn(color, 'pulse rate', pressure.pulseRate, '/min'),
      ],
    ),
  );
}

Widget _buttonColumn(Color color, String title, String value, String unit) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 15),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(color: color),
        ),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
        Text(unit),
      ],
    ),
  );
}
