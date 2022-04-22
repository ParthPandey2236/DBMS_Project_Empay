
import 'package:empay/employeeDetails.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'main.dart';
import 'homepage.dart';

class SearchPage extends StatefulWidget {


  @override
  State<SearchPage> createState() => _SearchPageState();
}

List<List<String>> _empSearchDetails = [];
final _searchController = TextEditingController();
String searchElement = '';

class _SearchPageState extends State<SearchPage> {
  @override
  Future<void> fetchEmployeeDetails(String name) async {
    _empSearchDetails = [];
    for (int c = 0; c < employeeDetails.length; c++) {
      if (employeeDetails[c][0].contains(name)) {
        _empSearchDetails.add(employeeDetails[c]);
      }
    }
    print(_empSearchDetails);
  }

  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            toolbarHeight: h * 0.1,
            elevation: 0,
            backgroundColor: HexColor("#5400ff"),
            title: Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      searchElement = value;
                    });
                  },
                  controller: _searchController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                            searchElement = '';
                          });
                        },
                      ),
                      hintText: 'Search...',
                      border: InputBorder.none),
                ),
              ),
            )),
        body: FutureBuilder(
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(
                children: [
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "Search from your employees",
                      style: TextStyle(color: Colors.black, fontSize: w * 0.06),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: GridView.builder(
                      itemCount: _empSearchDetails.length,
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
          }),
          future: fetchEmployeeDetails(searchElement),
        ),
      ),
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
                          text: "\n\n" + _empSearchDetails[index][0],
                          style: TextStyle(
                              fontSize: w * 0.035, color: Colors.blue)),
                      TextSpan(
                          text: "\n" + _empSearchDetails[index][1],
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
