import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:uet_app/admin/admin_page.dart';
import 'package:uet_app/splash_screen.dart';
import 'package:uet_app/student/student_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: 'AIzaSyDps7FVm76IJBkhDXwZ6buxShrpmrA0RSY',
            appId: '1:21015729871:android:ddb74060ce912a180e49ba',
            messagingSenderId: '21015729871',
            projectId: 'uet-app-7f237'));
  } else {
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: {
        '/admin': (context) => AdminPage(),
        '/student': (context) => StudentPage()
      },
    );
  }
}
