import 'package:flutter/material.dart';

class AdminPanel extends StatefulWidget {
  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
        title: Text('Admin Panel',
        style: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.w700,
        ),),

    ),
      body: Column(
        children: [
          SizedBox(height: 40.0,),
          Expanded(child: Container(
            child: Center(
              child: Text(
                'Doctor Services',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
            margin: EdgeInsets.all(30.0),
            decoration: BoxDecoration(
              color: Color(0xFF1D1E33),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          ),
          Expanded(child: Container(
            child: Center(
              child: Text('Patient Services',
                textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.w700,
                  color: Colors.white,
              ),
              ),
            ),
            margin:  EdgeInsets.all(30.0),
              decoration: BoxDecoration(
                color: Color(0xFF1D1E33),
                borderRadius: BorderRadius.circular(10.0),
              ),
          ),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            child: Center(
              child: Text(
                'Log Out',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
            color: Colors.deepOrange,
            margin: EdgeInsets.all(10.0),
            height: 50.0,
          )
        ]
    ),
    );


  }
}
