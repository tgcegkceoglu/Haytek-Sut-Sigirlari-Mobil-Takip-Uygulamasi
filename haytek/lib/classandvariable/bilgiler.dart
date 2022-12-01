import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:haytek/Firebase_VeriTabani/notlar/asilama.dart';
import 'package:haytek/Firebase_VeriTabani/notlar/hastalik.dart';
import 'package:haytek/classandvariable/veriler.dart';
import 'package:intl/intl.dart';

class Bilgiler extends StatefulWidget {
  int veri;
  int index;
  List<HastalikEkleFirebase>? hastalikverileri;
  List<AsilamaEkleFirebase>? asilamaverileri;
  var icon;
  bool deger;
  Bilgiler({ 
  Key? key,
  required this.veri,
  required this.index,
  List<HastalikEkleFirebase>? hastalikverileri,
  List<AsilamaEkleFirebase>? asilamaverileri,
  required this.deger,
  required this.icon,
  }) : super(key: key);

  @override
  State<Bilgiler> createState() => _BilgilerState();
}

class _BilgilerState extends State<Bilgiler> {

  Veriler veri = new Veriler();
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              widget.deger = !widget.deger;
            });
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(bottom: 18),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
              ),
              border: Border.all(width: 2, color: Color(0xFF375BA3)),
              color: Colors.white,
            ),
            child: Column(
              children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Küpe Numarası",
                            style: TextStyle(
                                color: Color(0xFF375BA3),
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                              width:
                                  MediaQuery.of(context).size.width / 3,
                              child: Text(
                                  widget.hastalikverileri![widget.index].hayvaninkupeno,
                      
                                  )),
                        ],
                      ),
                
                          
                    ],
                  ),
                ),
                flex: 6,
              ),
              Expanded(
                flex: 2,
                child: CircleAvatar(
                    radius: 40.0,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(widget.veri ==1 ? widget.hastalikverileri![widget.index].hayvanresim : ""))),
              
                  ],
                ), 
              ],
            ),
          ),
        ),
        Positioned(
          left: 3,
          top: -5,
          child: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: widget.icon,
          ),
        ),
      ],
    ); 
  }
}
