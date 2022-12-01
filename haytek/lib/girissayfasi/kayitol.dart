import 'package:flutter/material.dart';
import 'package:haytek/girissayfasi/LoginPage.dart';

class KayitOlSayfasi extends StatefulWidget {
  const KayitOlSayfasi({Key? key}) : super(key: key);

  @override
  State<KayitOlSayfasi> createState() => _KayitOlSayfasiState();
}

TextEditingController _adsoyadcontroller = TextEditingController();
TextEditingController _epostacontroller = TextEditingController();
TextEditingController _sifrecontroller = TextEditingController();

class _KayitOlSayfasiState extends State<KayitOlSayfasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Giriş Sayfasi")),
      body: _buildBody(context),
    );
  }
}

Widget _buildBody(BuildContext context) {
  return Padding(
    padding: EdgeInsets.all(16),
    child: ListView(children: [
      TextField(
        controller: _adsoyadcontroller,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          hintText: "Adınız Ve Soyadınız",
        ),
      ),
      SizedBox(height: 16,),
      TextField(
        controller: _epostacontroller,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: "Email Adresiniz",
        ),
      ),
      SizedBox(height: 16,),
      TextField(
        controller: _sifrecontroller,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          hintText: "Şifreniz",
        ),
      ),
      SizedBox(height: 16,),
      Container(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: (){},
          child: Text("Kayıt Ol"),
        ),
      ),
      SizedBox(height: 16,),
      Container(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: (){
            _girisSayfasiniAc(context);
          },
          child: Text("Zaten hesabınız var mı? Giriş Yapın"),
        ),
      ),
    ]),

  );
}
void _girisSayfasiniAc(BuildContext context){
  MaterialPageRoute sayfayolu=MaterialPageRoute(
    builder: (context) {
      return LoginPage();
    },
  );
  Navigator.pushReplacement(context, sayfayolu);
}