import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rpm/controllers/services/session_manager.dart';
import 'package:rpm/utils/utils.dart';
import 'package:rpm/widgets/round_button.dart';
import 'package:uuid/uuid.dart';

class HelpScreen extends StatefulWidget {
  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  bool? isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help Form'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(color: Colors.blue), // Change input text color
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _descriptionController,
                style: TextStyle(color: Colors.blue), // Change input text color
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                maxLines: 5,
              ),
              SizedBox(height: 20),
              RoundButton(
                title: 'Submit',
                loading: isLoading!,
                onPress: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() => isLoading = true);
                    // Form is validated, perform your action here
                    String title = _titleController.text;
                    String description = _descriptionController.text;
                    // You can handle the submission logic here
                    // For now, let's print the values
                    print('Title: $title');
                    print('Description: $description');
                    var docId = Uuid().v4();
                    FirebaseFirestore.instance
                        .collection('help')
                        .doc(docId)
                        .set({
                      'docId': docId,
                      'title': title,
                      'description': description,
                      'name': SessionController().name,
                      'userId': SessionController().userId,
                    }).then((value) {
                      setState(() => isLoading = false);
                      Utils.flushBarDoneMessage('Form Submited', context);
                      _titleController.clear();
                      _descriptionController.clear();
                    });
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
