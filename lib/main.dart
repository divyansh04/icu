import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icu/screens/PatientScreen.dart';
import 'package:icu/screens/RelativeScreen.dart';
import 'package:icu/screens/admin_panel/admin_panel.dart';
import 'package:icu/utils/universal_variables.dart';
import 'package:icu/widgets/Customised_Progress_Indicator.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:icu/provider/user_provider.dart';
import 'package:icu/resources/auth_methods.dart';
import 'package:icu/screens/home_screen.dart';
import 'package:icu/screens/login_screen.dart';
import 'package:icu/screens/Doctorscreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        title: "icu",
        initialRoute: '/',
        routes: {
          '/search_screen': (context) => DoctorScreen(),
        },
        theme: ThemeData(brightness: Brightness.light),
        debugShowCheckedModeBanner: false,
        home: MaterialClass(),
      )));
}

class MaterialClass extends StatefulWidget {
  @override
  _MaterialClassState createState() => _MaterialClassState();
}

AuthMethods _authMethods = AuthMethods();

class _MaterialClassState extends State<MaterialClass> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _authMethods.getCurrentUser(),
      builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
        if (snapshot.hasData) {
          return HomeWidget();
        } else {
          return LoginScreen();
        }
      },
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
  bool relative;
  bool loading;
  Widget initialScreen;
  @override
  void initState() {
    initialWork();
    super.initState();
  }

  initialWork() async {
    setState(() {
      loading = true;
    });
    FirebaseUser user = await AuthMethods().getCurrentUser();
    print(user.email);
    doctor = await AuthMethods().isDoctor(user.uid.toString());
      patient = await AuthMethods().isPatient(user.uid.toString());
      relative = await AuthMethods().isRelative(user.uid.toString());
    setState(() {
      loading = false;
    });
    doctor
        ? initialScreen = HomeScreen()
        : patient
            ? initialScreen = PatientScreen()
            : relative
                ? initialScreen = RelativeScreen()
                : initialScreen = AdminPanel();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? ModalProgressHUD(
            inAsyncCall: loading,
            progressIndicator: CustomisedProgressIndicator(),
            child: Scaffold(
              body: Container(
                  decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    UniversalVariables.gradientColorStart,
                    UniversalVariables.gradientColorEnd
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              )),
            ),
          )
        : initialScreen;
  }
}
