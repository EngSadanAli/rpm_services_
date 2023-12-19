import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:rpm/utils/app_colors.dart';

class ManagerDashboardScreen extends StatefulWidget {
  const ManagerDashboardScreen({Key? key}) : super(key: key);

  @override
  State<ManagerDashboardScreen> createState() => _ManagerDashboardScreenState();
}

class _ManagerDashboardScreenState extends State<ManagerDashboardScreen>
    with WidgetsBindingObserver {
  final controler = PersistentTabController(initialIndex: 0);

  List<Widget> _buildScren() {
    return [
      const Scaffold(body: Center(child: Text('manager dashboard'))),
      const Scaffold(),
      const Scaffold(),
      const Scaffold(),
      const Scaffold(),
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
        icon: Icon(Icons.home),
        inactiveIcon: Icon(Icons.home_outlined),
        activeColorPrimary: AppColors.blackColor,
        inactiveColorPrimary: AppColors.whiteColor,
        activeColorSecondary: AppColors.blackColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        inactiveIcon: Icon(Icons.home_outlined),
        activeColorPrimary: AppColors.blackColor,
        inactiveColorPrimary: AppColors.whiteColor,
        activeColorSecondary: AppColors.blackColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        inactiveIcon: Icon(Icons.home_outlined),
        activeColorPrimary: AppColors.blackColor,
        inactiveColorPrimary: AppColors.whiteColor,
        activeColorSecondary: AppColors.blackColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        inactiveIcon: Icon(Icons.home_outlined),
        activeColorPrimary: AppColors.blackColor,
        inactiveColorPrimary: AppColors.whiteColor,
        activeColorSecondary: AppColors.blackColor,
      ),
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
      // backgroundColor: Colors.grey.shade900,
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(0.0),
        // colorBehindNavBar: AppColors.iconBlueColor,
      ),
      navBarStyle: NavBarStyle.style3,
    );
  }
}
