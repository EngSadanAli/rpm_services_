import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:provider/provider.dart';
import 'package:rpm/Views/driver_dashboard/ScheduleServiceScreen/widget/schedule_row_widget.dart';
import 'package:rpm/Views/driver_dashboard/widgets/round_button.dart';
import 'package:rpm/controllers/driver/order/service_req/emer_service_controller.dart';
import 'package:rpm/controllers/services/session_manager.dart';
import 'package:rpm/utils/utils.dart';
import '../widgets/custom_textField.dart';
import '../ShopPart/Auth/Components/big_text.dart';
import '../../../utils/app_colors.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geocoding/geocoding.dart';

class EngineServiceScreen extends StatefulWidget {
  final bool showBackButton;
  EngineServiceScreen({super.key, required this.showBackButton});

  @override
  State<EngineServiceScreen> createState() => _EngineServiceScreenState();
}

class _EngineServiceScreenState extends State<EngineServiceScreen> {
  final vinController = TextEditingController();
  final currentMileageController = TextEditingController();
  final engineHoursController = TextEditingController();
  final conplaintController = TextEditingController();
  final AdditionalconplaintController = TextEditingController();
  final additionalconplaintFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final nameFocusNode = FocusNode();
  String? currentLocation; // Variable to store the location data
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Emergency service'),
            leading: widget.showBackButton
                ? IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ))
                : SizedBox.shrink(),
          ),
          body: Consumer<EmergencyServiceController>(
            builder: (context, value, child) => Padding(
              padding: EdgeInsets.only(left: 15.w, right: 15, top: 10.h),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            title: "Driver Details",
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            color: AppColors.blackColor.withOpacity(.50),
                          ),
                          FutureBuilder<DocumentSnapshot>(
                            future: FirebaseFirestore.instance
                                .collection('users')
                                .doc(SessionController().userId)
                                .get(),
                            builder: (BuildContext context,
                                AsyncSnapshot<DocumentSnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return Text("Something went wrong");
                              }
                              if (snapshot.hasData && !snapshot.data!.exists) {
                                return Text("Document does not exist");
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                Map<String, dynamic> data = snapshot.data!
                                    .data() as Map<String, dynamic>;
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ScheduleRow(
                                      title: "Name: ",
                                      text: SessionController().name.toString(),
                                    ),
                                    SizedBox(
                                      height: 6.h,
                                    ),
                                    ScheduleRow(
                                      title: "Email:",
                                      text: data['email'],
                                    ),
                                    SizedBox(
                                      height: 6.h,
                                    ),
                                    // ScheduleRow(
                                    //   title: "Unit Number: ",
                                    //   text: data['unitNumber'],
                                    // ),
                                    // SizedBox(
                                    //   height: 6.h,
                                    // ),
                                    // ScheduleRow(
                                    //   title: "C Name: ",
                                    //   text: data['cName'],
                                    // ),
                                  ],
                                );
                              }

                              return Text("loading");
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomTextField(
                        readOnly: false,
                        controller: vinController,
                        focusNode: nameFocusNode,
                        onFieldSubmittedValue: (newValue) {},
                        keyBoardType: TextInputType.emailAddress,
                        obscureText: false,
                        hint: 'VIN #',
                        onChange: (value) {},
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter VIN';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomTextField(
                        readOnly: false,
                        controller: currentMileageController,
                        focusNode: emailFocusNode,
                        onFieldSubmittedValue: (newValue) {},
                        keyBoardType: TextInputType.emailAddress,
                        obscureText: false,
                        hint: 'Current Mileage',
                        onChange: (value) {},
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Current Mileage';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomTextField(
                        readOnly: false,
                        controller: engineHoursController,
                        focusNode: passwordFocusNode,
                        onFieldSubmittedValue: (newValue) {},
                        keyBoardType: TextInputType.emailAddress,
                        obscureText: false,
                        hint: 'Engine Hours',
                        onChange: (value) {},
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Engine Hours';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        // height: 160.h,
                        decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: AppColors.textFieldBorderColor,
                                width: 1.5.w)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              style: TextStyle(color: Colors.black),
                              controller: conplaintController,
                              decoration: InputDecoration(
                                  labelText: 'Complaint 1',
                                  contentPadding: const EdgeInsets.all(10),
                                  border: InputBorder.none,
                                  prefixIcon: Icon(
                                    Icons.person_outline,
                                    color: AppColors.textFieldBorderColor,
                                  )),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a Complaint';
                                }
                                return null;
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20.w, top: 20.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton.icon(
                                          onPressed: () =>
                                              value.pickImage(context),
                                          icon: Icon(Icons.image),
                                          label: Text('Add Images')),
                                      TextButton.icon(
                                          onPressed: () =>
                                              value.pickVideo(context),
                                          icon: Icon(Icons.image),
                                          label: Text('Add Video')),
                                    ],
                                  ),

                                  SizedBox(
                                    height: 6.h,
                                  ),
                                  // if (value.images.length >
                                  //     1) // Check if there are more than one image
                                  Wrap(
                                    spacing: 4.0, // Adjust spacing as needed
                                    runSpacing: 4.0,
                                    children: value.images.map((image) {
                                      return Container(
                                        height: 50.h,
                                        width: 78.w,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                          borderRadius:
                                              BorderRadius.circular(13),
                                          image: DecorationImage(
                                            image: FileImage(image),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                  // Row(
                                  //   children: [
                                  //     InkWell(
                                  //       onTap: () => value.pickImage(context),
                                  //       child: Container(
                                  //         height: 50.h,
                                  //         width: 78.w,
                                  //         decoration: BoxDecoration(
                                  //           color: AppColors.whiteColor,
                                  //           boxShadow: [
                                  //             BoxShadow(
                                  //               color: Colors.black.withOpacity(
                                  //                   0.16), // Shadow color
                                  //               spreadRadius: 0,
                                  //               blurRadius: 4,
                                  //               offset: Offset(1,
                                  //                   3), // Offset in x and y direction
                                  //             ),
                                  //           ],
                                  //           borderRadius:
                                  //               BorderRadius.circular(6.r),
                                  //         ),
                                  //         child: Column(
                                  //           mainAxisAlignment:
                                  //               MainAxisAlignment.center,
                                  //           crossAxisAlignment:
                                  //               CrossAxisAlignment.center,
                                  //           children: [
                                  //             if (value.images.isNotEmpty)
                                  //               Stack(children: [
                                  //                 Container(
                                  //                   height: 50.h,
                                  //                   width: 78.w,
                                  //                   decoration: BoxDecoration(
                                  //                     color: Theme.of(context)
                                  //                         .colorScheme
                                  //                         .onPrimary,
                                  //                     borderRadius:
                                  //                         BorderRadius.circular(
                                  //                             13),
                                  //                     image: DecorationImage(
                                  //                       image: FileImage(
                                  //                           value.images[0]),
                                  //                       fit: BoxFit.cover,
                                  //                     ),
                                  //                   ),
                                  //                 ),
                                  //                 Positioned(
                                  //                     bottom: 2,
                                  //                     right: 2,
                                  //                     child: InkWell(
                                  //                       onTap: () {
                                  //                         value.pickImage(
                                  //                             context);
                                  //                       },
                                  //                       child: Container(
                                  //                           height: 20,
                                  //                           width: 20,
                                  //                           decoration: BoxDecoration(
                                  //                               shape: BoxShape
                                  //                                   .circle,
                                  //                               color: AppColors
                                  //                                   .redTextColor),
                                  //                           child: Icon(
                                  //                             Icons.add,
                                  //                             color:
                                  //                                 Colors.white,
                                  //                           )),
                                  //                     ))
                                  //               ]),
                                  //             if (value.images.isNotEmpty)
                                  //               Icon(
                                  //                 Icons.camera_alt_outlined,
                                  //                 color: Colors.red,
                                  //               ),
                                  //             if (value.images.isNotEmpty)
                                  //               SizedBox(
                                  //                 height: 2.h,
                                  //               ),
                                  //             if (value.images.isNotEmpty)
                                  //               CustomText(
                                  //                 title: "Take Picture",
                                  //                 fontWeight: FontWeight.w400,
                                  //                 fontSize: 10.sp,
                                  //                 color: AppColors.blackColor,
                                  //               ),
                                  //           ],
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      value.videoFile != null
                          ? VideoThumbnailWidget(videoFile: value.videoFile!)
                          : Text(''),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomTextField(
                        readOnly: false,
                        controller: AdditionalconplaintController,
                        focusNode: additionalconplaintFocusNode,
                        onFieldSubmittedValue: (newValue) {},
                        keyBoardType: TextInputType.text,
                        obscureText: false,
                        hint: 'Additional Complaint',
                        onChange: (value) {},
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please enter Additional Complaint';
                        //   }
                        //   return null;
                        // },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      RoundButton(
                        buttonColor: currentLocation == null
                            ? Colors.blue
                            : AppColors.garyIconColor,
                        height: currentLocation == null ? 50 : 100,
                        loading: loading,
                        title: currentLocation == null
                            ? 'Share Location'
                            : currentLocation.toString(),
                        onPress: () async {
                          // Get location data when the button is pressed
                          setState(() => loading = true);
                          String location = await _getLocation();
                          setState(() {
                            currentLocation = location;
                            loading = false;
                          });
                        },
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3,
                            child: RoundButton(
                              loading: value.loading,
                              title: 'Next',
                              onPress: () {
                                if (_formKey.currentState!.validate()) {
                                  if (value.images.isNotEmpty) {
                                    if (currentLocation != null) {
                                      value
                                          .emergencyService(
                                        context,
                                        vinController.text.trim(),
                                        currentMileageController.text.trim(),
                                        engineHoursController.text.trim(),
                                        conplaintController.text.trim(),
                                        AdditionalconplaintController.text
                                            .trim(),
                                        currentLocation.toString(),
                                      )
                                          .then((value) {
                                        currentMileageController.clear();
                                        vinController.clear();
                                        conplaintController.clear();
                                        engineHoursController.clear();
                                        AdditionalconplaintController.clear();
                                        setState(() {
                                          currentLocation == null;
                                        });
                                      });
                                    } else {
                                      Utils.flushBarErrorMessage(
                                          'Please share current location',
                                          BuildContext,
                                          context);
                                    }
                                  } else {
                                    Utils.flushBarErrorMessage(
                                        'Please Attached a image',
                                        BuildContext,
                                        context);
                                  }
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  Future<String> _getLocation() async {
    var status = await Permission.location.request();

    if (status == PermissionStatus.granted) {
      try {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        double latitude = position.latitude;
        double longitude = position.longitude;

        // Perform reverse geocoding to get the address from latitude and longitude
        List<Placemark> placemarks =
            await placemarkFromCoordinates(latitude, longitude);

        // Extract the address from the first placemark
        if (placemarks.isNotEmpty) {
          Placemark placemark = placemarks.first;
          String address =
              "${placemark.street}, ${placemark.locality}, ${placemark.administrativeArea}";

          // Assign the address to your variable
          setState(() {
            currentLocation = address;
          });

          return 'Address: $address';
        } else {
          return 'No address found for the given coordinates';
        }
      } catch (e) {
        return 'Error getting location: $e';
      }
    } else {
      return 'Location permission denied';
    }
  }
}

class VideoPlayerPage extends StatefulWidget {
  final File videoFile;

  VideoPlayerPage({required this.videoFile});

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.videoFile);
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
          } else {
            return Center(
              child: CircularProgressIndicator(),
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

// class VideoThumbnailWidget extends StatelessWidget {
//   final File videoFile;

//   VideoThumbnailWidget({required this.videoFile});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Get.to(VideoPlayerPage(videoFile: videoFile));
//         // Navigator.push(
//         //   context,
//         //   MaterialPageRoute(
//         //     builder: (context) => VideoPlayerPage(videoFile: videoFile),
//         //   ),
//         // );
//       },
//       child: Container(
//         child: Image.file(videoFile, fit: BoxFit.cover),
//       ),
//     );
//   }
// }

class VideoThumbnailWidget extends StatelessWidget {
  final File videoFile;

  VideoThumbnailWidget({required this.videoFile});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => VideoPlayerPage(videoFile: videoFile),
        //   ),
        // );
        Get.to(VideoPlayerPage(videoFile: videoFile));
      },
      child: Container(
        child: FutureBuilder(
          future: _generateThumbnail(videoFile),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                      height: 200,
                      width: double.infinity,
                      child: Image.memory(snapshot.data as Uint8List,
                          fit: BoxFit.cover)),
                  Text(
                    'Click to watch the video',
                    style: TextStyle(color: AppColors.whiteColor, fontSize: 22),
                  )
                ],
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Future<Uint8List> _generateThumbnail(File videoFile) async {
    final thumbnailBytes = await VideoThumbnail.thumbnailData(
      video: videoFile.path,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 150,
      quality: 25,
    );
    return Uint8List.fromList(thumbnailBytes!);
  }
}
