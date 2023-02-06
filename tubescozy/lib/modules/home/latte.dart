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
final bodies = [lattescreen(), History(), Detail()];
final TextEditingController jumlahController = TextEditingController();
final TextEditingController keteranganController = TextEditingController();

class latte extends StatefulWidget {
  const latte({Key? key}) : super(key: key);

  _latteState createState() => _latteState();
}

class _latteState extends State<latte> {
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

class lattescreen extends StatelessWidget {
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
            children: <Widget>[lattes()]
        ),
      ),
    );
  }
}

var selectedloc = 0;

class lattes extends StatefulWidget {
  @override
  _lattes createState() => _lattes();
}

class _lattes extends State<lattes> {
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
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      children: <Widget>[
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

                  Container(
                    height: height=750,//400
                    //color: Colors.tealAccent,
                    child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: height! / 16,
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
                                            child: Image.asset('img/latte.png'),
                                          ),
                                        ),
                                        SizedBox(height: 15,),
                                        Text("Kopi Latte",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                        Text("Rp14.000",
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
                                              Text("latte atau kopi yang dicampur dengan susu dan "
                                                  "memiliki lapisan busa yang tipis di bagian atasnya.",
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

                                                                    'Nama Minuman': 'Kopi Latte',
                                                                    'Email': infouser.email,
                                                                    'Jumlah' : int.tryParse(jumlahController.text),
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


