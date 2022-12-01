import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:haytek/model/floatingactionbutton.dart';
import 'package:haytek/model/takvim.dart';
import 'package:haytek/model/tohumlamaekle.dart';
import 'package:haytek/model/yapilacakekle.dart';
import 'package:haytek/model/yapilacaklar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _zaman=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButtonClass(baslik: "Yapılacak Ekle",
      sayfa:YapilacaklarEkle(),
      height: MediaQuery.of(context).size.height * 0.7,
      bottomtext: "Ekle",
      hinttext: "Yapılacak Eklendi!",
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(bottom: 20, left: 16, right: 16, top: 40),
        child: SingleChildScrollView(
          child: Column(children: [
            Row(
              children: [
                Text(_auth.currentUser!.displayName != null ? _auth.currentUser!.displayName.toString() : "Hoşgeldiniz",
                    style: TextStyle(
                        color: Color(0xFF375BA3),
                        fontSize: 24,
                        fontWeight: FontWeight.w600)),
                Spacer(),
                IconButton(
                    onPressed: () {
                      _cikisYap(context);
                      Navigator.pushNamed(context, '/girissayfasi');
                    },
                    icon: Icon(
                      Icons.logout_outlined,
                      color: Color(0xFF375BA3),
                    )),
              ],
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xFF375BA3), Color(0xFF29E3D7)]),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(children: [
                          Text(
                            "İnek Sayısı:",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "20",
                            style: TextStyle(color: Colors.white),
                          ),
                        ]),
                        Row(
                          children: [
                            Icon(
                              Icons.keyboard_double_arrow_right,
                              color: Color(0xFF2EFFF1),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                "İnekleri Görüntüle",
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
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(children: [
                          Text(
                            "Buzağı Sayısı:",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "10",
                            style: TextStyle(color: Colors.white),
                          ),
                        ]),
                        Row(
                          children: [
                            Icon(
                              Icons.keyboard_double_arrow_right,
                              color: Color(0xFF2EFFF1),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                minimumSize: Size.zero,
                                padding: EdgeInsets.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              onPressed: () {},
                              child: Text(
                                "Buzağıları Görüntüle",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Icon(
                              Icons.keyboard_double_arrow_left,
                              color: Color(0xFF2EFFF1),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     
                      buildcontainericon(
                          context,
                          "Hayvan Ekle",
                          Icon(Icons.add, color: Color(0xFF30A0BD)),
                          '/hayvanekle'),
                      buildcontainericon(
                          context,
                          "Notlar",
                          Icon(Icons.note_add, color: Color(0xFF30A0BD)),
                          '/notlar'),
                      buildcontainericon(
                          context,
                          "Hayvanlarım",
                          FaIcon(FontAwesomeIcons.cow,
                              color: Color(0xFF30A0BD)),
                          '/hayvanlarim'),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      buildcontainericon(
                          context,
                          "Aşılama",
                          FaIcon(FontAwesomeIcons.syringe,
                              color: Color(0xFF30A0BD)),
                          '/asilama'),
                      buildcontainericon(
                          context,
                          "Hastalık",
                          Icon(Icons.sick_rounded, color: Color(0xFF30A0BD)),
                          '/hastalik'),
                      buildcontainericon(
                          context,
                          "Tohumlama",
                          FaIcon(
                            FontAwesomeIcons.seedling,
                            color: Color(0xFF30A0BD),
                          ),
                          '/tohumlama'),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Yapılacaklar Listesi",
                  style: TextStyle(
                       fontSize: 15,
                      color: Color(0xFF375BA3), fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Expanded(
                  child: TextField(
                    style: TextStyle(fontSize: 15,color:Color(0xFF375BA3),),
                    enabled: false,
                    controller: _zaman,
                    
                    decoration: InputDecoration(
                      constraints: BoxConstraints(),
                      contentPadding: EdgeInsets.zero,
                      
                      hintStyle: TextStyle(color:Color(0xFF375BA3),),
                      hintText: dateFormat.format(DateTime.now()),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: (() => showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            content: Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height / 2 + 75,
                                child: Takvim(selectedday: DateTime.now(),zaman: _zaman,)),
                          ))),
                  icon: Icon(
                    Icons.calendar_month_outlined,
                    color: Color(0xFF375BA3),
                  ),
                ),
              ],
            ),
            Yapilacaklar(
                deger: true,
                metin:
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                baslik: "Aşılama"),
            Yapilacaklar(
              deger: true,
              metin: "Kuruda ki ineklerin bakımı yapılacak.",
              baslik: "Kontrol",
            ),
            Yapilacaklar(
              deger: true,
              metin:
                  "1911404 ve 5687945 numaralı ineklerin tohumlaması yapılacak",
              baslik: "Tohumlama",
            ),
          ]),
        ),
      ),
    );
  }

  void _cikisYap(BuildContext context) async {
    await _auth.signOut();
    await GoogleSignIn().signOut();
  }
}

buildcontainericon(context, String baslik, icon, String named) {
  return Padding(
    padding: const EdgeInsets.only(right: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, named);
          },
          child: Container(
            width: 150,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 1, color: Color(0xFF30A0BD))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: icon,
                ),
                SizedBox(
                  height: 2,
                  width: 10,
                ),
                Text(
                  baslik,
                  style: TextStyle(
                      color: Color(0xFF30A0BD), fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
