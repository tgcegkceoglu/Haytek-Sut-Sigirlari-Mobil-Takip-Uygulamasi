import 'package:flutter/material.dart';
import 'package:haytek/model/hayvanekle.dart';
import 'package:haytek/model/header.dart';

class HayvanEkle extends StatelessWidget {
  const HayvanEkle({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(right: 16,left: 16,top: 35),
        child: Column(
          children: <Widget>[
            Header(baslik: "Hayvan Ekle"),
            Expanded(child: HayvanEkleModal()),
          ],
        ),
      ),
    );
  }
}
