import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:rpm/Views/driver_dashboard/widgets/network_image_widget.dart';
import 'package:rpm/Views/driver_dashboard/widgets/round_button.dart';
import 'package:rpm/Views/manager_dashboard.dart/manager_dashboard.dart';
import 'package:rpm/controllers/services/session_manager.dart';
import 'package:rpm/utils/app_colors.dart';
import 'package:rpm/utils/utils.dart';
import 'package:video_player/video_player.dart';

class ManagerServicedetailScreen extends StatefulWidget {
  final snap;
  const ManagerServicedetailScreen({super.key, required this.snap});

  @override
  State<ManagerServicedetailScreen> createState() =>
      _ManagerServicedetailScreenState();
}

class _ManagerServicedetailScreenState
    extends State<ManagerServicedetailScreen> {
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
              // height: widget.snap['additionalVideo'] != '' ? 600 : 470,
              width: double.infinity,
              color: Colors.grey.shade300,
              child: Column(
                children: [
                  if (widget.snap['type'] == 'emg')
                    ReusableRow(title: 'Service Address:', value: ''),
                  if (widget.snap['type'] == 'emg')
                    Text(
                      widget.snap['location'] != null
                          ? widget.snap['location']
                          : '',
                      style: TextStyle(
                          color: AppColors.blackColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ),
                  SizedBox(height: 6),
                  ReusableRow(title: 'VIN #', value: widget.snap['vin']),
                  ReusableRow(
                      title: 'Current Mileage',
                      value: widget.snap['currentMileage']),
                  ReusableRow(
                      title: 'Engine Hours', value: widget.snap['engineHours']),
                  ReusableRow(
                      title: 'Complaint', value: widget.snap['complaint']),
                  ReusableRow(
                      title: 'Driver Contact', value: widget.snap['phone']),
                  ReusableRow(
                      title: 'Status',
                      value: widget.snap['approved'] == true
                          ? 'Approved'
                          : 'Not approved' + "::" + widget.snap['status']),
                  RoundButton(
                    title: 'Attached image',
                    onPress: () {
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
                  ),
                  if (widget.snap['additionalImage'].length != 0)
                    SizedBox(height: 10),
                  if (widget.snap['additionalImage'].length != 0)
                    RoundButton(
                      title: 'Additional complaint images',
                      onPress: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Scaffold(
                                      appBar: AppBar(),
                                      body: ListView.builder(
                                        itemCount: widget
                                            .snap['additionalImage'].length,
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
                                                            (context) =>
                                                                Scaffold(
                                                                  appBar:
                                                                      AppBar(),
                                                                  body: Center(
                                                                    child: InteractiveViewer(
                                                                        child: NetworkImageWidget(
                                                                      borderRadius:
                                                                          0,
                                                                      imageUrl:
                                                                          widget.snap['additionalImage']
                                                                              [
                                                                              index],
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
                                                widget.snap['additionalImage']
                                                    [index],
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
                    ),
                  if (widget.snap['video'] != '') SizedBox(height: 10),
                  if (widget.snap['video'] != '')
                    RoundButton(
                      title: 'Attached video',
                      onPress: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VideoPlayerPage(
                                    videoUrl: widget.snap['video'])));
                      },
                    ),
                  if (widget.snap['additionalVideo'] != '')
                    SizedBox(height: 10),
                  if (widget.snap['additionalVideo'] != '')
                    RoundButton(
                      title: 'Additional complaint video',
                      onPress: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VideoPlayerPage(
                                    videoUrl: widget.snap['additionalVideo'])));
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
                  if (widget.snap['approved'] != true) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Approve Service'),
                            content: Text(
                                'Are you sure you want to approve this service?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  // Perform approve action here
                                  FirebaseFirestore.instance
                                      .collection('service')
                                      .doc(widget.snap['docId'])
                                      .update({'approved': true}).then(
                                          (value) {});
                                  // This is where you'd put the logic to approve the service
                                  // Navigator.of(context)
                                  //     .pop(); // Close the dialog
                                  // Navigator.of(context)
                                  //     .pop(); // Close the dialog
                                  Get.to(ManagerDashboardScreen());
                                  Utils.flushBarDoneMessage(
                                      "Service Approved", context);
                                },
                                child: Text('Approve'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                                child: Text('Cancel'),
                              ),
                            ],
                          );
                        });
                  }
                },
                title: widget.snap['approved'] == true
                    ? 'Approved'
                    : 'Approve this service',
              ),
            ),
            // SizedBox(
            //   width: 240,
            //   child: RoundButton(
            //     onPress: () {
            //       showModalBottomSheet(
            //         context: context,
            //         builder: (BuildContext context) {
            //           return UserListBottomSheet(
            //             serviceDocId: widget.snap['docId'],
            //           );
            //         },
            //       );
            //     },
            //     title: 'Assign service to technician',
            //   ),
            // )
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

class UserListBottomSheet extends StatefulWidget {
  final String serviceDocId;
  const UserListBottomSheet({super.key, required this.serviceDocId});

  @override
  State<UserListBottomSheet> createState() => _UserListBottomSheetState();
}

class _UserListBottomSheetState extends State<UserListBottomSheet> {
  String? selectedUserUid;
  Map<String, dynamic>? userInfo;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Technician List',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          SizedBox(height: 10.0),
          Flexible(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .where('role', isEqualTo: 'Mechanic')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                } else {
                  List<QueryDocumentSnapshot> users = snapshot.data!.docs;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      String username = users[index].get('userName');
                      String uid = users[index].get('uid');
                      String phone = users[index].get('phone');
                      bool isSelected = uid == selectedUserUid;
                      return ListTile(
                        tileColor:
                            isSelected ? Colors.blue.withOpacity(0.3) : null,
                        onTap: () {
                          setState(() {
                            selectedUserUid = uid;
                          });
                        },
                        title: Text(
                          username,
                          style: TextStyle(color: Colors.black),
                        ),
                        subtitle: Text(
                          phone,
                          style: TextStyle(color: Colors.black),
                        ),
                        // You can add more details or actions here if needed
                      );
                    },
                  );
                }
              },
            ),
          ),
          SizedBox(height: 10.0),
          RoundButton(
            title: 'Assign service to selected technician',
            onPress: () async {
              // if (selectedUserUid != null) {
              //   await FirebaseFirestore.instance
              //       .collection('users')
              //       .doc(selectedUserUid)
              //       .get()
              //       .then((value) async {
              //     setState(() {
              //       userInfo = value.data();
              //     });
              //     await FirebaseFirestore.instance
              //         .collection('service')
              //         .doc(widget.serviceDocId)
              //         .update({}).then((value) {});
              //   });

              // showDialog(
              //   context: context,
              //   builder: (BuildContext context) {
              //     return UserInfoDialog(userInfo);
              //   },
              // );
              final TextEditingController _textFieldController =
                  TextEditingController();
              showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Assign Service to Technician'),
                      content: SizedBox(
                        width: double.maxFinite,
                        child: TextField(
                          controller: _textFieldController,
                          maxLines: null, // Set to null for multiline
                          decoration: InputDecoration(
                            hintText: 'Enter assigned notes',
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
                            // loading: _loading,
                            title: 'Submit',
                            onPress: () {
                              // setState(() => _loading = true);
                              try {
                                FirebaseFirestore.instance
                                    .collection('service')
                                    .doc(widget.serviceDocId)
                                    .update({
                                  'status': 'assigned',
                                  'assignedBy': SessionController().userId,
                                  'assignedTo': selectedUserUid,
                                  'managerNotes':
                                      _textFieldController.text.trim(),
                                });
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                                Utils.flushBarDoneMessage(
                                  'Your service Assigned has been recieved',
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
            },
          ),
          SizedBox(height: 10.0),
          RoundButton(
            title: 'Cancel',
            onPress: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}

class UserInfoDialog extends StatelessWidget {
  final Map<String, dynamic>? userInfo;

  UserInfoDialog(this.userInfo);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'User Info',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 10.0),
            if (userInfo != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: userInfo!.entries
                    .map(
                      (entry) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          '${entry.key}: ${entry.value}',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    )
                    .toList(),
              ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}

class VideoPlayerPage extends StatefulWidget {
  final String videoUrl;

  VideoPlayerPage({required this.videoUrl});

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
      ),
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return GestureDetector(
              onTap: () {
                if (_controller.value.isPlaying) {
                  _controller.pause();
                } else {
                  _controller.play();
                }
              },
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Center(
              child: Text('Error loading video'),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
