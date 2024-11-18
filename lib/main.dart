import 'package:commandespro_admin/features/auth/screen/auth_view.dart';
import 'package:commandespro_admin/features/dashboard/screens/dashboard.dart';
import 'package:commandespro_admin/features/products/screens/add_products.dart';
import 'package:commandespro_admin/routes/app_pages.dart';
import 'package:commandespro_admin/routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/binding/init_binding.dart';
import 'data/localization/app_localization.dart';
import 'firebase_options.dart';
import "dart:html" as html;

SharedPreferences? sharedPreferences;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  sharedPreferences = await SharedPreferences.getInstance();
  html.window.localStorage["token"] != null ? initialRoute = AppRoute.dashboard : initialRoute = AppRoute.login;
  runApp(const MyApp());
}

var initialRoute; // = AppRoute.login;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: AppTranslations(),    // Your translations class
      locale: Locale('en', 'US'),         // Default locale
      fallbackLocale: Locale('en', 'US'), // Fallback locale if translation key is missing
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      getPages: AppPages().route,
      initialBinding: InitBinding(),
      initialRoute: initialRoute,
    //  home: Dashboard(),
     // home: AuthView(),
    );
  }
}
