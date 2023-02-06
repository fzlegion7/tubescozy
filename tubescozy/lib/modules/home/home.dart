import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tubescozy/modules/home/detail.dart';
import 'package:tubescozy/modules/home/history.dart';
import 'package:tubescozy/main.dart';
import 'package:tubescozy/modules/home/search.dart';
import 'package:tubescozy/controllers/auth_controller.dart';
import 'package:tubescozy/modules/home/burger.dart';
import 'package:tubescozy/modules/home/kentang.dart';
import 'package:tubescozy/modules/home/latte.dart';
import 'package:tubescozy/modules/home/cappucino.dart';
import 'package:tubescozy/modules/login/login.dart';
import 'package:tubescozy/modules/home/maps.dart';
import 'package:tubescozy/modules/home/user.dart';

import '../../routes/app_pages.dart';


int sel = 0;
double? width;
double? height;
final bodies = [HomeScreen(), HistoryScreen(), DetailScreen()];

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<BottomNavigationBarItem> createItems() {
    List<BottomNavigationBarItem> items = [];
    items.add(BottomNavigationBarItem(
        activeIcon: Icon(
          Icons.restaurant,
          color: appTheme.primaryColor,
        ),
        icon: Icon(
          Icons.restaurant,
          color: Colors.black,
        ),
        label: "Menu"));
    return items;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: bodies.elementAt(sel),
        );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Navigation.selindex=0;

    width = MediaQuery.of(context).size.shortestSide;
    height = MediaQuery.of(context).size.longestSide;
    double h = 50;
    double w = 50;
    return Scaffold(
      // bottomNavigationBar: /*NavigationTest()*/Navigation(),

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[HomeTop()]
        ),
      ),
    );
  }
}

var selectedloc = 0;

class HomeTop extends StatefulWidget {
  @override
  _HomeTop createState() => _HomeTop();
}

class _HomeTop extends State<HomeTop> {

  List<String> _customCardControllers = [];
  List<String> _customCards = []
    ..add("Kopi Latte")
    ..add("Kopi Moccacino")
    ..add("Burger")
    ..add("Kentang")


  ;
  List<String> _menu =[
    "Kopi Latte",
    "Kopi Cappucino",
    "Burger",
    "Kentang",

];
  List<String> _harga =[
    "Rp14.000",
    "Rp15.000",
    "Rp18.000",
    "Rp12.000",
  ];
  List<String> _nameimg =[
    'img/latte.png',
    'img/cappucino.png',
    'img/burgir.png',
    'img/kentang.png',
  ];
  final _nameurl = const [
    latte(),
    cappucino(),
    burger(),
    kentang(),

  ];

  String name = "";
  String pilihan = "";
  var isHouseselected = true;
  final authC = Get.find<AuthController>();
  @override
  void initState() {
    _customCardControllers = List.generate(_customCards.length,
            (index) => _customCards[index]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[

        Container(
          height: height=1000,//400
            //color: Colors.tealAccent,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: height! / 16,
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: <Widget>[
                      InkWell(
                          child: Icon(
                            Icons.location_on,
                            color: Colors.black,
                          ),
                          onTap:() {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (
                                    BuildContext context) => maps()));
                          }
                      ),

                      SizedBox(
                        width: width! * 0.05,
                      ),
                      Spacer(),
                      InkWell(
                        child: Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                          onTap:() {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (
                                    BuildContext context) => DetailScreen()));
                          }
                      ),
                      SizedBox(
                        width: width! * 0.05,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height! / 16,
                ),
                Text(
                  'Yuk Order di Cozy!',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: height! * 0.0375),
                Container(
                  width: 300,
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    child: TextField(
                      onChanged: (val) {
                        setState(() {
                          name = val;
                        });
                      },
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                      cursorColor: appTheme.primaryColor,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 32, vertical: 13),
                          suffixIcon: Material(
                            child: InkWell(
                              child: Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                            ),
                            elevation: 2.0,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          )),

                    ),
                  ),
                ),
                SizedBox(
                  height: height! * 0.025,
                ),
                Container(
                    height: 650,
                    width: 380,
                    margin: EdgeInsets.only(left: 80),
                    child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.all(0.0),
                        scrollDirection: Axis.vertical,
                        itemCount: max(_menu.length, _nameimg.length),
                        itemBuilder: (BuildContext context, index) {
                          if (index < _menu.length)
                          {
                            if (_menu[index].toLowerCase().contains(name.toLowerCase())) {
                              return Container(
                                color: Colors.transparent,
                                child: Row(
                                  children: [
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: SizedBox(
                                        width: 240,
                                        height: 300,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                            ),
                                            primary: Colors.white,
                                          ),

                                          child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Image.asset(_nameimg[index]),
                                                Text(_menu[index],
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 25,
                                                      fontWeight: FontWeight.bold

                                                  ),
                                                ),
                                                Text(_harga[index],
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20,

                                                  ),
                                                ),
                                              ]
                                          ),
                                          onPressed: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => _nameurl[index]),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    )
                                  ],
                                ),
                              );

                            }
                            else {
                              return Visibility(
                                visible: _menu[index].toLowerCase().contains(name.toLowerCase()),
                                child: Container(
                                  child: Text(_menu[index]),
                                ),
                              );
                            }

                          }
                          else {
                            return Visibility(
                              visible: _menu[index].toLowerCase().contains(name.toLowerCase()),
                              child: Container(
                                child: Text(_menu[index]),
                              ),
                            );
                          }
                        }

                    )
                ),
                SizedBox(
                  height: 20,
                ),

]
    ),
                )

]
    );

  }
}

