import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:twod_threed/Model/Digitchart3d.dart';
import 'package:twod_threed/Utils/Constant.dart';
import 'package:twod_threed/Utils/myColor.dart';

import '../network/networkapi.dart';

class chart3d extends StatefulWidget {
  chart3ddetail createState() => chart3ddetail();
}

class chart3ddetail extends State<chart3d> {
  bool isreloading = true;
  bool isdata = false;

  List<First3d> firstlist = [];
  int first_topdigit = 0;
  int first_seconddigit = 0;
  int first_thirddigit = 0;

  List<First3d> middledatalist = [];
  int middle_topdigit = 0;
  int middle_seconddigit = 0;
  int middle_thirddigit = 0;

  List<First3d> lastdatalist = [];
  int last_topdigit = 0;
  int last_seconddigit = 0;
  int last_thirddigit = 0;

  List<First3d> firsttwolist = [];
  int ft_topdigit = 0;
  int ft_seconddigit = 0;
  int ft_thirddigit = 0;

  List<First3d> lasrtwolist = [];
  int lt_topdigit = 0;
  int lt_seconddigit = 0;
  int lt_thirddigit = 0;

  List<First3d> firstandlastlist = [];
  int fl_topdigit = 0;
  int fl_seconddigit = 0;
  int fl_thirddigit = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: isdarkthem ? myColor.darkbg : Colors.white,
        appBar: AppBar(
          iconTheme:  IconThemeData(
            color:isdarkthem ? myColor.white : myColor.black, //change your color here
          ),
          backgroundColor: isdarkthem ? myColor.darktitle : myColor.white,
          title: Container(
            margin: const EdgeInsets.only(right: 10),
            child:  Text(ld.favouriteSD,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: 'ar',
                  color:isdarkthem ? myColor.white : myColor.black,
                  fontSize: 18,
                )),
          ),
          elevation: 1,
        ),
        body: Stack(
          children: [
            isdata
                ? Container(
                    margin: const EdgeInsets.only(left: 5, right: 5,top: 10),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Card(
                            color:
                                isdarkthem ? myColor.darkitems : myColor.white,
                            //   margin: EdgeInsets.only( bottom: 10),
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                            elevation: 5,
                            child: Container(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(5.0),
                                  ),
                                  child: Container(
                                    height: 60,
                                    color: myColor.firstd,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        margin: const EdgeInsets.only(left: 15),
                                        child: const Text(
                                          'First Digits',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.white,
                                            fontFamily: 'ar',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.only(right: 5, top: 5),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'Best Digits',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: isdarkthem
                                            ? myColor.white
                                            : myColor.softblack,
                                        fontFamily: 'ar',
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.only(right: 5, top: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        height: 30,
                                        width: 30,
                                        margin: const EdgeInsets.only(top: 5),
                                        child: Center(
                                          child: Text(
                                            first_topdigit == -1
                                                ? '-'
                                                : first_topdigit.toString(),
                                            style: const TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.white,
                                              fontFamily: 'ar',
                                            ),
                                          ),
                                        ),
                                        color: Colors.red,
                                      ),
                                      Container(
                                        height: 30,
                                        width: 30,
                                        margin: const EdgeInsets.only(
                                            top: 5, left: 5),
                                        child: Center(
                                          child: Text(
                                            first_seconddigit == -1
                                                ? '-'
                                                : first_seconddigit.toString(),
                                            style: const TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.white,
                                              fontFamily: 'ar',
                                            ),
                                          ),
                                        ),
                                        color: Colors.red,
                                      ),
                                      Container(
                                        height: 30,
                                        width: 30,
                                        margin: const EdgeInsets.only(
                                            top: 5, left: 5),
                                        child: Center(
                                          child: Text(
                                            first_thirddigit == -1
                                                ? '-'
                                                : first_thirddigit.toString(),
                                            style: const TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.white,
                                              fontFamily: 'ar',
                                            ),
                                          ),
                                        ),
                                        color: Colors.red,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.only(right: 5, top: 10),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'Start Date - $date',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: isdarkthem
                                            ? myColor.white
                                            : myColor.BrownBoldTextColor,
                                        fontFamily: 'ar',
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),

                                Row(
                                  children: [
                                    Container(

                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        //Center Row contents horizontally,,
                                        children: getRow(),
                                      ),
                                    ),
                                    Container(
                                        margin:
                                            const EdgeInsets.only(right: 5, top: 25),
                                        child: Expanded(
                                          child: Column(
                                            children: [
                                              SfCartesianChart(
                                          margin: EdgeInsets.all(0),
                                                  primaryXAxis: CategoryAxis(

                                                    labelStyle: TextStyle(
                                                        fontSize: 14,
                                                        color: isdarkthem
                                                            ? myColor.white
                                                            : null,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  primaryYAxis: NumericAxis(
                                                    maximum: 100,
                                                    labelFormat: '{value}%',
                                                    labelStyle: TextStyle(
                                                        color: isdarkthem
                                                            ? myColor.white
                                                            : null,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  series: <
                                                      ChartSeries<SalesData,
                                                          String>>[
                                                    BarSeries(
                                                      dataSource: firstlistvalueSetdata(1),
                                                      xValueMapper:
                                                          (SalesData sales, _) =>
                                                              sales.x,
                                                      yValueMapper:
                                                          (SalesData sales, _) =>
                                                              sales.y,
                                                      dataLabelSettings:
                                                          const DataLabelSettings(
                                                              isVisible: true,
                                                              labelAlignment:
                                                                  ChartDataLabelAlignment
                                                                      .top,
                                                              textStyle: TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .white)),


                                                    ),
                                                  ]),
                                            ],
                                          ),
                                        )),
                                  ],
                                ),


                                Center(
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 10,top: 10),
                                    child: Text(
                                      'Choose Your Desire Numbers',
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          color: isdarkthem
                                              ? myColor.white
                                              : Colors.black,
                                          fontFamily: 'ar'),
                                    ),
                                  ),
                                ),

                              ],
                            )),
                          ),

                          Card(
                            color:
                                isdarkthem ? myColor.darkitems : myColor.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                            elevation: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(5.0),
                                  ),
                                  child: Container(
                                    height: 60,
                                    color: myColor.middledigitcolor,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        margin: const EdgeInsets.only(left: 15),
                                        child: const Text(
                                          'Middle Digits',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.white,
                                            fontFamily: 'ar',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.only(right: 5, top: 5),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'Best Digits',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: isdarkthem
                                            ? myColor.white
                                            : myColor.softblack,
                                        fontFamily: 'ar',
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.only(right: 5, top: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        height: 30,
                                        width: 30,
                                        margin: const EdgeInsets.only(top: 5),
                                        child: Center(
                                          child: Text(
                                            middle_topdigit == -1
                                                ? '-'
                                                : middle_topdigit.toString(),
                                            style: const TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.white,
                                              fontFamily: 'ar',
                                            ),
                                          ),
                                        ),
                                        color: Colors.red,
                                      ),
                                      Container(
                                        height: 30,
                                        width: 30,
                                        margin: const EdgeInsets.only(
                                            top: 5, left: 5),
                                        child: Center(
                                          child: Text(
                                            middle_seconddigit == -1
                                                ? '-'
                                                : middle_seconddigit.toString(),
                                            style: const TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.white,
                                              fontFamily: 'ar',
                                            ),
                                          ),
                                        ),
                                        color: Colors.red,
                                      ),
                                      Container(
                                        height: 30,
                                        width: 30,
                                        margin: const EdgeInsets.only(
                                            top: 5, left: 5),
                                        child: Center(
                                          child: Text(
                                            middle_thirddigit == -1
                                                ? '-'
                                                : middle_thirddigit.toString(),
                                            style: const TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.white,
                                              fontFamily: 'ar',
                                            ),
                                          ),
                                        ),
                                        color: Colors.red,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.only(right: 5, top: 10),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'Start Date - $date',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: isdarkthem
                                            ? myColor.white
                                            : myColor.BrownBoldTextColor,
                                        fontFamily: 'ar',
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                Container(
                                    margin:
                                        const EdgeInsets.only(right: 5, top: 5),
                                    child: SizedBox(
                                      height: 300,
                                      child: Column(
                                        children: [
                                          SfCartesianChart(
                                              primaryXAxis: CategoryAxis(
                                                  labelStyle: TextStyle(
                                                      color: isdarkthem
                                                          ? myColor.white
                                                          : myColor.black,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              primaryYAxis: NumericAxis(
                                                  maximum: 100,
                                                  labelFormat: '{value}%',
                                                  labelStyle: TextStyle(
                                                      color: isdarkthem
                                                          ? myColor.white
                                                          : myColor.black,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              series: <
                                                  ChartSeries<SalesData,
                                                      String>>[
                                                StackedColumnSeries<SalesData,
                                                    String>(
                                                  dataSource: <SalesData>[
                                                    // Separate data source maintained for series - 1
                                                    SalesData(
                                                        '0',
                                                        middlelistvalue[0]
                                                            .toDouble()),
                                                    SalesData(
                                                        '1',
                                                        middlelistvalue[1]
                                                            .toDouble()),
                                                    SalesData(
                                                        '2',
                                                        middlelistvalue[2]
                                                            .toDouble()),
                                                    SalesData(
                                                        '3',
                                                        middlelistvalue[3]
                                                            .toDouble()),
                                                    SalesData(
                                                        '4',
                                                        middlelistvalue[4]
                                                            .toDouble()),
                                                    SalesData(
                                                        '5',
                                                        middlelistvalue[5]
                                                            .toDouble()),
                                                    SalesData(
                                                        '6',
                                                        middlelistvalue[6]
                                                            .toDouble()),
                                                    SalesData(
                                                        '7',
                                                        middlelistvalue[7]
                                                            .toDouble()),
                                                    SalesData(
                                                        '8',
                                                        middlelistvalue[8]
                                                            .toDouble()),
                                                    SalesData(
                                                        '9',
                                                        middlelistvalue[9]
                                                            .toDouble())
                                                  ],
                                                  xValueMapper:
                                                      (SalesData sales, _) =>
                                                          sales.x,
                                                  yValueMapper:
                                                      (SalesData sales, _) =>
                                                          sales.y,
                                                  dataLabelSettings:
                                                      const DataLabelSettings(
                                                          isVisible: true,
                                                          labelAlignment:
                                                              ChartDataLabelAlignment
                                                                  .top,
                                                          textStyle: TextStyle(
                                                              fontSize: 10,
                                                              color: Colors
                                                                  .white)),
                                                ),
                                              ]),
                                        ],
                                      ),
                                    )),
                                  Center(
                                  child: Text(
                                    'Choose Your Desire Numbers',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color:  isdarkthem
                                            ? myColor.white
                                            : Colors.black,
                                        fontFamily: 'ar'),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 5, bottom: 15, top: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    //Center Row contents horizontally,,
                                    children: getRowmiddle(),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Card(
                            color:
                            isdarkthem ? myColor.darkitems : myColor.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                            elevation: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(5.0),
                                  ),
                                  child: Container(
                                    height: 60,
                                    color: myColor.lastdigitcolor,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        margin: const EdgeInsets.only(left: 15),
                                        child: const Text(
                                          'End Digits',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.white,
                                            fontFamily: 'ar',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.only(right: 5, top: 5),
                                  child:   Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'Best Digits',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color:   isdarkthem ? myColor.white :myColor.softblack,
                                        fontFamily: 'ar',
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.only(right: 5, top: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        height: 30,
                                        width: 30,
                                        margin: const EdgeInsets.only(top: 5),
                                        child: Center(
                                          child: Text(
                                            last_topdigit == -1
                                                ? '-'
                                                : last_topdigit.toString(),
                                            style: const TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.white,
                                              fontFamily: 'ar',
                                            ),
                                          ),
                                        ),
                                        color: Colors.red,
                                      ),
                                      Container(
                                        height: 30,
                                        width: 30,
                                        margin: const EdgeInsets.only(
                                            top: 5, left: 5),
                                        child: Center(
                                          child: Text(
                                            last_seconddigit == -1
                                                ? '-'
                                                : last_seconddigit.toString(),
                                            style: const TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.white,
                                              fontFamily: 'ar',
                                            ),
                                          ),
                                        ),
                                        color: Colors.red,
                                      ),
                                      Container(
                                        height: 30,
                                        width: 30,
                                        margin: const EdgeInsets.only(
                                            top: 5, left: 5),
                                        child: Center(
                                          child: Text(
                                            last_thirddigit == -1
                                                ? '-'
                                                : last_thirddigit.toString(),
                                            style: const TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.white,
                                              fontFamily: 'ar',
                                            ),
                                          ),
                                        ),
                                        color: Colors.red,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.only(right: 5, top: 10),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'Start Date - $date',
                                      style:   TextStyle(
                                        fontSize: 14.0,
                                        color:isdarkthem ? myColor.white:myColor.BrownBoldTextColor,
                                        fontFamily: 'ar',
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                Container(
                                    margin:
                                        const EdgeInsets.only(right: 5, top: 5),
                                    child: SizedBox(
                                      height: 300,
                                      child: Column(
                                        children: [
                                          SfCartesianChart(
                                              primaryXAxis: CategoryAxis(
                                                      labelStyle:   TextStyle(
                                                      color: isdarkthem ? myColor.white:null,
                                                      fontWeight:
                                                      FontWeight.bold)
                                              ),
                                              primaryYAxis: NumericAxis(
                                                  maximum: 100,
                                                  labelFormat: '{value}%',
                                                  labelStyle:   TextStyle(
                                                      color: isdarkthem ? myColor.white:null,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              series: <
                                                  ChartSeries<SalesData,
                                                      String>>[
                                                StackedColumnSeries<SalesData,
                                                    String>(
                                                  dataSource: <SalesData>[
                                                    // Separate data source maintained for series - 1
                                                    SalesData(
                                                        '0',
                                                        lastlistvalue[0]
                                                            .toDouble()),
                                                    SalesData(
                                                        '1',
                                                        lastlistvalue[1]
                                                            .toDouble()),
                                                    SalesData(
                                                        '2',
                                                        lastlistvalue[2]
                                                            .toDouble()),
                                                    SalesData(
                                                        '3',
                                                        lastlistvalue[3]
                                                            .toDouble()),
                                                    SalesData(
                                                        '4',
                                                        lastlistvalue[4]
                                                            .toDouble()),
                                                    SalesData(
                                                        '5',
                                                        lastlistvalue[5]
                                                            .toDouble()),
                                                    SalesData(
                                                        '6',
                                                        lastlistvalue[6]
                                                            .toDouble()),
                                                    SalesData(
                                                        '7',
                                                        lastlistvalue[7]
                                                            .toDouble()),
                                                    SalesData(
                                                        '8',
                                                        lastlistvalue[8]
                                                            .toDouble()),
                                                    SalesData(
                                                        '9',
                                                        lastlistvalue[9]
                                                            .toDouble())
                                                  ],
                                                  xValueMapper:
                                                      (SalesData sales, _) =>
                                                          sales.x,
                                                  yValueMapper:
                                                      (SalesData sales, _) =>
                                                          sales.y,
                                                  dataLabelSettings:
                                                      const DataLabelSettings(
                                                          isVisible: true,
                                                          labelAlignment:
                                                              ChartDataLabelAlignment
                                                                  .top,
                                                          textStyle: TextStyle(
                                                              fontSize: 10,
                                                              color: Colors
                                                                  .white)),
                                                ),
                                              ]),
                                        ],
                                      ),
                                    )),
                                  Center(
                                  child: Text(
                                    'Choose Your Desire Numbers',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: isdarkthem ? myColor.white:Colors.black,
                                        fontFamily: 'ar'),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 5, bottom: 15, top: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    //Center Row contents horizontally,,
                                    children: getRowlast(),
                                  ),
                                ),
                              ],
                            ),
                          ),


                          Card(
                            color: isdarkthem ? myColor.darkitems:Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                            elevation: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(5.0),
                                  ),
                                  child: Container(
                                    height: 60,
                                    color: myColor.firsttwodigitcolor,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        margin: const EdgeInsets.only(left: 15),
                                        child: const Text(
                                          'First Two Digits',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.white,
                                            fontFamily: 'ar',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.only(right: 5, top: 5),
                                  child:   Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'Best Digits',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: isdarkthem ? myColor.white:myColor.softblack,
                                        fontFamily: 'ar',
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.only(right: 5, top: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        height: 30,
                                        width: 30,
                                        margin: const EdgeInsets.only(top: 5),
                                        child: Center(
                                          child: Text(
                                            ft_topdigit == -1
                                                ? '-'
                                                : ft_topdigit.toString(),
                                            style: const TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.white,
                                              fontFamily: 'ar',
                                            ),
                                          ),
                                        ),
                                        color: Colors.red,
                                      ),
                                      Container(
                                        height: 30,
                                        width: 30,
                                        margin: const EdgeInsets.only(
                                            top: 5, left: 5),
                                        child: Center(
                                          child: Text(
                                            ft_seconddigit == -1
                                                ? '-'
                                                : ft_seconddigit.toString(),
                                            style: const TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.white,
                                              fontFamily: 'ar',
                                            ),
                                          ),
                                        ),
                                        color: Colors.red,
                                      ),
                                      Container(
                                        height: 30,
                                        width: 30,
                                        margin: const EdgeInsets.only(
                                            top: 5, left: 5),
                                        child: Center(
                                          child: Text(
                                            ft_thirddigit == -1
                                                ? '-'
                                                : ft_thirddigit.toString(),
                                            style: const TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.white,
                                              fontFamily: 'ar',
                                            ),
                                          ),
                                        ),
                                        color: Colors.red,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.only(right: 5, top: 10),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'Start Date - $date',
                                      style:   TextStyle(
                                        fontSize: 14.0,
                                        color:  isdarkthem ? myColor.white:myColor.BrownBoldTextColor,
                                        fontFamily: 'ar',
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                Container(
                                    margin:
                                        const EdgeInsets.only(right: 5, top: 5),
                                    child: SizedBox(
                                      height: 300,
                                      child: Column(
                                        children: [
                                          SfCartesianChart(
                                              primaryXAxis: CategoryAxis(
                                                      labelStyle:   TextStyle(
                                                      color:  isdarkthem ? myColor.white:null,
                                                      fontWeight:
                                                      FontWeight.bold)
                                              ),
                                              primaryYAxis: NumericAxis(
                                                  maximum: 100,
                                                  labelFormat: '{value}%',
                                                  labelStyle:   TextStyle(
                                                    color:  isdarkthem ? myColor.white:null,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              series: <
                                                  ChartSeries<SalesData,
                                                      String>>[
                                                StackedColumnSeries<SalesData,
                                                    String>(
                                                  dataSource: <SalesData>[
                                                    // Separate data source maintained for series - 1
                                                    SalesData(
                                                        '0',
                                                        ftlistvalue[0]
                                                            .toDouble()),
                                                    SalesData(
                                                        '1',
                                                        ftlistvalue[1]
                                                            .toDouble()),
                                                    SalesData(
                                                        '2',
                                                        ftlistvalue[2]
                                                            .toDouble()),
                                                    SalesData(
                                                        '3',
                                                        ftlistvalue[3]
                                                            .toDouble()),
                                                    SalesData(
                                                        '4',
                                                        ftlistvalue[4]
                                                            .toDouble()),
                                                    SalesData(
                                                        '5',
                                                        ftlistvalue[5]
                                                            .toDouble()),
                                                    SalesData(
                                                        '6',
                                                        ftlistvalue[6]
                                                            .toDouble()),
                                                    SalesData(
                                                        '7',
                                                        ftlistvalue[7]
                                                            .toDouble()),
                                                    SalesData(
                                                        '8',
                                                        ftlistvalue[8]
                                                            .toDouble()),
                                                    SalesData(
                                                        '9',
                                                        ftlistvalue[9]
                                                            .toDouble())
                                                  ],
                                                  xValueMapper:
                                                      (SalesData sales, _) =>
                                                          sales.x,
                                                  yValueMapper:
                                                      (SalesData sales, _) =>
                                                          sales.y,
                                                  dataLabelSettings:
                                                      const DataLabelSettings(
                                                          isVisible: true,
                                                          labelAlignment:
                                                              ChartDataLabelAlignment
                                                                  .top,
                                                          textStyle: TextStyle(
                                                              fontSize: 10,
                                                              color: Colors
                                                                  .white)),
                                                ),
                                              ]),
                                        ],
                                      ),
                                    )),
                                  Center(
                                  child: Text(
                                    'Choose Your Desire Numbers',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color:  isdarkthem ? myColor.white:Colors.black,
                                        fontFamily: 'ar'),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 5, bottom: 15, top: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    //Center Row contents horizontally,,
                                    children: getRowFt(),
                                  ),
                                ),
                              ],
                            ),
                          ),



                          Card(
                            color: isdarkthem ? myColor.darkitems:Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                            elevation: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(5.0),
                                  ),
                                  child: Container(
                                    height: 60,
                                    color: myColor.lasttwodigitcolor,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        margin: const EdgeInsets.only(left: 15),
                                        child: const Text(
                                          'Last Two Digits',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.white,
                                            fontFamily: 'ar',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.only(right: 5, top: 5),
                                  child:   Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'Best Digits',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: isdarkthem ? myColor.white:myColor.softblack,
                                        fontFamily: 'ar',
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.only(right: 5, top: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        height: 30,
                                        width: 30,
                                        margin: const EdgeInsets.only(top: 5),
                                        child: Center(
                                          child: Text(
                                            lt_topdigit == -1
                                                ? '-'
                                                : lt_topdigit.toString(),
                                            style: const TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.white,
                                              fontFamily: 'ar',
                                            ),
                                          ),
                                        ),
                                        color: Colors.red,
                                      ),
                                      Container(
                                        height: 30,
                                        width: 30,
                                        margin: const EdgeInsets.only(
                                            top: 5, left: 5),
                                        child: Center(
                                          child: Text(
                                            lt_seconddigit == -1
                                                ? '-'
                                                : lt_seconddigit.toString(),
                                            style: const TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.white,
                                              fontFamily: 'ar',
                                            ),
                                          ),
                                        ),
                                        color: Colors.red,
                                      ),
                                      Container(
                                        height: 30,
                                        width: 30,
                                        margin: const EdgeInsets.only(
                                            top: 5, left: 5),
                                        child: Center(
                                          child: Text(
                                            lt_thirddigit == -1
                                                ? '-'
                                                : lt_thirddigit.toString(),
                                            style: const TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.white,
                                              fontFamily: 'ar',
                                            ),
                                          ),
                                        ),
                                        color: Colors.red,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.only(right: 5, top: 10),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'Started Date - $date',
                                      style:   TextStyle(
                                        fontSize: 14.0,
                                        color: isdarkthem ? myColor.white:myColor.BrownBoldTextColor,
                                        fontFamily: 'ar',
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                Container(
                                    margin:
                                        const EdgeInsets.only(right: 5, top: 5),
                                    child: SizedBox(
                                      height: 300,
                                      child: Column(
                                        children: [
                                          SfCartesianChart(
                                              primaryXAxis: CategoryAxis(
                                                  labelStyle:   TextStyle(
                                                      color: isdarkthem ? myColor.white:null,
                                                      fontWeight:
                                                      FontWeight.bold)
                                              ),
                                              primaryYAxis: NumericAxis(
                                                  maximum: 100,
                                                  labelFormat: '{value}%',
                                                  labelStyle:   TextStyle(
                                                      color: isdarkthem ? myColor.white:null,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              series: <
                                                  ChartSeries<SalesData,
                                                      String>>[
                                                StackedColumnSeries<SalesData,
                                                    String>(
                                                  dataSource: <SalesData>[
                                                    // Separate data source maintained for series - 1
                                                    SalesData(
                                                        '0',
                                                        ltlistvalue[0]
                                                            .toDouble()),
                                                    SalesData(
                                                        '1',
                                                        ltlistvalue[1]
                                                            .toDouble()),
                                                    SalesData(
                                                        '2',
                                                        ltlistvalue[2]
                                                            .toDouble()),
                                                    SalesData(
                                                        '3',
                                                        ltlistvalue[3]
                                                            .toDouble()),
                                                    SalesData(
                                                        '4',
                                                        ltlistvalue[4]
                                                            .toDouble()),
                                                    SalesData(
                                                        '5',
                                                        ltlistvalue[5]
                                                            .toDouble()),
                                                    SalesData(
                                                        '6',
                                                        ltlistvalue[6]
                                                            .toDouble()),
                                                    SalesData(
                                                        '7',
                                                        ltlistvalue[7]
                                                            .toDouble()),
                                                    SalesData(
                                                        '8',
                                                        ltlistvalue[8]
                                                            .toDouble()),
                                                    SalesData(
                                                        '9',
                                                        ltlistvalue[9]
                                                            .toDouble())
                                                  ],
                                                  xValueMapper:
                                                      (SalesData sales, _) =>
                                                          sales.x,
                                                  yValueMapper:
                                                      (SalesData sales, _) =>
                                                          sales.y,
                                                  dataLabelSettings:
                                                      const DataLabelSettings(
                                                          isVisible: true,
                                                          labelAlignment:
                                                              ChartDataLabelAlignment
                                                                  .top,
                                                          textStyle: TextStyle(
                                                              fontSize: 10,
                                                              color: Colors
                                                                  .white)),
                                                ),
                                              ]),
                                        ],
                                      ),
                                    )),
                                  Center(
                                  child: Text(
                                    'Choose Your Desire Numbers',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color:  isdarkthem ? myColor.white:Colors.black,
                                        fontFamily: 'ar'),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 5, bottom: 15, top: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    //Center Row contents horizontally,,
                                    children: getRowlt(),
                                  ),
                                ),
                              ],
                            ),
                          ),


                          Card(
                            color: isdarkthem ? myColor.darkitems:Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                            elevation: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(5.0),
                                  ),
                                  child: Container(
                                    height: 60,
                                    color: myColor.totaldigitcolor,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        margin: const EdgeInsets.only(left: 15),
                                        child: const Text(
                                          'First And Last Digits Sum',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.white,
                                            fontFamily: 'ar',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.only(right: 5, top: 5),
                                  child:   Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'Best Digits',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: isdarkthem ? myColor.white:myColor.softblack,
                                        fontFamily: 'ar',
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.only(right: 5, top: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        height: 30,
                                        width: 30,
                                        margin: const EdgeInsets.only(top: 5),
                                        child: Center(
                                          child: Text(
                                            fl_topdigit == -1
                                                ? '-'
                                                : fl_topdigit.toString(),
                                            style: const TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.white,
                                              fontFamily: 'ar',
                                            ),
                                          ),
                                        ),
                                        color: Colors.red,
                                      ),
                                      Container(
                                        height: 30,
                                        width: 30,
                                        margin: const EdgeInsets.only(
                                            top: 5, left: 5),
                                        child: Center(
                                          child: Text(
                                            fl_seconddigit == -1
                                                ? '-'
                                                : fl_seconddigit.toString(),
                                            style: const TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.white,
                                              fontFamily: 'ar',
                                            ),
                                          ),
                                        ),
                                        color: Colors.red,
                                      ),
                                      Container(
                                        height: 30,
                                        width: 30,
                                        margin: const EdgeInsets.only(
                                            top: 5, left: 5),
                                        child: Center(
                                          child: Text(
                                            fl_thirddigit == -1
                                                ? '-'
                                                : fl_thirddigit.toString(),
                                            style: const TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.white,
                                              fontFamily: 'ar',
                                            ),
                                          ),
                                        ),
                                        color: Colors.red,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.only(right: 5, top: 10),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'Date - $date',
                                      style:   TextStyle(
                                        fontSize: 14.0,
                                        color: isdarkthem ? myColor.white:myColor.BrownBoldTextColor,
                                        fontFamily: 'ar',
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                Container(
                                    margin:
                                        const EdgeInsets.only(right: 5, top: 5),
                                    child: SizedBox(
                                      height: 300,
                                      child: Column(
                                        children: [
                                          SfCartesianChart(
                                              primaryXAxis: CategoryAxis(
                                                      labelStyle:   TextStyle(
                                                      color: isdarkthem ? myColor.white:null,
                                                      fontWeight:
                                                      FontWeight.bold)
                                              ),
                                              primaryYAxis: NumericAxis(
                                                  maximum: 100,
                                                  labelFormat: '{value}%',
                                                  labelStyle:   TextStyle(
                                                      color: isdarkthem ? myColor.white:null,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              series: <
                                                  ChartSeries<SalesData,
                                                      String>>[
                                                StackedColumnSeries<SalesData,
                                                    String>(
                                                  dataSource: <SalesData>[
                                                    // Separate data source maintained for series - 1
                                                    SalesData(
                                                        '0',
                                                        fllistvalue[0]
                                                            .toDouble()),
                                                    SalesData(
                                                        '1',
                                                        fllistvalue[1]
                                                            .toDouble()),
                                                    SalesData(
                                                        '2',
                                                        fllistvalue[2]
                                                            .toDouble()),
                                                    SalesData(
                                                        '3',
                                                        fllistvalue[3]
                                                            .toDouble()),
                                                    SalesData(
                                                        '4',
                                                        fllistvalue[4]
                                                            .toDouble()),
                                                    SalesData(
                                                        '5',
                                                        fllistvalue[5]
                                                            .toDouble()),
                                                    SalesData(
                                                        '6',
                                                        fllistvalue[6]
                                                            .toDouble()),
                                                    SalesData(
                                                        '7',
                                                        fllistvalue[7]
                                                            .toDouble()),
                                                    SalesData(
                                                        '8',
                                                        fllistvalue[8]
                                                            .toDouble()),
                                                    SalesData(
                                                        '9',
                                                        fllistvalue[9]
                                                            .toDouble())
                                                  ],
                                                  xValueMapper:
                                                      (SalesData sales, _) =>
                                                          sales.x,
                                                  yValueMapper:
                                                      (SalesData sales, _) =>
                                                          sales.y,
                                                  dataLabelSettings:
                                                      const DataLabelSettings(
                                                          isVisible: true,
                                                          labelAlignment:
                                                              ChartDataLabelAlignment
                                                                  .top,
                                                          textStyle: TextStyle(
                                                              fontSize: 10,
                                                              color: Colors
                                                                  .white)),
                                                ),
                                              ]),
                                        ],
                                      ),
                                    )),
                                  Center(
                                  child: Text(
                                    'Choose Your Desire Numbers',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color:  isdarkthem ? myColor.white:Colors.black,
                                        fontFamily: 'ar'),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 5, bottom: 15, top: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    //Center Row contents horizontally,,
                                    children: getRowfl(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : isreloading
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 10, bottom: 80, left: 50, right: 50),
                                child: const Align(
                                  alignment: Alignment.center,
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 10, bottom: 15, left: 50, right: 50),
                                child:   Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "No data avaliable!",
                                    style: TextStyle(
                                      fontFamily: 'TNR',
                                      color: isdarkthem ? myColor.white:Colors.black,
                                      fontSize: 18,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              InkWell(
                                child: Container(
                                  width: 100,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        const Radius.circular(5.0)),
                                    border: Border.all(
                                        color: isdarkthem ? myColor.white:Colors.black, width: .5),
                                  ),
                                  child:   Center(
                                    child: Text(
                                      "Refresh",
                                      style: TextStyle(
                                        fontFamily: 'TNR',
                                        color: isdarkthem ? myColor.white:Colors.black,
                                        fontSize: 14,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  isreloading = true;
                                  setState(() {});
                                  onRefresh();
                                },
                              )
                            ],
                          )
                        ],
                      )
          ],
        ));
  }

  String date = '';

  Future<void> onRefresh() async {
    try {
      var urlserver = Uri.parse(fullresultchart3d);
      Response response = await post(
        urlserver,
        headers: {HttpHeaders.authorizationHeader: token},
      );

      print(response.body.toString());
      Digitchart3d reg = Digitchart3d.fromJson(jsonDecode(response.body));
      date = reg.date ?? '';
      firstlist = reg.first!;
      middledatalist = reg.middledata!;
      lastdatalist = reg.lastdata!;
      firsttwolist = reg.firsttwodata!;
      lasrtwolist = reg.lasrtwodata!;
      firstandlastlist = reg.firstandlastdata!;

      if (reg.status == true) {
        isdata = true;
      } else {
        isdata = false;
      }
    } catch (e) {
      isreloading = false;
      print(e.toString());
    }

    Check_FirstTopDigits();
    Check_middleTopDigits();
    Check_lastTopDigits();
    Check_ftTopDigits();
    Check_ltTopDigits();
    Check_flTopDigits();

    setState(() {});
  }

  List<int> firstlistvalue = [];

  void Check_FirstTopDigits() {
    int totalvote = 0;
    for (int i = 0; i < firstlist.length; i++) {
      totalvote = totalvote + firstlist[i].total!.toInt();
    }
    firstlistvalue = [];
    for (int i = 0; i < firstlist.length; i++) {
      int mytotal = firstlist[i].total!;
      double percentage = (mytotal * 100) / totalvote;
      try {
        print(percentage.toString());
        firstlistvalue.add(percentage.toInt());
      } catch (e) {
        firstlistvalue.add(0);
      }

      //
    }

    List<First3d> temp = [];
    for (int i = 0; i < firstlist.length; i++) {
      First3d ft = new First3d();
      ft.number = firstlist[i].number;
      ft.total = firstlist[i].total;
      temp.add(ft);
    }
    temp.sort(totalCompare);

    if (temp[0].total == 0) {
      first_topdigit = -1;
      first_seconddigit = -1;
      first_thirddigit = -1;
    } else if (temp[1].total == 0) {
      first_topdigit = temp[0].number ?? 0;
      first_seconddigit = -1;
      first_thirddigit = -1;
    } else if (temp[2].total == 0) {
      first_topdigit = temp[0].number ?? 0;
      first_seconddigit = temp[1].number ?? 0;
      first_thirddigit = -1;
    } else {
      first_topdigit = temp[0].number ?? 0;
      first_seconddigit = temp[1].number ?? 0;
      first_thirddigit = temp[2].number ?? 0;
    }
  }

  List<int> middlelistvalue = [];

  void Check_middleTopDigits() {
    int totalvote = 0;
    for (int i = 0; i < middledatalist.length; i++) {
      totalvote = totalvote + middledatalist[i].total!.toInt();
    }
    middlelistvalue = [];
    for (int i = 0; i < middledatalist.length; i++) {
      int mytotal = middledatalist[i].total!;
      double percentage = (mytotal * 100) / totalvote;
      try {
        print(percentage.toString());
        middlelistvalue.add(percentage.toInt());
      } catch (e) {
        middlelistvalue.add(0);
      }

      //
    }

    List<First3d> temp = [];
    for (int i = 0; i < middledatalist.length; i++) {
      First3d ft = new First3d();
      ft.number = middledatalist[i].number;
      ft.total = middledatalist[i].total;
      temp.add(ft);
    }
    temp.sort(totalCompare);

    if (temp[0].total == 0) {
      middle_topdigit = -1;
      middle_seconddigit = -1;
      middle_thirddigit = -1;
    } else if (temp[1].total == 0) {
      middle_topdigit = temp[0].number ?? 0;
      middle_seconddigit = -1;
      middle_thirddigit = -1;
    } else if (temp[2].total == 0) {
      middle_topdigit = temp[0].number ?? 0;
      middle_seconddigit = temp[1].number ?? 0;
      middle_thirddigit = -1;
    } else {
      middle_topdigit = temp[0].number ?? 0;
      middle_seconddigit = temp[1].number ?? 0;
      middle_thirddigit = temp[2].number ?? 0;
    }
  }

  List<int> lastlistvalue = [];

  void Check_lastTopDigits() {
    int totalvote = 0;
    for (int i = 0; i < lastdatalist.length; i++) {
      totalvote = totalvote + lastdatalist[i].total!.toInt();
    }
    lastlistvalue = [];
    for (int i = 0; i < lastdatalist.length; i++) {
      int mytotal = lastdatalist[i].total!;
      double percentage = (mytotal * 100) / totalvote;
      try {
        print(percentage.toString());
        lastlistvalue.add(percentage.toInt());
      } catch (e) {
        lastlistvalue.add(0);
      }

      //
    }

    List<First3d> temp = [];
    for (int i = 0; i < lastdatalist.length; i++) {
      First3d ft = new First3d();
      ft.number = lastdatalist[i].number;
      ft.total = lastdatalist[i].total;
      temp.add(ft);
    }
    temp.sort(totalCompare);

    if (temp[0].total == 0) {
      last_topdigit = -1;
      last_seconddigit = -1;
      last_thirddigit = -1;
    } else if (temp[1].total == 0) {
      last_topdigit = temp[0].number ?? 0;
      last_seconddigit = -1;
      last_thirddigit = -1;
    } else if (temp[2].total == 0) {
      last_topdigit = temp[0].number ?? 0;
      last_seconddigit = temp[1].number ?? 0;
      last_thirddigit = -1;
    } else {
      last_topdigit = temp[0].number ?? 0;
      last_seconddigit = temp[1].number ?? 0;
      last_thirddigit = temp[2].number ?? 0;
    }
  }

  List<int> ftlistvalue = [];

  void Check_ftTopDigits() {
    int totalvote = 0;
    for (int i = 0; i < firsttwolist.length; i++) {
      totalvote = totalvote + firsttwolist[i].total!.toInt();
    }
    ftlistvalue = [];
    for (int i = 0; i < firsttwolist.length; i++) {
      int mytotal = firsttwolist[i].total!;
      double percentage = (mytotal * 100) / totalvote;
      try {
        print(percentage.toString());
        ftlistvalue.add(percentage.toInt());
      } catch (e) {
        ftlistvalue.add(0);
      }

      //
    }

    List<First3d> temp = [];
    for (int i = 0; i < firsttwolist.length; i++) {
      First3d ft = new First3d();
      ft.number = firsttwolist[i].number;
      ft.total = firsttwolist[i].total;
      temp.add(ft);
    }
    temp.sort(totalCompare);

    if (temp[0].total == 0) {
      ft_topdigit = -1;
      ft_seconddigit = -1;
      ft_thirddigit = -1;
    } else if (temp[1].total == 0) {
      ft_topdigit = temp[0].number ?? 0;
      ft_seconddigit = -1;
      ft_thirddigit = -1;
    } else if (temp[2].total == 0) {
      ft_topdigit = temp[0].number ?? 0;
      ft_seconddigit = temp[1].number ?? 0;
      ft_thirddigit = -1;
    } else {
      ft_topdigit = temp[0].number ?? 0;
      ft_seconddigit = temp[1].number ?? 0;
      ft_thirddigit = temp[2].number ?? 0;
    }
  }

  List<int> ltlistvalue = [];

  void Check_ltTopDigits() {
    int totalvote = 0;
    for (int i = 0; i < lasrtwolist.length; i++) {
      totalvote = totalvote + lasrtwolist[i].total!.toInt();
    }
    ltlistvalue = [];
    for (int i = 0; i < lasrtwolist.length; i++) {
      int mytotal = lasrtwolist[i].total!;
      double percentage = (mytotal * 100) / totalvote;
      try {
        print(percentage.toString());
        ltlistvalue.add(percentage.toInt());
      } catch (e) {
        ltlistvalue.add(0);
      }

      //
    }

    List<First3d> temp = [];
    for (int i = 0; i < lasrtwolist.length; i++) {
      First3d ft = new First3d();
      ft.number = lasrtwolist[i].number;
      ft.total = lasrtwolist[i].total;
      temp.add(ft);
    }
    temp.sort(totalCompare);

    if (temp[0].total == 0) {
      lt_topdigit = -1;
      lt_seconddigit = -1;
      lt_thirddigit = -1;
    } else if (temp[1].total == 0) {
      lt_topdigit = temp[0].number ?? 0;
      lt_seconddigit = -1;
      lt_thirddigit = -1;
    } else if (temp[2].total == 0) {
      lt_topdigit = temp[0].number ?? 0;
      lt_seconddigit = temp[1].number ?? 0;
      lt_thirddigit = -1;
    } else {
      lt_topdigit = temp[0].number ?? 0;
      lt_seconddigit = temp[1].number ?? 0;
      lt_thirddigit = temp[2].number ?? 0;
    }
  }

  List<int> fllistvalue = [];

  void Check_flTopDigits() {
    int totalvote = 0;
    for (int i = 0; i < firstandlastlist.length; i++) {
      totalvote = totalvote + firstandlastlist[i].total!.toInt();
    }
    fllistvalue = [];
    for (int i = 0; i < firstandlastlist.length; i++) {
      int mytotal = firstandlastlist[i].total!;
      double percentage = (mytotal * 100) / totalvote;
      try {
        print(percentage.toString());
        fllistvalue.add(percentage.toInt());
      } catch (e) {
        fllistvalue.add(0);
      }

      //
    }

    List<First3d> temp = [];
    for (int i = 0; i < firstandlastlist.length; i++) {
      First3d ft = new First3d();
      ft.number = firstandlastlist[i].number;
      ft.total = firstandlastlist[i].total;
      temp.add(ft);
    }
    temp.sort(totalCompare);

    if (temp[0].total == 0) {
      fl_topdigit = -1;
      fl_seconddigit = -1;
      fl_thirddigit = -1;
    } else if (temp[1].total == 0) {
      fl_topdigit = temp[0].number ?? 0;
      fl_seconddigit = -1;
      fl_thirddigit = -1;
    } else if (temp[2].total == 0) {
      fl_topdigit = temp[0].number ?? 0;
      fl_seconddigit = temp[1].number ?? 0;
      fl_thirddigit = -1;
    } else {
      fl_topdigit = temp[0].number ?? 0;
      fl_seconddigit = temp[1].number ?? 0;
      fl_thirddigit = temp[2].number ?? 0;
    }
  }

  int totalCompare(u1, u2) => u2.total - u1.total;

  List<Widget> getRow() {
    var a = <Widget>[];

    List<First3d> temp = [];
    for(int i=0;i<firstlist.length;i++){
      First3d ft = new First3d();
      ft.number =firstlist[i].number;
      ft.total = firstlist[i].total;
      ft.isme = firstlist[i].isme;
      temp.add(ft);
    }
    temp.sort(totalCompare);



    for (int i = 0; i < temp.length; i++) {
      bool ischeck = temp[i].isme ?? false;

      a.add(Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: ischeck ? Colors.red : Colors.transparent,
            border: Border.all(
                color: ischeck
                    ?isdarkthem
                    ? myColor.white
                    :Colors.black
                    : isdarkthem
                        ? myColor.white
                        : Colors.black,
                width: 1),
            borderRadius: BorderRadius.all(const Radius.circular(3.0))),
        child: InkWell(
          onTap: () {
            ClickFD(temp[i].number!);
          },
          child: Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: Text(
              temp[i].number.toString(),
              style: TextStyle(
                fontSize: 14.0,
                color: ischeck
                    ? Colors.white
                    : isdarkthem
                        ? myColor.white
                        : Colors.black,
              ),
            ),
          ),
        ),
      ));
    }
    return a;
  }

  Future<void> ClickFD(int index) async {
    bool ischeck = firstlist[index].isme ?? false;

    if (ischeck) {
      firstlist[index].isme = false;
      int currenttotal = firstlist[index].total ?? 0;
      firstlist[index].total = currenttotal - 1;
    } else {
      int count = 0;
      for (int i = 0; i < firstlist.length; i++) {
        bool ischeck1 = firstlist[i].isme ?? false;
        if (ischeck1) {
          count++;
        }
      }

      if (count == 0 || count == 1 || count == 2) {
        firstlist[index].isme = true;
        int currenttotal = firstlist[index].total ?? 0;
        firstlist[index].total = currenttotal + 1;
      } else {
        for (int k = 0; k < firstlist.length; k++) {
          bool ischeck1 = firstlist[k].isme ?? false;
          if (ischeck1) {
            int currenttotal = firstlist[k].total ?? 0;
            currenttotal--;
            firstlist[k].total = currenttotal;
          }
          firstlist[k].isme = false;
        }

        firstlist[index].isme = true;
        int currenttotal = firstlist[index].total ?? 0;
        firstlist[index].total = currenttotal + 1;
      }
    }
    Check_FirstTopDigits();

    setState(() {});

    int no1 = -1;
    int no2 = -1;
    int no3 = -1;
    for (int i = 0; i < firstlist.length; i++) {
      bool ischeck3 = firstlist[i].isme ?? false;
      if (ischeck3) {
        if (no1 == -1) {
          no1 = firstlist[i].number!;
        } else if (no2 == -1) {
          no2 = firstlist[i].number!;
        } else {
          no3 = firstlist[i].number!;
        }
      }
    }

    var json = {
      "number1": no1.toString(),
      "number2": no2.toString(),
      "number3": no3.toString(),
      "type": 'First',
    };

    var urlserver = Uri.parse(votbest3d);
    Response response = await post(urlserver,
        body: json, headers: {HttpHeaders.authorizationHeader: token});
    print(response.body.toString());
  }

  ////middle/////
  List<Widget> getRowmiddle() {
    var a = <Widget>[];
    for (int i = 0; i < 10; i++) {
      double b = 0;
      if (i != 0) {
        b = 5;
      }

      bool ischeck = middledatalist[i].isme ?? false;

      a.add(Container(
        margin: EdgeInsets.only(left: b),
        decoration: BoxDecoration(
            color: ischeck ? Colors.red : Colors.transparent,
            border: Border.all(
                color: ischeck ? Colors.red :  isdarkthem
                    ? myColor.white
                    : Colors.black, width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(3.0))),
        child: InkWell(
          onTap: () {
            Clickmiddle(i);
          },
          child: Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: Text(
              '$i',
              style: TextStyle(
                fontSize: 14.0,
                color: ischeck ? Colors.white : isdarkthem
                    ? myColor.white
                    :  Colors.black,
              ),
            ),
          ),
        ),
      ));
    }
    return a;
  }

  Future<void> Clickmiddle(int index) async {
    bool ischeck = middledatalist[index].isme ?? false;

    if (ischeck) {
      middledatalist[index].isme = false;
      int currenttotal = middledatalist[index].total ?? 0;
      middledatalist[index].total = currenttotal - 1;
    } else {
      int count = 0;
      for (int i = 0; i < middledatalist.length; i++) {
        bool ischeck1 = middledatalist[i].isme ?? false;
        if (ischeck1) {
          count++;
        }
      }

      if (count == 0 || count == 1 || count == 2) {
        middledatalist[index].isme = true;
        int currenttotal = middledatalist[index].total ?? 0;
        middledatalist[index].total = currenttotal + 1;
      } else {
        for (int k = 0; k < middledatalist.length; k++) {
          bool ischeck1 = middledatalist[k].isme ?? false;
          if (ischeck1) {
            int currenttotal = middledatalist[k].total ?? 0;
            currenttotal--;
            middledatalist[k].total = currenttotal;
          }
          middledatalist[k].isme = false;
        }

        middledatalist[index].isme = true;
        int currenttotal = middledatalist[index].total ?? 0;
        middledatalist[index].total = currenttotal + 1;
      }
    }
    Check_middleTopDigits();

    setState(() {});

    int no1 = -1;
    int no2 = -1;
    int no3 = -1;
    for (int i = 0; i < middledatalist.length; i++) {
      bool ischeck3 = middledatalist[i].isme ?? false;
      if (ischeck3) {
        if (no1 == -1) {
          no1 = middledatalist[i].number!;
        } else if (no2 == -1) {
          no2 = middledatalist[i].number!;
        } else {
          no3 = middledatalist[i].number!;
        }
      }
    }

    var json = {
      "number1": no1.toString(),
      "number2": no2.toString(),
      "number3": no3.toString(),
      "type": 'Middle',
    };

    var urlserver = Uri.parse(votbest3d);
    Response response = await post(urlserver,
        body: json, headers: {HttpHeaders.authorizationHeader: token});
    print(response.body.toString());
  }

  ////last/////
  List<Widget> getRowlast() {
    var a = <Widget>[];
    for (int i = 0; i < 10; i++) {
      double b = 0;
      if (i != 0) {
        b = 5;
      }

      bool ischeck = lastdatalist[i].isme ?? false;

      a.add(Container(
        margin: EdgeInsets.only(left: b),
        decoration: BoxDecoration(
            color: ischeck ? Colors.red : Colors.transparent,
            border: Border.all(
                color: ischeck ? Colors.red :  isdarkthem
                    ? myColor.white
                    : Colors.black, width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(3.0))),
        child: InkWell(
          onTap: () {
            Clicklast(i);
          },
          child: Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: Text(
              '$i',
              style: TextStyle(
                fontSize: 14.0,
                color: ischeck ? Colors.white : isdarkthem
                    ? myColor.white
                    :  Colors.black,
              ),
            ),
          ),
        ),
      ));
    }
    return a;
  }

  Future<void> Clicklast(int index) async {
    bool ischeck = lastdatalist[index].isme ?? false;

    if (ischeck) {
      lastdatalist[index].isme = false;
      int currenttotal = lastdatalist[index].total ?? 0;
      lastdatalist[index].total = currenttotal - 1;
    } else {
      int count = 0;
      for (int i = 0; i < lastdatalist.length; i++) {
        bool ischeck1 = lastdatalist[i].isme ?? false;
        if (ischeck1) {
          count++;
        }
      }

      if (count == 0 || count == 1 || count == 2) {
        lastdatalist[index].isme = true;
        int currenttotal = lastdatalist[index].total ?? 0;
        lastdatalist[index].total = currenttotal + 1;
      } else {
        for (int k = 0; k < lastdatalist.length; k++) {
          bool ischeck1 = lastdatalist[k].isme ?? false;
          if (ischeck1) {
            int currenttotal = lastdatalist[k].total ?? 0;
            currenttotal--;
            lastdatalist[k].total = currenttotal;
          }
          lastdatalist[k].isme = false;
        }

        lastdatalist[index].isme = true;
        int currenttotal = lastdatalist[index].total ?? 0;
        lastdatalist[index].total = currenttotal + 1;
      }
    }
    Check_lastTopDigits();

    setState(() {});

    int no1 = -1;
    int no2 = -1;
    int no3 = -1;
    for (int i = 0; i < lastdatalist.length; i++) {
      bool ischeck3 = lastdatalist[i].isme ?? false;
      if (ischeck3) {
        if (no1 == -1) {
          no1 = lastdatalist[i].number!;
        } else if (no2 == -1) {
          no2 = lastdatalist[i].number!;
        } else {
          no3 = lastdatalist[i].number!;
        }
      }
    }

    var json = {
      "number1": no1.toString(),
      "number2": no2.toString(),
      "number3": no3.toString(),
      "type": 'Last',
    };

    var urlserver = Uri.parse(votbest3d);
    Response response = await post(urlserver,
        body: json, headers: {HttpHeaders.authorizationHeader: token});
    print(response.body.toString());
  }

  ////Ft/////
  List<Widget> getRowFt() {
    var a = <Widget>[];
    for (int i = 0; i < 10; i++) {
      double b = 0;
      if (i != 0) {
        b = 5;
      }

      bool ischeck = firsttwolist[i].isme ?? false;

      a.add(Container(
        margin: EdgeInsets.only(left: b),
        decoration: BoxDecoration(
            color: ischeck ? Colors.red : Colors.transparent,
            border: Border.all(
                color: ischeck ? Colors.red : isdarkthem
                    ? myColor.white
                    :  Colors.black, width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(3.0))),
        child: InkWell(
          onTap: () {
            ClickFt(i);
          },
          child: Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: Text(
              '$i',
              style: TextStyle(
                fontSize: 14.0,
                color: ischeck ? Colors.white : isdarkthem
                    ? myColor.white
                    :  Colors.black,
              ),
            ),
          ),
        ),
      ));
    }
    return a;
  }

  Future<void> ClickFt(int index) async {
    bool ischeck = firsttwolist[index].isme ?? false;

    if (ischeck) {
      firsttwolist[index].isme = false;
      int currenttotal = firsttwolist[index].total ?? 0;
      firsttwolist[index].total = currenttotal - 1;
    } else {
      int count = 0;
      for (int i = 0; i < firsttwolist.length; i++) {
        bool ischeck1 = firsttwolist[i].isme ?? false;
        if (ischeck1) {
          count++;
        }
      }

      if (count == 0 || count == 1 || count == 2) {
        firsttwolist[index].isme = true;
        int currenttotal = firsttwolist[index].total ?? 0;
        firsttwolist[index].total = currenttotal + 1;
      } else {
        for (int k = 0; k < firsttwolist.length; k++) {
          bool ischeck1 = firsttwolist[k].isme ?? false;
          if (ischeck1) {
            int currenttotal = firsttwolist[k].total ?? 0;
            currenttotal--;
            firsttwolist[k].total = currenttotal;
          }
          firsttwolist[k].isme = false;
        }

        firsttwolist[index].isme = true;
        int currenttotal = firsttwolist[index].total ?? 0;
        firsttwolist[index].total = currenttotal + 1;
      }
    }
    Check_ftTopDigits();

    setState(() {});

    int no1 = -1;
    int no2 = -1;
    int no3 = -1;
    for (int i = 0; i < firsttwolist.length; i++) {
      bool ischeck3 = firsttwolist[i].isme ?? false;
      if (ischeck3) {
        if (no1 == -1) {
          no1 = firsttwolist[i].number!;
        } else if (no2 == -1) {
          no2 = firsttwolist[i].number!;
        } else {
          no3 = firsttwolist[i].number!;
        }
      }
    }

    var json = {
      "number1": no1.toString(),
      "number2": no2.toString(),
      "number3": no3.toString(),
      "type": 'First Two',
    };

    var urlserver = Uri.parse(votbest3d);
    Response response = await post(urlserver,
        body: json, headers: {HttpHeaders.authorizationHeader: token});
    print(response.body.toString());
  }

  ////lt/////
  List<Widget> getRowlt() {
    var a = <Widget>[];
    for (int i = 0; i < 10; i++) {
      double b = 0;
      if (i != 0) {
        b = 5;
      }

      bool ischeck = lasrtwolist[i].isme ?? false;

      a.add(Container(
        margin: EdgeInsets.only(left: b),
        decoration: BoxDecoration(
            color: ischeck ? Colors.red : Colors.transparent,
            border: Border.all(
                color: ischeck ? Colors.red : isdarkthem
                    ? myColor.white
                    :  Colors.black, width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(3.0))),
        child: InkWell(
          onTap: () {
            Clicklt(i);
          },
          child: Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: Text(
              '$i',
              style: TextStyle(
                fontSize: 14.0,
                color: ischeck ? Colors.white :  isdarkthem
                    ? myColor.white
                    : Colors.black,
              ),
            ),
          ),
        ),
      ));
    }
    return a;
  }

  Future<void> Clicklt(int index) async {
    bool ischeck = lasrtwolist[index].isme ?? false;

    if (ischeck) {
      lasrtwolist[index].isme = false;
      int currenttotal = lasrtwolist[index].total ?? 0;
      lasrtwolist[index].total = currenttotal - 1;
    } else {
      int count = 0;
      for (int i = 0; i < lasrtwolist.length; i++) {
        bool ischeck1 = lasrtwolist[i].isme ?? false;
        if (ischeck1) {
          count++;
        }
      }

      if (count == 0 || count == 1 || count == 2) {
        lasrtwolist[index].isme = true;
        int currenttotal = lasrtwolist[index].total ?? 0;
        lasrtwolist[index].total = currenttotal + 1;
      } else {
        for (int k = 0; k < lasrtwolist.length; k++) {
          bool ischeck1 = lasrtwolist[k].isme ?? false;
          if (ischeck1) {
            int currenttotal = lasrtwolist[k].total ?? 0;
            currenttotal--;
            lasrtwolist[k].total = currenttotal;
          }
          lasrtwolist[k].isme = false;
        }

        lasrtwolist[index].isme = true;
        int currenttotal = lasrtwolist[index].total ?? 0;
        lasrtwolist[index].total = currenttotal + 1;
      }
    }
    Check_ltTopDigits();

    setState(() {});

    int no1 = -1;
    int no2 = -1;
    int no3 = -1;
    for (int i = 0; i < lasrtwolist.length; i++) {
      bool ischeck3 = lasrtwolist[i].isme ?? false;
      if (ischeck3) {
        if (no1 == -1) {
          no1 = lasrtwolist[i].number!;
        } else if (no2 == -1) {
          no2 = lasrtwolist[i].number!;
        } else {
          no3 = lasrtwolist[i].number!;
        }
      }
    }

    var json = {
      "number1": no1.toString(),
      "number2": no2.toString(),
      "number3": no3.toString(),
      "type": 'Last Two',
    };

    var urlserver = Uri.parse(votbest3d);
    Response response = await post(urlserver,
        body: json, headers: {HttpHeaders.authorizationHeader: token});
    print(response.body.toString());
  }

  ////fl/////
  List<Widget> getRowfl() {
    var a = <Widget>[];
    for (int i = 0; i < 10; i++) {
      double b = 0;
      if (i != 0) {
        b = 5;
      }

      bool ischeck = firstandlastlist[i].isme ?? false;

      a.add(Container(
        margin: EdgeInsets.only(left: b),
        decoration: BoxDecoration(
            color: ischeck ? Colors.red : Colors.transparent,
            border: Border.all(
                color: ischeck ? Colors.red :  isdarkthem
                    ? myColor.white
                    : Colors.black, width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(3.0))),
        child: InkWell(
          onTap: () {
            Clickfl(i);
          },
          child: Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: Text(
              '$i',
              style: TextStyle(
                fontSize: 14.0,
                color: ischeck ? Colors.white : isdarkthem
                    ? myColor.white
                    :  Colors.black,
              ),
            ),
          ),
        ),
      ));
    }
    return a;
  }

  Future<void> Clickfl(int index) async {
    bool ischeck = firstandlastlist[index].isme ?? false;

    if (ischeck) {
      firstandlastlist[index].isme = false;
      int currenttotal = firstandlastlist[index].total ?? 0;
      firstandlastlist[index].total = currenttotal - 1;
    } else {
      int count = 0;
      for (int i = 0; i < firstandlastlist.length; i++) {
        bool ischeck1 = firstandlastlist[i].isme ?? false;
        if (ischeck1) {
          count++;
        }
      }

      if (count == 0 || count == 1 || count == 2) {
        firstandlastlist[index].isme = true;
        int currenttotal = firstandlastlist[index].total ?? 0;
        firstandlastlist[index].total = currenttotal + 1;
      } else {
        for (int k = 0; k < firstandlastlist.length; k++) {
          bool ischeck1 = firstandlastlist[k].isme ?? false;
          if (ischeck1) {
            int currenttotal = firstandlastlist[k].total ?? 0;
            currenttotal--;
            firstandlastlist[k].total = currenttotal;
          }
          firstandlastlist[k].isme = false;
        }

        firstandlastlist[index].isme = true;
        int currenttotal = firstandlastlist[index].total ?? 0;
        firstandlastlist[index].total = currenttotal + 1;
      }
    }
    Check_flTopDigits();

    setState(() {});

    int no1 = -1;
    int no2 = -1;
    int no3 = -1;
    for (int i = 0; i < firstandlastlist.length; i++) {
      bool ischeck3 = firstandlastlist[i].isme ?? false;
      if (ischeck3) {
        if (no1 == -1) {
          no1 = firstandlastlist[i].number!;
        } else if (no2 == -1) {
          no2 = firstandlastlist[i].number!;
        } else {
          no3 = firstandlastlist[i].number!;
        }
      }
    }

    var json = {
      "number1": no1.toString(),
      "number2": no2.toString(),
      "number3": no3.toString(),
      "type": 'Frist & Last',
    };

    var urlserver = Uri.parse(votbest3d);
    Response response = await post(urlserver,
        body: json, headers: {HttpHeaders.authorizationHeader: token});
    print(response.body.toString());
  }

  List<SalesData> firstlistvalueSetdata(int pos) {
    List<SalesData> sd=[];
    List<First3d> orgg = [];
    List<First3d> temp = [];
    if(pos==1){
      orgg=firstlist;
    }

    for(int i=0;i<orgg.length;i++){
      First3d ft = new First3d();
      ft.number =orgg[i].number;
      ft.total = orgg[i].total;
      ft.isme = orgg[i].isme;
      temp.add(ft);
    }
    temp.sort(totalCompare);

    return sd;
  }
}

class SalesData {
  SalesData(this.x, this.y);

  final String x;
  final double? y;
}
