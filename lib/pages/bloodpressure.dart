import 'package:cloud_firestore/cloud_firestore.dart';

class BloodPressure{
  final String systolicPressure;
  final String diastolicPressure;
  final String pulseRate;
  final String status;
  final Timestamp date;
  final int id;
  final DocumentReference reference;

  BloodPressure.fromMap(Map<String, dynamic> map, {this.reference})
    : assert(map['SBP'] != null),
      assert(map['DBP'] != null),
      assert(map['pulse_rate'] != null),
      assert(map['id'] != null),
      assert(map['status'] != null),
      assert(map['date'] != null),
      systolicPressure = map['SBP'],
      diastolicPressure = map['DBP'],
      id = map['id'],
      pulseRate = map['pulse_rate'],
      status = map['status'],
      date = map['date'];

  BloodPressure.fromSnapShot(DocumentSnapshot snapshot)
    : this.fromMap(snapshot.data, reference: snapshot.reference);
}