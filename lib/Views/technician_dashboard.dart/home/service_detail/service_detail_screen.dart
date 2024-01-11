import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rpm/Views/driver_dashboard/widgets/network_image_widget.dart';
import 'package:rpm/Views/driver_dashboard/widgets/round_button.dart';
import 'package:rpm/utils/app_colors.dart';
import 'package:rpm/utils/utils.dart';

class ServicedetailScreen extends StatefulWidget {
  final snap;
  const ServicedetailScreen({super.key, required this.snap});

  @override
  State<ServicedetailScreen> createState() => _ServicedetailScreenState();
}

class _ServicedetailScreenState extends State<ServicedetailScreen> {
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.blackColor,
            )),
        title: Text('Service Details'),
        backgroundColor: Colors.grey.shade300,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.only(bottom: 20, top: 50, right: 20, left: 20),
              height: 340,
              width: double.infinity,
              color: Colors.grey.shade300,
              child: Column(
                children: [
                  ReusableRow(title: 'Service Address', value: ''),
                  ReusableRow(title: 'VIN #', value: widget.snap['vin']),
                  ReusableRow(
                      title: 'Current Mileage',
                      value: widget.snap['currentMileage']),
                  ReusableRow(
                      title: 'Engine Hours', value: widget.snap['engineHours']),
                  ReusableRow(
                      title: 'Complaint', value: widget.snap['complaint']),
                  ReusableRow(title: 'Complaint', value: widget.snap['status']),
                  RoundButton(
                    title: 'Attached image',
                    onPress: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => Scaffold(
                      //             appBar: AppBar(),
                      //             body: Center(
                      //               child: InteractiveViewer(
                      //                   child: NetworkImageWidget(
                      //                 borderRadius: 0,
                      //                 imageUrl: widget.snap['image'],
                      //                 width: MediaQuery.of(context).size.width,
                      //                 height: MediaQuery.of(context).size.width,
                      //               )),
                      //             ))));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Scaffold(
                                    appBar: AppBar(),
                                    body: ListView.builder(
                                      itemCount: widget.snap['image'].length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          margin: EdgeInsets.all(8.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder:
                                                          (context) => Scaffold(
                                                                appBar:
                                                                    AppBar(),
                                                                body: Center(
                                                                  child:
                                                                      InteractiveViewer(
                                                                          child:
                                                                              NetworkImageWidget(
                                                                    borderRadius:
                                                                        0,
                                                                    imageUrl: widget
                                                                            .snap['image']
                                                                        [index],
                                                                    width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width,
                                                                    height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width,
                                                                  )),
                                                                ),
                                                              )));
                                            },
                                            child: Image.network(
                                              widget.snap['image'][index],
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  )));
                    },
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 240,
              child: RoundButton(
                onPress: () {
                  if (widget.snap['status'] != 'completed') {
                    final TextEditingController _textFieldController =
                        TextEditingController();
                    showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Mark Service as Complete'),
                            content: SizedBox(
                              width: double.maxFinite,
                              child: TextField(
                                controller: _textFieldController,
                                maxLines: null, // Set to null for multiline
                                decoration: InputDecoration(
                                  hintText: 'Enter service completion notes',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),
                              SizedBox(
                                width: 90,
                                height: 40,
                                child: RoundButton(
                                  loading: _loading,
                                  title: 'Submit',
                                  onPress: () {
                                    // setState(() => _loading = true);
                                    try {
                                      FirebaseFirestore.instance
                                          .collection('service')
                                          .doc(widget.snap['docId'])
                                          .update({
                                        'status': 'completed',
                                        'technicianNotes':
                                            _textFieldController.text.trim(),
                                      });
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                      Utils.flushBarDoneMessage(
                                        'Your service submission has been recieved',
                                        context,
                                      );
                                    } catch (e) {
                                      Utils.flushBarErrorMessage(
                                          e.toString(), BuildContext, context);
                                      Navigator.of(context).pop();
                                    }
                                    // Access the text field value using _textFieldController.text
                                  },
                                ),
                              )
                            ],
                          );
                        });
                  }
                },
                title: widget.snap['status'] != 'completed'
                    ? 'Mark service as complete'
                    : 'Completed',
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  final String title;
  final String value;
  const ReusableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                  color: AppColors.blackColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              value,
              style: TextStyle(
                  color: AppColors.blackColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
