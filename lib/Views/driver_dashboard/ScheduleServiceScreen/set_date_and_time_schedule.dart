import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rpm/Views/driver_dashboard/ShopPart/Auth/Components/big_text.dart';
import 'package:rpm/Views/driver_dashboard/widgets/round_button.dart';
import 'package:rpm/utils/app_colors.dart';
import 'package:rpm/controllers/driver/order/service_req/schedule_service_controller.dart';
import 'package:rpm/utils/utils.dart';
import 'package:intl/intl.dart';

class SelectDateAndTime extends StatefulWidget {
  final String vin;
  final String currentMileage;
  final String engineHours;
  final String complaint; //
  final String additionalcomplaint; //additionalcomplaint
  SelectDateAndTime({
    Key? key,
    required this.title,
    required this.vin,
    required this.currentMileage,
    required this.engineHours,
    required this.complaint,
    required this.additionalcomplaint,
  }) : super(key: key);

  final String title;

  @override
  _SelectDateAndTimeState createState() => _SelectDateAndTimeState();
}

class _SelectDateAndTimeState extends State<SelectDateAndTime> {
  final meetingTimeController = TextEditingController();
  DateTime _currentDate = DateTime.now();
  final meetingTimeFocusNode = FocusNode();
  Duration initialTimer = const Duration();
  // var time;

  TimeOfDay timeOfDay =
      TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);

//  List<DateTime> _markedDate = [DateTime(2018, 9, 20), DateTime(2018, 10, 11)];
  static Widget _eventIcon = new Container(
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(1000)),
        border: Border.all(color: Colors.blue, width: 2.0)),
    child: Icon(
      Icons.person,
      color: Colors.amber,
    ),
  );

  // Widget timerPicker() {
  //   return CupertinoTimerPicker(
  //     mode: CupertinoTimerPickerMode.hm,
  //     minuteInterval: 1,
  //     secondInterval: 1,
  //     initialTimerDuration: initialTimer,
  //     onTimerDurationChanged: (Duration changeTimer) {
  //       setState(() {
  //         initialTimer = changeTimer;
  //         time =
  //             '${changeTimer.inHours} hrs ${changeTimer.inMinutes % 60} mins ${changeTimer.inSeconds % 60} secs';
  //       });
  //     },
  //   );
  // }

  Widget _buildContainer(Widget picker) {
    return Container(
      height: 200,
      padding: const EdgeInsets.only(top: 6.0),
      color: CupertinoColors.white,
      child: DefaultTextStyle(
        style: const TextStyle(
          color: CupertinoColors.black,
          fontSize: 22.0,
        ),
        child: GestureDetector(
          onTap: () {},
          child: SafeArea(
            top: false,
            child: picker,
          ),
        ),
      ),
    );
  }
  // EventList<Event> _markedDateMap = EventList<Event>(
  //   events: {
  //     DateTime(2019, 2, 10): [
  //       Event(
  //         date: DateTime(2019, 2, 10),
  //         title: 'Event 1',
  //         icon: _eventIcon,
  //         dot: Container(
  //           margin: EdgeInsets.symmetric(horizontal: 1.0),
  //           color: Colors.red,
  //           height: 5.0,
  //           width: 5.0,
  //         ),
  //       ),
  //       new Event(
  //         date: new DateTime(2019, 2, 10),
  //         title: 'Event 2',
  //         icon: _eventIcon,
  //       ),
  //       new Event(
  //         date: new DateTime(2019, 2, 10),
  //         title: 'Event 3',
  //         icon: _eventIcon,
  //       ),
  //     ],
  //   },
  // );

  @override
  Widget build(BuildContext context) {
    /// Example with custom icon

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.textFieldBorderColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: CustomText(
          title: "Select date and time",
          fontWeight: FontWeight.w700,
          fontSize: 18.sp,
          color: AppColors.whiteColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: CalendarCarousel<Event>(
                onDayPressed: (DateTime date, List<Event> events) {
                  this.setState(() => _currentDate = date);
                  log(_currentDate.toString());
                },
                weekendTextStyle: TextStyle(
                  color: Colors.red,
                ),
                // thisMonthDayBorderColor: Colors.grey,

                customDayBuilder: (
                  /// you can provide your own build function to make custom day containers
                  bool isSelectable,
                  int index,
                  bool isSelectedDay,
                  bool isToday,
                  bool isPrevMonthDay,
                  TextStyle textStyle,
                  bool isNextMonthDay,
                  bool isThisMonthDay,
                  DateTime day,
                ) {
                  /// If you return null, [CalendarCarousel] will build container for current [day] with default function.
                  /// This way you can build custom containers for specific days only, leaving rest as default.

                  // Example: every 15th of month, we have a flight, we can place an icon in the container like that:
                  // if (day.day == 15) {
                  //   return Center(
                  //     child: Icon(Icons.local_airport),
                  //   );
                  // } else {
                  return null;
                  // }
                },
                weekFormat: false,
                // markedDatesMap: _markedDateMap,
                height: 420.0,
                selectedDateTime: _currentDate,
                daysHaveCircularBorder: false,

                /// null for not rendering any border, true for circular border, false for rectangular border
              ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     InkWell(
            //       onTap: () {
            //         showCupertinoModalPopup<void>(
            //             context: context,
            //             builder: (BuildContext context) {
            //               return _buildContainer(timerPicker());
            //             });
            //       },
            //       child: CustomText(
            //         title: "Select Time",
            //         fontSize: 18.sp,
            //         fontWeight: FontWeight.bold,
            //         color: AppColors.textFieldBorderColor,
            //       ),
            //     ),
            //     Container(
            //       padding: const EdgeInsets.only(top: 8, bottom: 8),
            //       child: Text(
            //         time == null ? 'No Select Time' : ' $time',
            //         style: const TextStyle(
            //             color: Colors.black,
            //             fontSize: 16,
            //             fontWeight: FontWeight.bold),
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(
              height: 20.h,
            ),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        height: 400,
                        width: double.infinity,
                        color: Colors.transparent,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CupertinoButton(
                                    child: Text('Cancel',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4!
                                        // .copyWith(
                                        //     fontSize: 20,
                                        //     color: AppColors.alertColor)
                                        ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  CupertinoButton(
                                    child: Text('OK',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4!
                                            .copyWith(
                                                fontSize: 20,
                                                color: AppColors.blackColor)),
                                    onPressed: () {
                                      if (meetingTimeController.text.isEmpty) {
                                        timeOfDay = TimeOfDay(
                                            hour: DateTime.now().hour,
                                            minute: DateTime.now().minute);
                                        meetingTimeController.text =
                                            ourFormatTime(timeOfDay);
                                      }
                                      setState(() {});

                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 300,
                              child: CupertinoDatePicker(
                                mode: CupertinoDatePickerMode.time,
                                initialDateTime: DateTime(
                                    DateTime.now().year,
                                    DateTime.now().month,
                                    DateTime.now().day,
                                    timeOfDay.hour,
                                    timeOfDay.minute),
                                onDateTimeChanged: (DateTime newDateTime) {
                                  print(newDateTime);
                                  timeOfDay = TimeOfDay(
                                      hour: newDateTime.hour,
                                      minute: newDateTime.minute);

                                  meetingTimeController.text =
                                      ourFormatTime(timeOfDay);
                                  print(newDateTime);
                                },
                                use24hFormat: false,
                                minuteInterval: 1,
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              },
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    meetingTimeController.text == ''
                        ? 'Select Time'
                        : meetingTimeController.text,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
              ),
              //  AddPostTextFields(
              //     myController: meetingTimeController,
              //     focusNode: meetingTimeFocusNode,
              //     enable: false,
              //     onFiledSubmittedValue: (value) {
              //       // Utils.fieldFocusChange(
              //       //     context, meetingTimeFocusNode, meetingEndTimeFocusNode);
              //     },
              //     showSuffix: true,
              //     suffixIcon: Icons.timer_outlined,
              //     keyBoardType: TextInputType.text,
              //     hint: '12/12/2022',
              //     labelText: 'Meeting Start Time',
              //     onValidator: (value) {
              //       if (value.isEmpty) {
              //         return "Enter Meeting Start Time";
              //       }
              //       return null;
              //     }),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     SelectTimeWidget(
            //       title: "10:00 AM",
            //     ),
            //     SelectTimeWidget(
            //       title: "01:00 AM",
            //     ),
            //     SelectTimeWidget(
            //       title: "08:00 AM",
            //     ),
            //   ],
            // ),
            // SizedBox(
            //   height: 15.h,
            // ),
            // Row(
            //   children: [
            //     SelectTimeWidget(
            //       title: "06:00 AM",
            //     ),
            //     SizedBox(
            //       width: 5.h,
            //     ),
            //     SelectTimeWidget(
            //       title: "02:00 AM",
            //     ),
            //   ],
            // ),
            SizedBox(
              height: 30.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Consumer<ScheduleServiceController>(
                  builder: (context, value, child) => SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: RoundButton(
                      loading: value.loading,
                      title: 'Done',
                      onPress: () {
                        if (meetingTimeController.text != '') {
                          value
                              .scheduleService(
                            context,
                            widget.vin,
                            widget.currentMileage,
                            widget.engineHours,
                            widget.complaint,
                            _currentDate.toString(),
                            meetingTimeController.text,
                            widget.additionalcomplaint,
                            // time,
                          )
                              .then((value) {
                            meetingTimeController.text == '';
                          });
                        } else {
                          Utils.flushBarErrorMessage(
                              'Please select time', BuildContext, context);
                        }
                      },
                    ),
                  ),
                  //  InkWell(
                  //       onTap: () {
                  //         value.scheduleService(
                  //           context,
                  //           widget.vin,
                  //           widget.currentMileage,
                  //           widget.engineHours,
                  //           widget.complaint,
                  //           _currentDate.toString(),
                  //           time,
                  //         );
                  //       },
                  //       child: Container(
                  //         height: 38.h,
                  //         width: 143.w,
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(10),
                  //           color: AppColors.textFieldBorderColor,
                  //           boxShadow: [
                  //             BoxShadow(
                  //               color: Colors.black
                  //                   .withOpacity(0.25), // Shadow color
                  //               spreadRadius: 0,
                  //               blurRadius: 4,
                  //               offset: Offset(
                  //                   1, 1), // Offset in x and y direction
                  //             ),
                  //           ],
                  //         ),
                  //         child: Center(
                  //           child: CustomText(
                  //             title: "Done",
                  //             fontSize: 18.sp,
                  //             fontWeight: FontWeight.bold,
                  //             color: AppColors.whiteColor,
                  //           ),
                  //         ),
                  //       ),
                  //     )
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String ourFormatTime(TimeOfDay time) {
    var df = DateFormat("h:mm a");
    var dt = df.parse(time!.format(context));
    var finalTime = DateFormat.jm().format(dt);
    return finalTime;
  }
}

// class SelectTimeWidget extends StatelessWidget {
//   String title;
//   SelectTimeWidget({super.key, required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 29.h,
//       width: 100.w,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(5),
//         color: AppColors.whiteColor,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.25), // Shadow color
//             spreadRadius: 0,
//             blurRadius: 4,
//             offset: Offset(1, 1), // Offset in x and y direction
//           ),
//         ],
//       ),
//       child: Center(
//         child: CustomText(
//           title: title,
//           fontSize: 18.sp,
//           fontWeight: FontWeight.bold,
//           color: AppColors.textFieldBorderColor,
//         ),
//       ),
//     );
//   }
// }
