import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:haytek/classandvariable/veriler.dart';
import 'package:haytek/view/tohumlamasayfasi.dart';

class Yapilacaklar extends StatefulWidget {
  bool deger;
  String baslik;
  String metin;
  Yapilacaklar(
      {Key? key,
      required this.deger,
      required this.baslik,
      required this.metin})
      : super(key: key);

  @override
  State<Yapilacaklar> createState() => _YapilacaklarState();
}
Veriler veri = new Veriler();
class _YapilacaklarState extends State<Yapilacaklar> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.deger = !widget.deger;
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 15),
        padding: EdgeInsets.only(bottom: 10, top: 5, left: 10, right: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(0, 2),
            ),
          ],
          border: Border(
            left: BorderSide(
              width: 3,
              color: Color(0xFF375BA3),
            ),
            bottom: BorderSide(width: 1, color: Color(0xFF375BA3)),
            right: BorderSide(width: 1, color: Color(0xFF375BA3)),
            top: BorderSide(width: 1, color: Color(0xFF375BA3)),
          ),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 1,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      top: -15,
                      child: Text(
                        widget.baslik,
                        style: TextStyle(
                            color: Color(0xFF375BA3),
                            backgroundColor: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Wrap(
                      direction: Axis.horizontal,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 2 + 50,
                          padding: EdgeInsets.only(right: 15),
                          child: Text(
                            widget.deger ? veri.kelime(widget.metin) : widget.metin,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: FaIcon(FontAwesomeIcons.pen),
                    constraints: BoxConstraints(),
                    padding: EdgeInsets.zero,
                    color: Color(0xFF375BA3),
                    iconSize: 20,
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.delete),
                    constraints: BoxConstraints(),
                    padding: EdgeInsets.zero,
                    color: Color(0xFF375BA3),
                    iconSize: 23,
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: FaIcon(FontAwesomeIcons.circleCheck),
                    constraints: BoxConstraints(),
                    padding: EdgeInsets.zero,
                    color: Color(0xFF375BA3),
                    iconSize: 20,
                  ),
                ],
              ),
            ]),
      ),
    );
  }
}
