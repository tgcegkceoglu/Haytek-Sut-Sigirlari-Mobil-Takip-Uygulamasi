import 'package:flutter/material.dart';
import 'package:haytek/model/hastalikbilgileri/hastalikekle.dart';
import 'package:haytek/model/header.dart';
import 'package:haytek/model/hastalikbilgileri/HastalikSayfasi.dart';

class viewHastalikSayfasi extends StatefulWidget {
  const viewHastalikSayfasi({Key? key}) : super(key: key);

  @override
  State<viewHastalikSayfasi> createState() => _viewHastalikSayfasiState();
}


class _viewHastalikSayfasiState extends State<viewHastalikSayfasi> {


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
    
      onWillPop:()async{
        Navigator.pushNamed(context,'/anasayfa');
        return true;
      },
      child: Scaffold(
        
          backgroundColor: Colors.white,
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
                              "Hastalık Ekle",
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
                            child: HastalikEkleModal(),
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
              padding: const EdgeInsets.only(right: 16, left: 16, top: 31),
              child: Column(children: [
                Header(baslik: "Hastalık"),
                Expanded(child: modelHastalikSayfasi()),
               
              ]))),
    );
  }


}
