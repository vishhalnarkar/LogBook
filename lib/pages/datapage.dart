import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logbook/services/storage.dart';

class DataDisp extends StatefulWidget {
  
  const DataDisp({super.key});

  @override
  State<DataDisp> createState() => _DataDispState();
}

class _DataDispState extends State<DataDisp> {
  // For Date Tile
  DateTime dt = DateTime.now();
  List<String> items=[];

  Future getLogContent() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('LogBooks')
        .doc('wMoBfRw3i8zY7u9IzYiO')
        .get();
    
    // Gets LogBookData Array
    var logBookData=(snapshot.data() as Map<String, dynamic>) ['LogBookData'];
    
    //Access single LogBookData and Content 
    for(var i=0;i<=4;i++){
      items.add(logBookData[i]["LogContent"]);
    };

  }
  

  List<DateTime> dateTimes = [
    DateTime(2024, 8, 30, 12, 45),
    DateTime(2024, 8, 30, 12, 46),
    DateTime(2024, 8, 30, 12, 51),
    DateTime(2024, 8, 30, 13, 03),
  ];

  List<DateTime> date = [
    DateTime(2024, 8, 30, 10, 30),
  ];
  bool datePress = true;

  @override
  Widget build(BuildContext context) {
    getLogContent();
    // Screen Height And Screen Width
    double widthScreen = MediaQuery.sizeOf(context).width;
    var padding = MediaQuery.paddingOf(context);
    double tempheight = MediaQuery.sizeOf(context).height;
    double heightScreen = tempheight - padding.top - padding.bottom;

    // DataTile Builder Funtion
    Container dataTile(String LogContent, DateTime StartEndTime) {
      // Converts the Date Time to Time. (i.e 30/08/2024 10:54 am => 10:54 am)
      var formatter = DateFormat.jm();
      String time = formatter.format(StartEndTime);

      // String Operations Performed on LogContent to details about the emp

      // Spliting the LogContent
      var spt = LogContent.split(' ');

      // Converts shift_start => Shift Started or partol_start => Patrol Started
      String status = '${spt[0].replaceAll(RegExp(r'_'), ' ')}ed';
      List<String> temp = status.split('');
      temp[0] = status[0].toUpperCase();
      temp[status.indexOf(' ') + 1] =
          status[status.indexOf(' ') + 1].toUpperCase();
      status = temp.join();

      // temp is used later to change icon and color of the ListTile
      temp = status.split(' ');

      // Removes '_' from Place
      String place = spt[2].replaceAll(RegExp(r'_'), ' ');

      // Removes '_' from Name
      String name = spt[4].replaceAll(RegExp(r'_'), ' ');

      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color:
                (temp[1] == "Started") ? Colors.green[800] : Colors.red[600]),
        child: ListTile(
          leading: Transform.flip(
            flipX: (temp[1] == "Started") ? false : true,
            child: Icon(
              Icons.directions_walk_outlined,
              color: Colors.amber[600],
            ),
          ),
          title: Text(
            status,
            style: const TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            "$place\nClient Name : $name",
            style: const TextStyle(color: Colors.white),
          ),
          trailing: Text(
            time,
            style: TextStyle(
              color: Colors.white,
              fontSize: (heightScreen * 0.02),
            ),
          ),
        ),
      );
    }

    // DateTile Builder Function
    Column dateTile(DateTime getDate) {
      //  Used to change the Icon

      // Take only the date from the 'getDate' and convert it into String
      var formatter = DateFormat.yMd();
      String date = formatter.format(getDate);

      // Draws List Widget
      return Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Colors.grey[850]),
            child: ListTile(
              title: Text(
                date.toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: (heightScreen * (0.02 + 0.002))),
              ),
              trailing: Icon(
                (datePress == true)
                    ? Icons.arrow_circle_down_rounded
                    : Icons.arrow_circle_up_rounded,
                color: Colors.white,
                size: (heightScreen * 0.04),
              ),
              onTap: () {
                log("Date Tile Tapped");
                setState(() {
                  datePress = !datePress;
                });
              },
            ),
          ),
          if (!datePress)
            Column(
              children: [
                SizedBox(height: heightScreen * 0.03),
                SizedBox(
                  height: heightScreen * 0.6,
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          dataTile(items[index], dateTimes[index]),
                          SizedBox(height: heightScreen * 0.03),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Logbook",
            style: TextStyle(color: Colors.white),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.grey[850],
      ),
      body: Container(
          padding: EdgeInsets.all((widthScreen * 0.09)),
          child: ListView.builder(
            itemCount: date.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(child: dateTile(date[index])),
                  SizedBox(height: heightScreen * 0.03),
                ],
              );
            },
          )),
    );
  }
}
