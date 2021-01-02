import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icu/screens/PatientScreen.dart';
import 'package:icu/screens/RelativeScreen.dart';
import 'package:provider/provider.dart';
import 'package:icu/provider/image_upload_provider.dart';
import 'package:icu/provider/user_provider.dart';
import 'package:icu/resources/auth_methods.dart';
import 'package:icu/screens/home_screen.dart';
import 'package:icu/screens/login_screen.dart';
import 'package:icu/screens/search_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthMethods _authMethods = AuthMethods();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ImageUploadProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        title: "icu",
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/search_screen': (context) => SearchScreen(),
        },
        theme: ThemeData(brightness: Brightness.dark),
        home: FutureBuilder(
          future: _authMethods.getCurrentUser(),
          builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
            if (snapshot.hasData) {
              return HomeWidget();
            } else {
              return LoginScreen();
            }
          },
        ),
      ),
    );
  }
}

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  bool doctor;
  bool patient;
  bool loading;
  FirebaseMessaging messaging = FirebaseMessaging();
  @override
  void initState() {
    initialWork();
    messaging.configure(
      onLaunch: (Map<String, dynamic> event) {
        return null;
      },
      onResume: (Map<String, dynamic> event) {
        return null;
      },
      onMessage: (Map<String, dynamic> event) {
        return null;
      },
    );
    messaging.getToken().then((value) => {print(value)});
    super.initState();
  }

  initialWork() async {
    setState(() {
      loading = true;
    });
    FirebaseUser user = await AuthMethods().getCurrentUser();
    print(user.email);
    doctor = await AuthMethods().isDoctor(user.uid.toString());
    print(doctor);
    if (!doctor) {
      patient = await AuthMethods().isPatient(user.uid.toString());
    }
    print(patient);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(child: CircularProgressIndicator())
        : doctor
            ? HomeScreen()
            : patient
                ? PatientScreen()
                : RelativeScreen();
  }
}
