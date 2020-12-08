import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icu/screens/empty.dart';
import 'package:provider/provider.dart';
import 'package:icu/models/user.dart';
import 'package:icu/provider/image_upload_provider.dart';
import 'package:icu/provider/user_provider.dart';
import 'package:icu/resources/auth_methods.dart';
import 'package:icu/screens/home_screen.dart';
import 'package:icu/screens/login_screen.dart';
import 'package:icu/screens/search_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // FirebaseUser user =
  await AuthMethods().getCurrentUser();

  bool status;
  status = await AuthMethods().isDoctor();
  if (!status) {
    //Launch Doctor portal
    runApp(MyApp());
  } else {
    //Launch Patient portal
    runApp(PatApp());
  }
  // runApp(MyApp());
}

///Doctor's app flow
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthMethods _authMethods = AuthMethods();

  @override
  Widget build(BuildContext context) {
    final Widget loadingWidget =
        _authMethods.getUser() != null ? HomeScreen() : LoginScreen();
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
        home: loadingWidget,
        // FutureBuilder(
        //   future: _authMethods.getCurrentUser(),
        //   builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
        //     if (snapshot.hasData) {
        //       return HomeScreen(); //widgetToLoad;
        //       // if (snapshot.data.isDoctor == true) {
        //       //   return HomeScreen();
        //       // } else {
        //       //   return Empty();
        //       // }
        //     } else {
        //       return LoginScreen();
        //     }
        //   },
        // ),
      ),
    );
  }
}

///Patient app flow
class PatApp extends StatefulWidget {
  @override
  _PatAppState createState() => _PatAppState();
}

class _PatAppState extends State<PatApp> {
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
              return Empty(); //widgetToLoad;
              // if (snapshot.data.isDoctor == true) {
              //   return HomeScreen();
              // } else {
              //   return Empty();
              // }
            } else {
              return LoginScreen();
            }
          },
        ),
      ),
    );
  }
}

// class HomeWidget extends StatelessWidget {
//   final AuthMethods _authMethods = AuthMethods();

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: _authMethods.getUserDetails(),
//       builder: (context, AsyncSnapshot<User> snapshot) {
//         if (snapshot.hasData) {
//           return HomeScreen();
//         } else {
//           return LoginScreen();
//         }
//       },
//     );
//   }
// }
