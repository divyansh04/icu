import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icu/screens/empty.dart';
import 'package:provider/provider.dart';
import 'package:icu/provider/image_upload_provider.dart';
import 'package:icu/provider/user_provider.dart';
import 'package:icu/resources/auth_methods.dart';
import 'package:icu/screens/home_screen.dart';
import 'package:icu/screens/login_screen.dart';
import 'package:icu/screens/search_screen.dart';
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
          future: _authMethods.getCurrentUser() ,
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
  bool status;
  bool loading;
  @override
  void initState() {
initialWork();
    super.initState();
  }
  initialWork()async{
    setState(() {
      loading=true;
    });
    FirebaseUser user = await AuthMethods().getCurrentUser();
    print(user.email);
    status = await AuthMethods().isDoctor(user.uid.toString());
    print(status);
    setState(() {
      loading=false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return loading? Center(child: CircularProgressIndicator()):status?Empty():HomeScreen();
  }
}
