import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:haytek/Firebase_VeriTabani/hayvanekle/hayvanekle.dart';
import 'package:haytek/model/hayvanekle.dart';
import 'package:haytek/model/header.dart';
import 'package:haytek/classandvariable/veriler.dart';

class Hayvanlarim extends StatefulWidget {
  const Hayvanlarim({Key? key}) : super(key: key);
  @override
  State<Hayvanlarim> createState() => _HayvanlarimState();
}

bool _aramabool = false;
bool? _hayvanvar;
FirebaseAuth _auth =FirebaseAuth.instance;
class _HayvanlarimState extends State<Hayvanlarim> {
  final TextEditingController _arama = TextEditingController();
  Veriler veri = Veriler();
  @override
  initState(){
    _hayvanvarSorgula();
    _readHayvanlar();
    
    _aramabool=false;
  
   
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: (() {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) => ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.9),
                    child: Scaffold(
                      appBar: AppBar(
                        backgroundColor: Colors.transparent,
                        automaticallyImplyLeading: false,
                        title: Text(
                          "Hayvan Ekle",
                          style: TextStyle(
                            color: Color(0xFF375BA3),
                          ),
                        ),
                        actions: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.close),
                            color: Color(0xFF375BA3),
                          )
                        ],
                        elevation: 0,
                      ),
                      body: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: HayvanEkleModal(hayvanekeklendi: _hayvanvar),
                      ),
                    ),
                  ));
        }),
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(34),
            gradient: LinearGradient(
              colors: [Color(0xFF375BA3), Color(0xFF29E3D7)],
              begin: FractionalOffset.centerLeft,
              end: FractionalOffset.centerRight,
            ),
          ),
          child: Icon(
            Icons.add,
            color: Colors.white.withOpacity(0.8),
            size: 35,
          ),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.only(right: 16, left: 16,bottom: 16,top: 35),
          child: Column(
                children: [
                  Header(baslik: "Hayvanlar??m",),
                  //Hayvan??n K??pe Numaras?? Textfield
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(13),
                      border: Border.all(
                        width: 1,
                        color: Color(0xFF375BA3),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: TextField(
                        onChanged: (context) {
                          setState(() {
                            if (_arama.text.length==0) {
                              _aramabool = false;
                            } else {
                               _aramabool = true;
                              _arananHayvanlar();
          
                            }
                          });
                        },
                        controller: _arama,
                        cursorColor: Color(0xFF375BA3),
                        decoration: const InputDecoration(
                          labelStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          focusColor: Color(0xFF375BA3),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          fillColor:Color(0xFF375BA3) ,
                          suffixIconColor: Color(0xFF375BA3),
                          suffixIcon: Icon(Icons.search,color: Color(0xFF375BA3)),
                          hintText:
                              "Aramak ??stedi??iniz Hayvan??n K??pe Numaras??",
                          hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black45,
                          ),
                        ),
                      ),
                    ),
                  ),
                  _aramabool == false ?  
                       Expanded(
                          child: StreamBuilder<List<HayvanEkleFirebase>>(
                            stream: _readHayvanlar(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text(
                                    "Bir Hata Olu??tu - ${snapshot.error}");
                              } else if (snapshot.hasData) {
                                final _hayvanlar = snapshot.data!;
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: _hayvanlar
                                          .map(_buildhayvanlar)
                                          .toList(),
                                    ),
                                  ),
                                );
                              } 
                              else {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                          ),
                        )
                      : Expanded(
                          child: StreamBuilder<List<HayvanEkleFirebase>>(
                            stream: _arananHayvanlar(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text(
                                    "Bir Hata Olu??tu - ${snapshot.error}");
                              } else if (snapshot.hasData) {
                                final _hayvanlar = snapshot.data!;
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: _hayvanlar
                                          .map(_buildhayvanlar)
                                          .toList(),
                                    ),
                                  ),
                                );
                              } else {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                          ),
                        )
                ],
              ),),
    );
  }
Future _hayvanvarSorgula() async {
   Query<Map<String, dynamic>> sorgu = FirebaseFirestore.instance
      .collection('kullanicilar').doc(kullaniciId)
        .collection('hayvanlar');
    QuerySnapshot<Map<String, dynamic>> snapshot = await sorgu.get();

    if (snapshot.docs.isNotEmpty) {
     _hayvanvar=true;
    } else {
    _hayvanvar=false;
    }
  }
  Stream<List<HayvanEkleFirebase>> _arananHayvanlar() {
    return FirebaseFirestore.instance
        .collection('kullanicilar')
        .doc(_auth.currentUser!.uid)
        .collection("hayvanlar")
        .where("hayvaninkupeno", isEqualTo: _arama.text)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => HayvanEkleFirebase.fromJson(doc.data()))
            .toList());
  }

  Stream<List<HayvanEkleFirebase>> _readHayvanlar() {
    return FirebaseFirestore.instance.collection('kullanicilar').doc(_auth.currentUser!.uid).collection('hayvanlar').snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => HayvanEkleFirebase.fromJson(doc.data()))
            .toList());   
  }

  Widget _buildhayvanlar(HayvanEkleFirebase hayvan) => Container(
        margin: EdgeInsets.only(top: 14),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient:
              LinearGradient(colors: [Color(0xFF375BA3), Color(0xFF29E3D7)]),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 3,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
                radius: 30.0,
                backgroundColor: Colors.white,
                backgroundImage:NetworkImage(hayvan.resim!)),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Text(
                          "K??pe Numaras??",
                          style: TextStyle(color: Color(0xFF2EFFF1)),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          hayvan.hayvaninkupeno,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Text(
                          "Irk??",
                          style: TextStyle(color: Color(0xFF2EFFF1)),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          hayvan.hayvaninirki,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.keyboard_double_arrow_right,
                          color: Color(0xFF2EFFF1),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Bilgileri G??r??nt??le",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                        ),
                        Icon(
                          Icons.keyboard_double_arrow_left,
                          color: Color(0xFF2EFFF1),
                        ),
                      ],
                    ),
                  ]),
            ),
          ],
        ),
      );
}
