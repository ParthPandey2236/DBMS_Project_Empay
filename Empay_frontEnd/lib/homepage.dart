// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'main.dart';
import 'package:dio/dio.dart';
import 'package:empay/addemp.dart';
import 'package:empay/employeeDetails.dart';
import 'package:empay/searchpage.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class HomePage extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const HomePage();

  @override
  State<HomePage> createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {

  @override
  Future<String> fetchEmployeeDetails() async {
      //await extendFutureclass();
      return "done";


  }

  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          floatingActionButton: TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddEmployee()));
            },
            child: Card(
              elevation: 20,
              shadowColor: Colors.black38,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Container(
                height: h * 0.06,
                //width: w * 0.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                              text: "Add Employee",
                              style: TextStyle(color: Colors.blue))),
                    )
                  ],
                ),
              ),
            ),
          ),
          appBar: AppBar(
            toolbarHeight: h * 0.15,
            elevation: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: 'WELCOME BACK',
                        style: TextStyle(
                            fontSize: w * 0.04, fontWeight: FontWeight.w200)),
                    TextSpan(
                        text: '\nMANAGER',
                        style: TextStyle(
                            fontSize: w * 0.075, fontWeight: FontWeight.bold))
                  ]),
                ),
                IconButton(
                    color: Colors.white,
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) =>  SearchPage())),
                    icon: const Icon(Icons.search))
              ],
            ),
            backgroundColor: HexColor("#5400ff"),
          ),
          body: FutureBuilder(
            builder: ((context, snapshot) {
              if(snapshot.hasData){
                return Column(
                  children: [
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "Manage your employees",
                        style:
                            TextStyle(color: Colors.black, fontSize: w * 0.06),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: GridView.builder(
                        itemCount: employeeDetails.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: w * 0.02,
                          mainAxisSpacing: w * 0.02,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return EmployeeCard(h, w, index);
                        },
                      ),
                    ),
                  ],
                );
              }
              else{
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
            future: fetchEmployeeDetails() ,
          )),
    );
  }

  Widget EmployeeCard(double h, double w, int index) {
    return Padding(
      padding: EdgeInsets.only(top: h * 0.02, left: w * 0.02, right: w * 0.02),
      child: TextButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EmployeeDetails(
                        index: index,
                      )));
        },
        child: Card(
          elevation: 20,
          shadowColor: Colors.black38,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Container(
            height: h * 0.2,
            width: w * 0.4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                          text: "Employee",
                          style: TextStyle(
                              fontSize: w * 0.025, color: Colors.grey)),
                      TextSpan(
                          text: "\n\n" + employeeDetails[index][0],
                          style: TextStyle(
                              fontSize: w * 0.035, color: Colors.blue)),
                      TextSpan(
                          text: "\n" + employeeDetails[index][1],
                          style: TextStyle(
                              fontSize: w * 0.035, color: Colors.blue)),
                      TextSpan(
                          text: "\n\n + Click to see more details",
                          style:
                              TextStyle(fontSize: w * 0.03, color: Colors.grey))
                    ]))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
