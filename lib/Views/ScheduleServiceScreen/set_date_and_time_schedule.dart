import 'package:flutter/material.dart';

import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:rpm/Views/ShopPart/Auth/Components/big_text.dart';
import 'package:rpm/Views/Utils/app_colors.dart';

import '../SelectDataAndTimeScreen/AllSuccessScreen/all_success_screen.dart';

class SelectDateAndTime extends StatefulWidget {
  SelectDateAndTime({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _SelectDateAndTimeState createState() =>  _SelectDateAndTimeState();
}

class _SelectDateAndTimeState extends State<SelectDateAndTime> {
  DateTime _currentDate = DateTime(2019, 2, 3);
//  List<DateTime> _markedDate = [DateTime(2018, 9, 20), DateTime(2018, 10, 11)];
  static Widget _eventIcon = new Container(
    decoration:  BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(1000)),
        border: Border.all(color: Colors.blue, width: 2.0)),
    child:  Icon(
      Icons.person,
      color: Colors.amber,
    ),
  );

  EventList<Event> _markedDateMap =  EventList<Event>(
    events: {
       DateTime(2019, 2, 10): [
         Event(
          date:  DateTime(2019, 2, 10),
          title: 'Event 1',
          icon: _eventIcon,
          dot: Container(

            margin: EdgeInsets.symmetric(horizontal: 1.0),
            color: Colors.red,
            height: 5.0,
            width: 5.0,
          ),
        ),
        new Event(
          date: new DateTime(2019, 2, 10),
          title: 'Event 2',
          icon: _eventIcon,
        ),
        new Event(
          date: new DateTime(2019, 2, 10),
          title: 'Event 3',
          icon: _eventIcon,
        ),
      ],
    },
  );


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
                  },
                  weekendTextStyle: TextStyle(
                    color: Colors.red,
                  ),
                  // thisMonthDayBorderColor: Colors.grey,

                  customDayBuilder: (   /// you can provide your own build function to make custom day containers
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
                    if (day.day == 15) {
                      return Center(
                        child: Icon(Icons.local_airport),
                      );
                    } else {
                      return null;
                    }
                  },
                  weekFormat: false,
                  markedDatesMap: _markedDateMap,
                  height: 420.0,
                  selectedDateTime: _currentDate,
                  daysHaveCircularBorder: false, /// null for not rendering any border, true for circular border, false for rectangular border
                ),
              ),

              CustomText(title: "Select Time",
              fontSize: 18.sp,
                  fontWeight: FontWeight.bold,color: AppColors.textFieldBorderColor,),
      SizedBox(height: 20.h,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    SelectTimeWidget(title: "10:00 AM",),
    SelectTimeWidget(title: "01:00 AM",),
    SelectTimeWidget(title: "08:00 AM",),
  ],
),
              SizedBox(height: 15.h,),
        Row(
          children: [
    SelectTimeWidget(title: "06:00 AM",),
            SizedBox(width: 5.h,),
    SelectTimeWidget(title: "02:00 AM",),
  ],
),
              SizedBox(height: 30.h,),
Row(
  mainAxisAlignment: MainAxisAlignment.end,
  children: [
        InkWell(
          onTap: (){
            Get.to(AllSuccessScreen());
          },
          child: Container(
    height: 38.h,
    width: 143.w,
          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.textFieldBorderColor,
          boxShadow: [
          BoxShadow(
          color: Colors.black.withOpacity(0.25), // Shadow color
          spreadRadius: 0,
          blurRadius: 4,
          offset: Offset(1, 1), // Offset in x and y direction
          ),
          ],
          ),
          child: Center(child:  CustomText(title:"Done",
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.whiteColor,),),
          ),
        ),
  ],
),
            ],
          ),
        ),
      );
}
}
class SelectTimeWidget extends StatelessWidget {
  String title;
   SelectTimeWidget({super.key,required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 29.h,
      width: 100.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25), // Shadow color
            spreadRadius: 0,
            blurRadius: 4,
            offset: Offset(1, 1), // Offset in x and y direction
          ),
        ],
      ),
      child: Center(child:  CustomText(title: title,
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.textFieldBorderColor,),),
    );
  }
}

