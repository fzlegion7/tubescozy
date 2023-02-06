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


int sel = 0;
double? width;
double? height;
final bodies = [burgerscreen(), HistoryScreen(), Detail()];
final TextEditingController jumlahController = TextEditingController();
final TextEditingController keteranganController = TextEditingController();


class burger extends StatefulWidget {
  const burger({Key? key}) : super(key: key);

  _burgerState createState() => _burgerState();
}

class _burgerState extends State<burger> {
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

class burgerscreen extends StatelessWidget {
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
            children: <Widget>[burgers()]
        ),
      ),
    );
  }
}

var selectedloc = 0;

class burgers extends StatefulWidget {
  @override
  _burgers createState() => _burgers();
}

class _burgers extends State<burgers> {
  String name = "";
  String pilihan = "";
  dynamic infouser;
  final _auth = FirebaseAuth.instance;
  late String userEmail;

  Future<void>getCurrentUserInfo() async {
    infouser = await _auth.currentUser!;
    setState((){
      userEmail = infouser.data;
    });
  }
  @override
  void initState(){
    super.initState();
    getCurrentUserInfo();
  }


  var isHouseselected = true;
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference pembelian = firestore.collection('pembelian');
    return Stack(
        children: <Widget>[
          Container(
            height: height=1100,//400
            //color: Colors.tealAccent,
            child: Column(
                children: <Widget>[
                  SizedBox(
                    height: height! / 16,
                  ),
                  Padding(
                    padding: EdgeInsets.all(14.0),
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
                            onTap: ()=> Navigator.of(context).pop(true)
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height! / 16,
                  ),
                  Container(
                    height: height=850,//400
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
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                ),

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
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                    width: 350,
                                    height: 600,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(30)
                                    ),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 50,
                                        ),
                                        FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: SizedBox(
                                            width: 150,
                                            height: 200,
                                            child: Image.asset('img/burgir.png'),
                                          ),
                                        ),
                                        SizedBox(height: 15,),
                                        Text("Burger",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                        Text("Rp18.000",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 24,
                                          ),),
                                        SizedBox(height: 10,),
                                        Container(
                                          width: 290,
                                          height: 100,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text("Keterangan",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w600
                                                ),),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text("hidangan yang dibuat dari potongan-potongan kentang "
                                                  "yang digoreng engan minyak goreng.",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.black
                                                ),),
                                            ],
                                          ),
                                          decoration: BoxDecoration(
                                              color: Colors.black12,
                                              borderRadius: BorderRadius.circular(20)
                                          ),
                                        ),

                                        SizedBox(
                                            width: MediaQuery.of(context).size.width - 160,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                TextField(
                                                  controller: jumlahController,
                                                  decoration: InputDecoration(hintText:"Jumlah"),
                                                ),
                                                TextField(
                                                  controller: keteranganController,
                                                  decoration: InputDecoration(hintText:"Keterangan"),
                                                ),
                                              ],
                                            )
                                        ),
                                      ],
                                    )
                                ),
                                Container(
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  FittedBox(
                                                    fit: BoxFit.scaleDown,
                                                    child: SizedBox(
                                                        child: Row(
                                                          children: [
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            ElevatedButton(
                                                                style: ElevatedButton.styleFrom(
                                                                  shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.all(Radius.circular(30)),
                                                                  ),
                                                                  primary: Colors.black,
                                                                ),
                                                                child: Row(
                                                                  children: [
                                                                    Icon(Icons.shopping_cart),
                                                                    SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    Text("Beli",
                                                                      style: TextStyle(color: Colors.white),),
                                                                  ],
                                                                ),
                                                                onPressed: () async {
                                                                  await pembelian.add({

                                                                    'Nama Makanan': 'Burger',
                                                                    'Email': infouser.email,
                                                                    'Jumlah' : jumlahController.text,
                                                                    'Keterangan' : keteranganController.text,
                                                                  });
                                                                  jumlahController.text = '';
                                                                  keteranganController.text = '';

                                                                  showDialog(
                                                                    context: context,
                                                                    builder: (
                                                                        BuildContext context) {
                                                                      return AlertDialog(
                                                                        title: Text("Pembelian Berhasil"),
                                                                        content: Text(
                                                                            "Pembelian anda sudah berhasil!"),
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
                                                                }
                                                            )
                                                          ],
                                                        )
                                                    ),
                                                  ),
                                                ],
                                              )
                                          ),
                                        ]
                                    )

                                ),

                              ],
                            ),
                          )
                        ]
                    ),
                  )

                ]
            ),
          )
        ]
    );
  }
}

