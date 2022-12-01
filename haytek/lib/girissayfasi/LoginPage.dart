import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:haytek/Firebase_VeriTabani/kullaniciekle/kullaniciekle.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}
bool _kullaniciKaydet=false;
FirebaseStorage _storage = FirebaseStorage.instance;
FirebaseAuth _auth = FirebaseAuth.instance;
class _LoginPageState extends State<LoginPage> {
  TextEditingController _ulkecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Color(0xFF375BA3), Color(0xFF29E3D7)],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: CustomScrollView(scrollDirection: Axis.vertical, slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/inek.png',
                    height: 100,
                    width: 100,
                  ),
                  Text(
                    "Giriş Yap",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16)),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 50),
                    child: Column(children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 1, color: Colors.black)),
                        child: TextField(
                          cursorColor: Colors.black,
                          controller: _ulkecontroller,
                          onTap: () {
                            setState(() {
                              _ulkecontroller.text = "+90";
                            });
                          },
                          decoration: InputDecoration(
                            prefixIconConstraints: BoxConstraints(),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 16),
                            hintText: "Telefon numaranız...",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 1, color: Colors.black)),
                        child: TextField(
                          obscureText: true,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            prefixIconConstraints: BoxConstraints(),
                            hintText: "Şifreniz...",
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Şifremi Unuttum",
                            style: TextStyle(
                                color: Color.fromARGB(255, 61, 131, 177)),
                          )),
                      SizedBox(
                        height: 16,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(16),
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
                          child: Center(
                              child: Text(
                            "Giriş Yap",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        "Hesabınız Yok Mu? Kayıt Olun",
                        style:
                            TextStyle(color: Color.fromARGB(255, 61, 131, 177)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Şifremi Unuttum",
                        style:
                            TextStyle(color: Color.fromARGB(255, 61, 131, 177)),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      Container(
                        height: 1,
                        width: 50,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              top: -18,
                              child: Center(
                                child: Text(
                                  "Veya",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 61, 131, 177),
                                      backgroundColor: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 100,
                        width: double.infinity,
                        child: CustomScrollView(
                          scrollDirection: Axis.horizontal,
                          slivers: [
                            SliverFillRemaining(
                              hasScrollBody: false,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: GestureDetector(
                                      onTap: () {
                                        _googleilegiris(context);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Colors.red,
                                                Colors.yellow,
                                                Colors.yellow,
                                                Colors.blue,
                                                Colors.green,
                                              ]),
                                          borderRadius:
                                              BorderRadius.circular(34),
                                        ),
                                        child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(60),
                                            ),
                                            child: Image.asset(
                                              'assets/images/google.png',
                                              height: 25,
                                              width: 25,
                                            )),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        color: Color(0xFF2b5397),
                                        borderRadius: BorderRadius.circular(34),
                                      ),
                                      child: Container(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 3),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(60),
                                          ),
                                          child: Icon(
                                            Icons.facebook,
                                            size: 35,
                                            color: Color(
                                              0xFF2b5397,
                                            ),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
  Timer? _timer;
  void startTimer(String hinttext) {
    int _start = 150;
    const oneSec = const Duration(milliseconds: 10);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            Navigator.pop(context);
            Navigator.pop(context);
          });
        } else if (_start == 50) {
          _start--;
          showDialog(
            context: context,
            builder: (context) {
              return Stack(
                alignment: Alignment.topRight,
                children: <Widget>[
                  GestureDetector(
                    onTap: (() {
                      Navigator.pop(context);
                    }),
                    child: Container(
                      width: 180,
                      height: 30,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF375BA3), Color(0xFF29E3D7)],
                          begin: FractionalOffset.centerLeft,
                          end: FractionalOffset.centerRight,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            hinttext,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "lucida",
                              fontSize: 12,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }


_googleilegiris(BuildContext context) async {
  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
  GoogleSignInAccount? googleKullanici = await googleSignIn.signIn();
  if (googleKullanici != null) {
    GoogleSignInAuthentication googleKimlik =
        await googleKullanici.authentication;
    AuthCredential dogrulamaKimligi = GoogleAuthProvider.credential(
      accessToken: googleKimlik.accessToken,
      idToken: googleKimlik.idToken,
    );
    UserCredential kullaniciKimligi =
        await _auth.signInWithCredential(dogrulamaKimligi);
    User? kullanici = kullaniciKimligi.user;
    if (kullanici != null) {
      Query<Map<String, dynamic>> sorgu = FirebaseFirestore.instance
          .collection('kullanicilar')
          .where("id", isEqualTo: kullanici.uid);
      QuerySnapshot<Map<String, dynamic>> snapshot = await sorgu.get();

      if (snapshot.docs.isEmpty) {
          createUser(
          id: kullanici.uid,
          name: kullanici.displayName.toString(),
          email: kullanici.email.toString(),
        );
        if(_kullaniciKaydet==true){
          Navigator.pushNamed(context, '/anasayfa');
        }
      }
      else{
        Navigator.pushNamed(context, '/anasayfa');
      }
      
    }
  }
  
}

Future createUser({
  required String id,
  required String name,
  required String email,
}) async {
    try{
    final docUser = FirebaseFirestore.instance.collection('kullanicilar').doc(id);
    final kullanici = KullaniciFirebase(
      id: id,
      name: name,
      email: email,
    );    
    docUser.set(kullanici.toJson());
    print("Kullanıcı Kaydedildi");
    _kullaniciKaydet=true;
    }
    catch(err){
       print("Kullanıcı kaydedilmedi");
    }
  }
  
}