import 'package:flutter/material.dart';
import 'package:icu/widgets/custom_tile.dart';
import 'package:intl/intl.dart';

class DoctorService extends StatefulWidget {
  @override
  _DoctorServiceState createState() => _DoctorServiceState();
}

class _DoctorServiceState extends State<DoctorService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
        title: Text('Doctor Service',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.w700,
          ),),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
          size: 30,
          color: Colors.white,
        ),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
        SizedBox(height: 40.0,),
        Expanded(child: Container(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(width: 5,),
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.account_circle,
                  size: 50,
                ),
              ),
              SizedBox(width: 20,),
              Text(
                'Doctor Name',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 40,
              ),
              Icon(
                Icons.edit,
                size: 30,
                color: Colors.white,
              ),
            ],
          ),
        ),
        margin: EdgeInsets.only( left: 30, right: 30,bottom: 300),
        decoration: BoxDecoration(
          color: Color(0xFF1D1E33),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      ),
         ]
     ),
    );
  }
}
