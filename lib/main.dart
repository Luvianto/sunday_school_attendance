import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/routes/app_routes.dart';
import 'package:sunday_school_attendance/firebase_options.dart';

import 'theme.dart';
import 'util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');

  if (!kDebugMode) {
    debugPrint = (String? message, {int? wrapWidth}) {};
  }

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    TextTheme textTheme = createTextTheme(context, "Poppins", "Montserrat");

    MaterialTheme theme = MaterialTheme(textTheme);
    return GetMaterialApp(
      title: 'SSA',
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      initialRoute: AppRoutes.login,
      getPages: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
