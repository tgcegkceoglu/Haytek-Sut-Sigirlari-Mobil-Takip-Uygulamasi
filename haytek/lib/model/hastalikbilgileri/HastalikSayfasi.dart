import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:haytek/Firebase_VeriTabani/hayvanekle/hayvanekle.dart';
import 'package:haytek/Firebase_VeriTabani/notlar/hastalik.dart';
import 'package:haytek/classandvariable/bilgiler.dart';

class modelHastalikSayfasi extends StatefulWidget {
  const modelHastalikSayfasi({Key? key}) : super(key: key);

  @override
  State<modelHastalikSayfasi> createState() => _modelHastalikSayfasiState();
}

TextEditingController _arama = TextEditingController();
List<HastalikEkleFirebase> _hastalikverileri = [];
List<HayvanEkleFirebase> _hayvanverileri = [];
FirebaseAuth _auth = FirebaseAuth.instance;
bool _aramabool = false;

class _modelHastalikSayfasiState extends State<modelHastalikSayfasi> {
  @override
  void initState() {
    // TODO: implement initState
    _hastalikverileri = [];
    _hayvanverileri = [];
    _arananHayvan = [];
    _arananHastalik = [];
    _aramabool = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Column(
        children: [
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
                    if (_arama.text.length == 0) {
                      _arananHayvan = [];
                      _arananHastalik = [];
                      _aramabool = false;
                    } else {
                      _aramabool = true;
                      _arananTumHayvanlar();
                      _arananHayvan = [];
                      _arananHastalik = [];
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
                  fillColor: Color(0xFF375BA3),
                  suffixIconColor: Color(0xFF375BA3),
                  suffixIcon: Icon(Icons.search, color: Color(0xFF375BA3)),
                  hintText:
                      "Hastalık Bilgisini Aramak İstediğiniz Hayvanın Küpe Numarası",
                  hintStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black45,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: _aramabool != false? _arananTumHayvanlar() : _hayvanverileri.length == 0 ? readTumHayvanlar() : null,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("Bir Hata Oluştu - ${snapshot.error}");
                } else if (snapshot.hasData) {
                  final _hayvanlar = snapshot.data!;
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: _aramabool == false
                            ? _hayvanverileri.length
                            : _arananHayvan.length,
                        itemBuilder: (BuildContext context, index) {
                          return ListTile(
                            title:Text(_aramabool == false ? _hayvanverileri[index].hayvanId.toString() : _arananHayvan[index].hayvanId.toString()),
                          );
                        },
                      ));
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          )
        ],
      ),
    );
  }


  Future<List<dynamic>> readTumHayvanlar() async {
    Query<Map<String, dynamic>> sorgu = FirebaseFirestore.instance
        .collection('kullanicilar')
        .doc(_auth.currentUser!.uid)
        .collection('hayvanlar');
    QuerySnapshot<Map<String, dynamic>> snapshot = await sorgu.get();
    if (snapshot.docs.isNotEmpty && sorgu != null) {
      for (DocumentSnapshot<Map<String, dynamic>> dokuman in snapshot.docs) {
        Map<String, dynamic>? hayvanMap = dokuman.data();
        hayvanMap?["id"] = dokuman.id;
        if (hayvanMap != null) {
          Query<Map<String, dynamic>> sorgu1 = FirebaseFirestore.instance
              .collection('kullanicilar')
              .doc(_auth.currentUser!.uid)
              .collection('hayvanlar')
              .doc(dokuman.id)
              .collection('hastalik');
          QuerySnapshot<Map<String, dynamic>> snapshot1 = await sorgu1.get();
          if (sorgu1 != null && snapshot1.docs.isNotEmpty) {
            QuerySnapshot<Map<String, dynamic>> snapshot1 = await sorgu1.get();
            if (snapshot1.docs.isNotEmpty) {
              for (DocumentSnapshot<Map<String, dynamic>> dokuman1
                  in snapshot1.docs) {
                Map<String, dynamic>? hastalikMap = dokuman1.data();
                hastalikMap?["id"] = dokuman1.id;
                if (hastalikMap != null) {
                  HayvanEkleFirebase hayvan =
                      HayvanEkleFirebase.fromJson(hayvanMap);
                  _hayvanverileri.add(hayvan);
                  HastalikEkleFirebase hastalik =
                      HastalikEkleFirebase.fromJson(hastalikMap);
                  _hastalikverileri.add(hastalik);
                }
              }
            }
          }
        }
      }
    }
    return _hayvanverileri;
  }

  List<HastalikEkleFirebase> _arananHastalik = [];
  List<HayvanEkleFirebase> _arananHayvan = [];
  Future<List<dynamic>> _arananTumHayvanlar() async {
    for (int i = 0; i < _hayvanverileri.length; i++) {
      if (_hayvanverileri[i].hayvaninkupeno == _arama.text) {
        if (_hastalikverileri[i].hayvaninkupeno == _arama.text) {
          _arananHayvan.add(_hayvanverileri[i]);
          _arananHastalik.add(_hastalikverileri[i]);
        }
      }
    }
    return _hayvanverileri;
  }
}
