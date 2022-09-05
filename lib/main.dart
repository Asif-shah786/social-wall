import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_wall/service/auth_service.dart';
import 'package:social_wall/views/landing_view/wrapper.dart';

import 'service/message_service.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
        Provider<MessageService>(
          create: (_) => MessageService(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Task',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            color: Colors.black,
            centerTitle: true,
          ),
          fontFamily: 'Quicksand',
          primarySwatch: Colors.blue,
        ),
        home: Wrapper(),
      ),
    );
  }
}

