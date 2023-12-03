import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../Views/EmergencyServiceScreen/engine_service_screen.dart';
import '../Views/LocationScreen/my_location_screen.dart';
import '../Views/ScheduleServiceScreen/set_date_and_time_schedule.dart';
import '../Views/SettingScreen/setting_screen.dart';
import '../Views/ShopPart/AddToCartScreen/add_to_cart_screen.dart';
import '../Views/ShopPart/ShopHomeScreen/home_service_request.dart';
import '../Views/Utils/app_colors.dart';
import '../Views/Utils/app_images.dart';

class AppNavigationBar extends StatefulWidget {
  const AppNavigationBar({Key? key}) : super(key: key);
  @override
  State<AppNavigationBar> createState() => _AppNavigationBarState();
}

class _AppNavigationBarState extends State<AppNavigationBar> {
  int Index = 0;
  List<Widget> widgetList = [
    HomeServicesRequest(),
    MyWishlistScreen(),
    EngineServiceScreen(),
    AddToCartScreen(),
    SettingScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 86,
        width: 428,
        child: BottomNavigationBar(
            selectedItemColor: AppColors.textFieldBorderColor,
            // unselectedItemColor: AppColors.blackColor,
            useLegacyColorScheme: true,
            backgroundColor: AppColors.bottomColor,
            showUnselectedLabels: true,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            type: BottomNavigationBarType.fixed,
            // backgroundColor: Colors.transparent,
            onTap: (index) {
              setState(() {
                Index = index;
              });
            },
            currentIndex: Index,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_outlined,
                  ),
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite_border,
                  ),
                  label: "Wishlist"),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    AppImages.sirenImg,
                    color: Colors.red,
                  ),
                  label: "Emergency"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart_outlined), label: "Cart"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings_outlined), label: "Setting")
            ]),
      ),
      body: widgetList[Index],
    );
  }
}


// class AppNavigationBar extends StatefulWidget {
//   @override
//   _AppNavigationBarState createState() => _AppNavigationBarState();
// }
//
// class _AppNavigationBarState extends State<AppNavigationBar> {
//   int _selectedIndex = 0;
//
//   List<Widget> _buildScreens() {
//     // Replace these with your own screens
//     return [
//
//       HomeServicesRequest(),
//       MyWishlistScreen(),
//       EngineServiceScreen(),
//       AddToCartScreen(),
//       SettingScreen(),
//     ];
//   }
//
//   List<PersistentBottomNavBarItem> _navBarItems() {
//     return [
//       PersistentBottomNavBarItem(
//         icon: Icon(Icons.home_outlined,size: 24),
//         title: "Home",
//         textStyle: TextStyle( fontWeight: FontWeight.w500,fontFamily: 'Proxima',),
//         activeColorPrimary: AppColors.blackColor,
//         // activeColorSecondary: Colors.blue,
//         inactiveColorPrimary: Colors.grey,
//       ),
//       PersistentBottomNavBarItem(
//         icon: Icon(Icons.favorite_border,),
//         title: "Wishlist",
//         textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500,fontFamily: 'Proxima',),
//         activeColorPrimary: AppColors.blackColor,
//         inactiveColorPrimary: Colors.grey,
//       ),
//       PersistentBottomNavBarItem(icon: Image.asset(AppImages.sirenImg,color: Colors.red,height: 20,),
//         // icon: SvgPicture.asset("assets/Vector.svg"),
//         // icon: FaIcon(FontAwesomeIcons.exclamationCircl,size: 22),
//         // icon: ImageIcon(AssetImage(AppImages.sirenImg,)),
//         title: "Emergency",
//         textStyle: TextStyle( fontWeight: FontWeight.w500,fontFamily: 'Proxima',),
//         activeColorPrimary: AppColors.blackColor,
//         inactiveColorPrimary: Colors.grey,
//       ),
//       PersistentBottomNavBarItem(
//         icon: Icon(Icons.shopping_cart_outlined,),
//         title: "Cart",
//         textStyle: TextStyle( fontWeight: FontWeight.w500,fontFamily: 'Proxima',),
//         activeColorPrimary: AppColors.blackColor,
//         inactiveColorPrimary: Colors.grey,
//       ),
//
//       PersistentBottomNavBarItem(
//         icon: Icon(Icons.settings_outlined, size: 24,),
//         title: "Settings",
//         textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500,fontFamily: 'Proxima',),
//         activeColorPrimary: AppColors.blackColor,
//         inactiveColorPrimary: Colors.grey,
//       ),
//     ];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return PersistentTabView(
//       context,
//       controller: PersistentTabController(initialIndex: _selectedIndex),
//       decoration: NavBarDecoration(border: Border(top: BorderSide(color: Color(0xFFDEE2E6).withOpacity(.9)))),
//       screens: _buildScreens(),
//       items: _navBarItems(),
//       confineInSafeArea: true,
//       backgroundColor: Colors.white,
//       handleAndroidBackButtonPress: true,
//       resizeToAvoidBottomInset: true,
//       stateManagement: true,
//       hideNavigationBarWhenKeyboardShows: true,
//       popAllScreensOnTapOfSelectedTab: true,
//       popActionScreens: PopActionScreensType.all,
//       itemAnimationProperties: ItemAnimationProperties(
//         duration: Duration(milliseconds: 200),
//         curve: Curves.ease,
//       ),
//       screenTransitionAnimation: ScreenTransitionAnimation(
//         animateTabTransition: true,
//         curve: Curves.ease,
//         duration: Duration(milliseconds: 200),
//       ),
//       navBarStyle: NavBarStyle.style6,
//     );
//   }
// }
