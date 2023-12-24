import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:rpm/Views/driver_dashboard/widgets/round_button.dart';
import 'package:rpm/Views/profile/profile_screen.dart';
import 'package:rpm/Views/technician_dashboard.dart/home/appointments_list/appoinments_list_screen.dart';
import 'package:rpm/Views/technician_dashboard.dart/home/products/procuts_screen.dart';
import 'package:rpm/controllers/services/session_manager.dart';
import 'package:rpm/utils/app_colors.dart';
import 'package:rpm/utils/app_images.dart';

class TechnicianDashboardScreen extends StatefulWidget {
  const TechnicianDashboardScreen({Key? key}) : super(key: key);

  @override
  State<TechnicianDashboardScreen> createState() =>
      _TechnicianDashboardScreenState();
}

class _TechnicianDashboardScreenState extends State<TechnicianDashboardScreen>
    with WidgetsBindingObserver {
  final controler = PersistentTabController(initialIndex: 0);

  List<Widget> _buildScren() {
    return [
      Scaffold(
          body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(AppImages.appLogo, height: 130),
            SizedBox(height: 20),
            Text(
              SessionController().name.toString(),
              style: TextStyle(
                color: AppColors.blackColor,
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 260,
              child: RoundButton(
                  title: 'Shop Parts',
                  onPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductsScreen()));
                  }),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 260,
              child: RoundButton(
                  title: 'Manage Appointments',
                  onPress: () {
                    Get.to(AppointmentsListScreen());
                  }),
            ),
          ],
        ),
      )),
      // const TechnicianProfileScreen(),
      ProfileScreen(showBackButton: false),
      // const Scaffold(),
      // const Scaffold(),
      // const Scaffold(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItem() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        inactiveIcon: Icon(Icons.home_outlined),
        activeColorPrimary: AppColors.blackColor,
        inactiveColorPrimary: AppColors.whiteColor,
        activeColorSecondary: AppColors.blackColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
        inactiveIcon: Icon(Icons.person_2_outlined),
        activeColorPrimary: AppColors.blackColor,
        inactiveColorPrimary: AppColors.whiteColor,
        activeColorSecondary: AppColors.blackColor,
      ),
      // PersistentBottomNavBarItem(
      //   icon: Icon(Icons.home),
      //   inactiveIcon: Icon(Icons.home_outlined),
      //   activeColorPrimary: AppColors.blackColor,
      //   inactiveColorPrimary: AppColors.whiteColor,
      //   activeColorSecondary: AppColors.blackColor,
      // ),
      // PersistentBottomNavBarItem(
      //   icon: Icon(Icons.home),
      //   inactiveIcon: Icon(Icons.home_outlined),
      //   activeColorPrimary: AppColors.blackColor,
      //   inactiveColorPrimary: AppColors.whiteColor,
      //   activeColorSecondary: AppColors.blackColor,
      // ),
      // PersistentBottomNavBarItem(
      //   icon: Icon(Icons.home),
      //   inactiveIcon: Icon(Icons.home_outlined),
      //   activeColorPrimary: AppColors.blackColor,
      //   inactiveColorPrimary: AppColors.whiteColor,
      //   activeColorSecondary: AppColors.blackColor,
      // ),
    ];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    // if (state == AppLifecycleState.resumed) {
    //   FirebaseFirestore.instance
    //       .collection('User')
    //       .doc(SessionController().userId.toString())
    //       .update({'onlineStatus': 'online'});
    // } else {
    //   FirebaseFirestore.instance
    //       .collection('User')
    //       .doc(SessionController().userId.toString())
    //       .update({
    //     'onlineStatus': DateTime.now().microsecondsSinceEpoch.toString()
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      screens: _buildScren(),
      items: _navBarItem(),
      controller: controler,
      backgroundColor: Colors.grey.shade500,
      // backgroundColor: Theme.of(context).colorScheme.onPrimary,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(0.0),
        // colorBehindNavBar: AppColors.iconBlueColor,
      ),
      navBarStyle: NavBarStyle.style3,
    );
  }
}
