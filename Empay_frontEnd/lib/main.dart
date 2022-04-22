
import 'package:dio/dio.dart';
import 'package:empay/homepage.dart';
import 'package:flutter/material.dart';
List<List<String>> employeeDetails = [
  // ['Soham Sakaria', 'FrontEnd', '50000', 'CTech', '101'],
  // ['Eeshan Dutta', 'FrontEnd', '50000', 'CTech', '101'],
  // ['Parth Pandey', 'FrontEnd', '50000', 'CTech', '101'],
  // ['Parth Srivastava', 'FrontEnd', '50000', 'CTech', '101'],
];
Future extendFutureclass()async {
  print('check to function call');

  var response = await Dio().get(
    'http://localhost:8000/EmployeeDetails',
  );

  //var decoded = jsonDecode(response.data['data'][0]);
  print(response.data['data'][1]['Name']);
  for (int c = 0; c < response.data['data'].length; c++) {
    print(response.data['data'][c]);
    List<String> temp = [];
    temp.add(response.data['data'][c]['Name']);
    temp.add(response.data['data'][c]['Job_desc']);
    temp.add(response.data['data'][c]['Salary'].toString());
    temp.add(response.data['data'][c]['Dept_Name']);
    temp.add(response.data['data'][c]['id'].toString());
    // employeeDetails[c][0] = response.data['data'][c]['Name'];
    // employeeDetails[c][1] = response.data['data'][c]['Job_desc'];
    // employeeDetails[c][2] = response.data['data'][c]['Salary'];
    // employeeDetails[c][3] = response.data['data'][c]['Dept_Name'];
    // employeeDetails[c][4] = response.data['data'][c]['id'];
    employeeDetails.add(temp);
  }
  print(employeeDetails[0][0]);

}
Future<void> main() async {
  await extendFutureclass();
  runApp(const MaterialApp(
    home: HomePage(),
  ));
}
