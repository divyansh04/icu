import 'package:flutter/material.dart';
showFailureDialog(BuildContext context,String failureHeading,failureDesc) {
  AlertDialog alert=AlertDialog(
    title: Center(child: Column(
      children: <Widget>[
        Icon(Icons.cancel_outlined,size: 80,color: Colors.red,),
        SizedBox(height: 15,),
        Text(failureHeading,style: TextStyle(fontSize: 23),),
        SizedBox(height: 12,),
        Text(failureDesc,textAlign: TextAlign.center,style: TextStyle(fontSize: 15)),
      ],
    )),
    content: RaisedButton(
      elevation: 0.2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Try again',textAlign:TextAlign.center,style: TextStyle(color: Colors.black),),
        ],
      ),
      onPressed: (){
        Navigator.pop(context);
      },
    ) ,
    actions: <Widget>[
    ],
  );
  showDialog(
      context: context,
      builder: (BuildContext context){
        return alert;
      });
}
showSuccessDialog(BuildContext context,String successHeading ,String successDesc,  onPressed ) {
  AlertDialog alert=AlertDialog(
    title: Center(child: Column(
      children: <Widget>[
        Icon(Icons.check_circle_outline,size: 80,color: Colors.green,),
        SizedBox(height: 15,),
        Text(successHeading,style: TextStyle(fontSize: 23),),
        SizedBox(height: 12,),
        Text(successDesc,textAlign: TextAlign.center,style: TextStyle(fontSize: 15)),
      ],
    )),
    content: RaisedButton(
      elevation: 0.2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Continue',textAlign:TextAlign.center,style: TextStyle(color: Colors.black),),
        ],
      ),
      onPressed: (){
        onPressed();
      },
    ) ,
    actions: <Widget>[
    ],
  );
  showDialog(
      context: context,
      builder: (BuildContext context){
        return alert;
      });
}
showWarningDialog(BuildContext context,String warningHeading ,String warningDesc ) {
  AlertDialog alert=AlertDialog(
    title: Center(child: Column(
      children: <Widget>[
        Icon(Icons.report_problem_outlined,size: 80,color: Colors.red),
        SizedBox(height: 15,),
        Text(warningHeading,style: TextStyle(fontSize: 23),),
        SizedBox(height: 12,),
        Text(warningDesc,textAlign: TextAlign.center,style: TextStyle(fontSize: 15)),
      ],
    )),
    content: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(width: 10,),
        RaisedButton(
          elevation: 0.2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Continue',textAlign:TextAlign.center,style: TextStyle(color: Colors.black),),
            ],
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        RaisedButton(
          elevation: 0.2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Cancel',textAlign:TextAlign.center,style: TextStyle(color: Colors.black),),
            ],
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ) ,
        SizedBox(width: 10,),
      ],
    ),
  );
  showDialog(
      context: context,
      builder: (BuildContext context){
        return alert;
      });
}
