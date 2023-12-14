import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rpm/Views/ShopPart/ShopHomeScreen/ProductDescriptionScreen/add_to_cart_provider.dart';
import 'package:rpm/Views/Utils/app_colors.dart';
import 'package:rpm/controllers/login_controller.dart';
import 'package:rpm/controllers/order/order_controller.dart';
import 'package:rpm/controllers/profile_controller.dart';
import 'package:rpm/controllers/service_req/emer_service_controller.dart';
import 'package:rpm/controllers/service_req/schedule_service_controller.dart';
import 'package:rpm/controllers/signup_controller.dart';
import 'package:rpm/firebase_options.dart';
import 'Views/ShopPart/Auth/SplashScreen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CountProvider()),
          ChangeNotifierProvider(create: (_) => SignupController()),
          ChangeNotifierProvider(create: (_) => LoginController()),
          ChangeNotifierProvider(create: (_) => ScheduleServiceController()),
          ChangeNotifierProvider(create: (_) => EmergencyServiceController()),
          ChangeNotifierProvider(create: (_) => ProfileController()),
          ChangeNotifierProvider(create: (_) => OrderController()),
        ],
        child: ScreenUtilInit(
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'RPM App Client Copy',
              theme: ThemeData(
                  primarySwatch: Colors.blue,
                  textTheme:
                      Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
                  dialogTheme:
                      DialogTheme(backgroundColor: AppColors.grayText)),
              home: SplashView(),
            );
          },
        ));
  }
}
