import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:haytek/HomePage.dart';
import 'package:haytek/girissayfasi/LoginPage.dart';
import 'package:haytek/girissayfasi/splashscreen.dart';
import 'package:haytek/model/hastalikbilgileri/HastalikSayfasi.dart';
import 'package:haytek/view/asilamasayfasi.dart';
import 'package:haytek/view/hastaliksayfasi.dart';
import 'package:haytek/view/hayvanekle.dart';
import 'package:haytek/view/hayvanlarim.dart';
import 'package:haytek/view/tohumlamasayfasi.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('tr_TR');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) =>SplashScreen(),
        '/anasayfa': (context) => HomePage(),
        '/girissayfasi': (context) => LoginPage(),
        '/hayvanekle': (context) => HayvanEkle(),
        '/hayvanlarim': (context) => Hayvanlarim(),
        '/asilama': (context) => AsilamaSayfasi(),
        '/hastalik': (context) => viewHastalikSayfasi(),
        '/tohumlama': (context) => TohumlamaSayfasi(),
      },
    );
  }
}

