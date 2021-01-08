import 'package:flutter/material.dart';
import 'package:icu/widgets/custom_tile.dart';
import 'package:intl/intl.dart';
import 'package:icu/widgets/standard_custom_button.dart';

import 'package:icu/utils/universal_variables.dart';
import 'package:icu/widgets/CustomAppBar.dart';

import 'package:icu/screens/admin_panel/manage_elements.dart';

class ViewElements extends StatefulWidget {
  final String role;

  const ViewElements({Key key, @required this.role}) : super(key: key);
  @override
  _ViewElementsState createState() => _ViewElementsState();
}

class _ViewElementsState extends State<ViewElements> {
  List<int> serviceElementList = [1, 2, 3];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: true,
        title: Text(
          widget.role,
        ),
        actions: [],
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        showGradient: true,
      ),
      floatingActionButton: Container(
        height: 70.0,
        width: 70.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: StandardCustomButton(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => ManageElements(
                      role: 'Add ${widget.role}',
                    )));
          },
          shape: BoxShape.circle,
          child: Icon(
            Icons.add,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: serviceElementList == null || serviceElementList.isEmpty
            ? Center(
                child: Text(
                'No ${widget.role} Added',
                style: TextStyle(
                    color: UniversalVariables.greyColor, fontSize: 30.0),
              ))
            : ListView.builder(
                shrinkWrap: true,
                itemCount: serviceElementList.length,
                itemBuilder: ((context, index) {
                  return CustomTile(
                    mini: false,
                    onTap: () {},
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://firebasestorage.googleapis.com/v0/b/icu-call.appspot.com/o/profile.jpg?alt=media&token=0c06cf85-d3c6-4575-a464-f214faa8b9c4'),
                      backgroundColor: Colors.grey,
                    ),
                    title: Text(
                      'name (F)',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'email',
                      style: TextStyle(color: UniversalVariables.greyColor),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => ManageElements(
                                  role: 'Edit ${widget.role}',
                                )));
                      },
                      icon: Icon(
                        Icons.edit,
                        size: 30,
                        color: UniversalVariables.blackColor,
                      ),
                    ),
                  );
                })),
      ),
    );
  }
}
