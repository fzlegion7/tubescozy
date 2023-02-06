

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tubescozy/modules/home/detail.dart';
import 'package:tubescozy/modules/home/history.dart';
import 'package:tubescozy/main.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tubescozy/modules/home/search.dart';
import 'package:tubescozy/controllers/auth_controller.dart';

import 'home.dart';


int sel = 0;
double? width;
double? height;
final bodies = [DetailScreen(), History(), HomeScreen()];

class Detail extends StatefulWidget {
  const Detail({Key? key}) : super(key: key);

  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  List<BottomNavigationBarItem> createItems() {
    List<BottomNavigationBarItem> items = [];
    items.add(BottomNavigationBarItem(
        activeIcon: Icon(
          Icons.home,
          color: appTheme.primaryColor,
        ),
        icon: Icon(
          Icons.home,
          color: Colors.black,
        ),
        label: "Explore"));
    items.add(BottomNavigationBarItem(
        activeIcon: Icon(
          Icons.app_registration,
          color: appTheme.primaryColor,
        ),
        icon: Icon(
          Icons.app_registration,
          color: Colors.black,
        ),
        label: "Progress"));
    items.add(BottomNavigationBarItem(
        activeIcon: Icon(
          Icons.account_box_rounded,
          color: appTheme.primaryColor,
        ),
        icon: Icon(
          Icons.account_box_rounded,
          color: Colors.black,
        ),
        label: "Deals"));
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodies.elementAt(sel),
    );
  }
}

class DetailScreen extends StatelessWidget {
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
            children: <Widget>[Detail1()]
        ),
      ),
    );
  }
}

var selectedloc = 0;

class Detail1 extends StatefulWidget {
  @override
  _Detail1 createState() => _Detail1();
}

class _Detail1 extends State<Detail1> {
  String name = "";
  String pilihan = "";
  dynamic infouser;
  final _auth = FirebaseAuth.instance;
  String _email = "";
  String _pass = "";
  final _emailController = TextEditingController();
  @override
  void initState(){
    super.initState();
    _getCurrentUser();
  }

  _getCurrentUser() async {
    final  user = await FirebaseAuth.instance.currentUser!;
    setState(() {
      _email = user.email!;
    });
  }


  var isHouseselected = true;
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Stack(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: height! / 16,
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: width! * 0.05,
                      ),
                      InkWell(
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                          onTap: ()=>  Navigator.push(context,MaterialPageRoute(builder: (context) => HomeScreen()),
                          ),
                      ),
                      SizedBox(
                        width: width! * 0.05,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: <Widget>[
                      InkWell(
                        child: Row(
                          children: [
                            SizedBox(
                              width: 100,
                            ),
                            Icon(
                              Icons.account_box_rounded,
                              color: Colors.white,),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Menu Akun Anda",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 15
                              ),
                            )
                          ],

                        ),
                        onTap: () {
                        },
                      ),
                      SizedBox(
                        width: width! * 0.05,
                      ),
                      Spacer(),
                      SizedBox(
                        width: width! * 0.05,
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            width: 350,
                            height: 450,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30)
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Detail Akun",
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                  ),),
                                Container(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text("Email : " ,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 15
                                      ),),
                                      Text(_email,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 15
                                        ),),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    try {
                                      await FirebaseAuth.instance.sendPasswordResetEmail(email: _email);
                                      print("Password reset email sent.");
                                    } catch (e) {
                                      print(e);
                                    }
                                    showDialog(
                                      context: context,
                                      builder: (
                                          BuildContext context) {
                                        return AlertDialog(
                                          title: Text("Reset Password Berhasil"),
                                          content: Text(
                                              "Cek E-Mail anda !"),
                                          actions: <Widget>[
                                            TextButton(
                                              child: Text("OK"),
                                              onPressed: () {
                                                Navigator.of(
                                                    context)
                                                    .pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Text('Reset Password'),
                                ),

                                ElevatedButton(
                                  onPressed: ()=> authC.logout(),
                                  child: const Text('Logout'),
                                ),

                              ],
                            )
                        ),
                      ]
                  ),
                ),
              ],
            ),
          )
        ]

    );

  }
}

