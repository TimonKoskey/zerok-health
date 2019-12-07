import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';

class CreateGroup extends StatefulWidget {
  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  List<Contact> contacts;
  List<Contact> addedMembers = List();

  _getUserContacts() async {
    var iterContacts = await ContactsService.getContacts(withThumbnails: false);
    setState((){
      contacts = iterContacts.toList();
    });
  } 

  @override
  void initState() {
    _getUserContacts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('select members'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            addedMembers.isNotEmpty? Container(
              child: Column(
                children: <Widget>[
                  // Text('added members'),
                ],
              ),
            ): Container(),
            Container(
              child: contacts == null? CircularProgressIndicator()
              : Expanded(
                child: ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (context, index){
                    var contactNumbers;
                    contacts[index].phones != null? contactNumbers = contacts[index].phones.toList()
                    : contactNumbers = null;
                    return ListTile(
                      title: Text(contacts[index].displayName),
                      subtitle: Text(contactNumbers != null? contactNumbers[0].value : ''),
                      onTap: (){
                        setState(() {
                          addedMembers.add(contacts[index]);
                        });
                      },
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}