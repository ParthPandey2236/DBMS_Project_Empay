
import 'package:dio/dio.dart';
import 'package:empay/homepage.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'main.dart';

class AddEmployee extends StatefulWidget {


  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

String name = "";
String jobTitle = "";
String salary = "";
String dept = "";

class _AddEmployeeState extends State<AddEmployee> {
  @override
  void initState() {
    super.initState();
    name = "";
    jobTitle = "";
    salary = "";
    dept = "";
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: h * 0.15,
        elevation: 0,
        title: RichText(
          text: TextSpan(children: [
            TextSpan(
                text: "Add an Employee",
                style:
                    TextStyle(fontSize: w * 0.075, fontWeight: FontWeight.bold))
          ]),
        ),
        backgroundColor: HexColor("#5400ff"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                "Details ",
                style:
                    TextStyle(fontSize: w * 0.09, fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Name",
                style:
                    TextStyle(fontSize: w * 0.06, fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                  decoration: const InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 10),
                      hintText: "Name",
                      border: InputBorder.none),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Job Title",
                style:
                    TextStyle(fontSize: w * 0.06, fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      jobTitle = value;
                    });
                  },
                  decoration: const InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 10),
                      hintText: "Job title",
                      border: InputBorder.none),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Salary",
                style:
                    TextStyle(fontSize: w * 0.06, fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      salary = value;
                    });
                  },
                  initialValue: salary.toString(),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: "Salary",
                      contentPadding: EdgeInsets.only(left: 10),
                      border: InputBorder.none),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Department",
                style:
                    TextStyle(fontSize: w * 0.06, fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: AbsorbPointer(
                  absorbing: false,
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        dept = value;
                      });
                    },
                    initialValue: dept,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                        hintText: "Department",
                        contentPadding: EdgeInsets.only(left: 10),
                        border: InputBorder.none),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: TextButton(
                  onPressed: () async {

                      print(salary + "* " + dept + name + jobTitle);
                      if (!salary.isEmpty ||
                          !dept.isEmpty ||
                          !name.isEmpty ||
                          !jobTitle.isEmpty) {
                        employeeDetails.add([name, jobTitle, salary, dept]);
                        var responce = await Dio().post('http://localhost:8000/newEmployee',
                        data: {
                          'name' : name,
                           'dept_name':dept,
                          'Job_Des':jobTitle,
                          'Salary':salary
                        });
                        print(responce.data['message']);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  HomePage()),
                            (route) => false);
                      } else {
                        print(salary + dept + name + jobTitle);
                        showAlertDialog(context);
                      }

                  },
                  child: Card(
                    elevation: 20,
                    shadowColor: Colors.black38,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: SizedBox(
                      height: h * 0.07,
                      width: w * 0.4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                              textAlign: TextAlign.center,
                              text: const TextSpan(
                                  text: "Save",
                                  style: TextStyle(color: Colors.black)))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Error"),
      content: const Text("Please fill out all the details"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
