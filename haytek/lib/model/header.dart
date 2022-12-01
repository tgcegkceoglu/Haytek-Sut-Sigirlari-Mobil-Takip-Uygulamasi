import 'package:flutter/material.dart';

class Header extends StatefulWidget {
  Header({Key? key, required this.baslik}) : super(key: key);
  String baslik;

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15,top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            onPressed: () {
              Navigator.pushNamed(context, '/anasayfa');
            },
            icon: Icon(
              Icons.arrow_back,
              size: 30,
              color: Color(0xFF375BA3),
            ),
          ),
          SizedBox(width: 15,),
          Text(
            widget.baslik,
            style: TextStyle(
                color: Color(0xFF375BA3),
                fontSize: 23,
                fontWeight: FontWeight.bold),
          ),

        ],
      ),
    );
  
  }
}
