import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BloodPressureFormContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BloodPressureForm(),
    );
  }
}

class BloodPressureForm extends StatefulWidget {
  @override
  _BloodPressureFormState createState() => _BloodPressureFormState();
}

class _BloodPressureFormState extends State<BloodPressureForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final BloodPressureInputs _user = BloodPressureInputs();

  var inputCount = 1;
  var showBPForm = true;
  final inputCountPhrase = ['FIRST TEST','SECOND TEST','THIRD (FINAL) TEST'];
  var averageBloodPressure;

  _countUserInput(){
    setState(() { 
      // inputCount >= 3? inputCount = 1: inputCount += 1;
      if(inputCount >= 3){
        _user.postToDatabase();
        averageBloodPressure = BloodPressureInputs.finalInputsObj;
        showBPForm = false;
        inputCount = 1;
        print(averageBloodPressure.toString());
      } else{
        inputCount += 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return SingleChildScrollView(
          child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: viewportConstraints.maxHeight,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Card(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: showBPForm?
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    // leading: Icon(Icons.album),
                    title: Text('Take the test 3 times for accuracy'),
                    subtitle: Text(inputCountPhrase[inputCount - 1]),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(children: <Widget>[
                      TextFormField(
                        decoration:
                          InputDecoration(labelText: 'systolic input'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'this field is required';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            _user.systolicPressure = value;
                          });
                        },
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'diastolic input'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'this field is required';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            _user.diastolicPressure = value;
                          });
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: 'pulse rate input'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'this field is required';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            _user.pulseRate = value;
                          });
                        },
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 16.0),
                        child: RaisedButton(
                          onPressed: () {
                            final form = _formKey.currentState;
                            if (form.validate()) {
                              form.save();
                              _user.save();
                              form.reset();
                              _countUserInput();
                            }
                          },
                          child: Text('Save'),
                        ),
                      ),
                    ]),
                  ),
                ],
              )
                : Container(),
            ),
          ),
        ),
      ));
    });
  }
}

class BloodPressureInputs {
  String systolicPressure = '';
  String diastolicPressure = '';
  String pulseRate = '';

  static var inputsObjectsList = List();
  var finalInputsObject = Map();
  static var finalInputsObj;

  save(){
    var inputsObject = {
      'SBP': systolicPressure,
      'DBP': diastolicPressure,
      'pulse_rate': pulseRate
    };

    inputsObjectsList.add(inputsObject);

    print(inputsObject);
  }
  postToDatabase() async{
    var totalSBP = 0;
    var totalDBP = 0;
    var totalPulseRate = 0;

    var listLength = inputsObjectsList.length;

    if (inputsObjectsList.isNotEmpty){
      inputsObjectsList.forEach((input){
        totalSBP += int.parse(input['SBP']);
        totalDBP += int.parse(input['DBP']);
        totalPulseRate += int.parse(input['pulse_rate']);
      });
    }

    finalInputsObj = {
      'SBP': (totalSBP/listLength).toString(),
      'DBP': (totalDBP/listLength).toString(),
      'pulse_rate': (totalPulseRate/listLength).toString(),
    };
    await Firestore.instance.collection('patient records').add(finalInputsObj);
    print(finalInputsObj);
  }
}
