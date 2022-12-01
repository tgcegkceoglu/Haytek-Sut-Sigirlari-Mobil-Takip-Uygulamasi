
import 'package:haytek/model/takvimicon.dart';
import 'package:haytek/model/textfieldarama.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:haytek/classandvariable/veriler.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class NotEkle extends StatefulWidget {
  const NotEkle({Key? key}) : super(key: key);
  @override
  State<NotEkle> createState() => _NotEkleState();
}


class _NotEkleState extends State<NotEkle> {
  var maskFormatter = MaskTextInputFormatter(
      mask: '##/##/####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  Veriler veri = Veriler();
  String secilibaslik = "Not";
  List<String> turadi = ["Not", "Hastalık", "Aşılama", "Tohumlama"];

  int drop = 0;
  //Tohumlama 
  TextEditingController _hayvankupenocontroller=TextEditingController();
  TextEditingController _hayvaninirkicontroller=TextEditingController();
  TextEditingController _boganinirkicontroller=TextEditingController();
  TextEditingController _boganinkupenocontroller=TextEditingController();
  TextEditingController _tohumlamayapanveteriner=TextEditingController();
  TextEditingController _tohumlamabaslangiccontroller=TextEditingController();
  TextEditingController _tohumlamabitiscontroller=TextEditingController();
  //Not
  TextEditingController _notunkonusucontroller=TextEditingController();
  TextEditingController _notunicerigicontroller=TextEditingController();
  TextEditingController _notbaslangiccontroller=TextEditingController();
  TextEditingController _notunbitistarihi=TextEditingController();
  //asilama
  TextEditingController _yapilacakasicontroller=TextEditingController();
  TextEditingController _asilayankisicontroller=TextEditingController();
  TextEditingController _asibaslangiccontroller=TextEditingController();
  TextEditingController _asibitiscontroller=TextEditingController();
  //hastalik
  TextEditingController _hastalikismicontroller=TextEditingController();
  TextEditingController _hastalikbaslangiccontroller=TextEditingController();
  TextEditingController _hastalikbitiscontroller=TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          children: [
            
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 1,
                  color: Color(0xFF375BA3),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 5,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  itemPadding: EdgeInsets.only(left: 16),
                  hint: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      'Not Başlığı',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  isExpanded: true,
                  items: turadi
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ))
                      .toList(),
                  value: secilibaslik,
                  onChanged: (value) {
                    setState(() {
                      secilibaslik = value as String;
                    });
                  },
                  icon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                  ),
                  iconSize: 30,
                  iconEnabledColor: Colors.black,
                  iconDisabledColor: Colors.black,
                  isDense: true,
                  buttonHeight: 50,
                  buttonElevation: 0,
                  dropdownDecoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  dropdownElevation: 0,
                  scrollbarThickness: 0,
                  scrollbarAlwaysShow: true,
                ),
              ),
            ),
            secilibaslik == "Aşılama"
                ? Column(
                    children: [
                      //Hayvanın Küpe Numarası Textfield
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => SearchSelectPage(
                                controller: _hayvankupenocontroller,
                                inputType: TextInputType.number,
                                hinttext:
                                    "Hayvanın Küpe Numarasını Seçiniz...",
                                items: veri.kupeno,
                                selectedItem: _hayvankupenocontroller.text,
                                onSelection: (v) {
                                  _hayvankupenocontroller.text= v;
                                  setState(() {});
                                },
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              width: 1,
                              color: Color(0xFF375BA3),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 5,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: TextField(
                              enabled: false,
                              controller: TextEditingController(
                                  text: _hayvankupenocontroller.text),
                              decoration: const InputDecoration(
                                labelStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText: "Hayvanın Küpe Numarası",
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                suffixIcon: Padding(
                                  padding: EdgeInsets.only(left: 16),
                                  child: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    size: 30,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      //Hayvana yapılan aşının Textfield
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => SearchSelectPage(
                                 inputType: TextInputType.text,
                                controller: _yapilacakasicontroller,
                                hinttext: "Aşı İsmini Giriniz...",
                                items: veri.asiismi,
                                selectedItem: _yapilacakasicontroller.text,
                                onSelection: (v) {
                                _yapilacakasicontroller.text = v;
                                  setState(() {});
                                },
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              width: 1,
                              color: Color(0xFF375BA3),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 5,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: TextField(
                              enabled: false,
                              controller: TextEditingController(
                                  text: _yapilacakasicontroller.text),
                              decoration: const InputDecoration(
                                labelStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText: "Yapılacak Aşıyı Seçiniz",
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                suffixIcon: Padding(
                                  padding: EdgeInsets.only(left: 16),
                                  child: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    size: 30,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      //Aşılayan Kişinin Textfield
                      Container(
                        margin: EdgeInsets.only(top: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            width: 1,
                            color: Color(0xFF375BA3),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 5,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: _asilayankisicontroller,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.black,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          onChanged: (value) {},
                          decoration: InputDecoration(
                              filled: true,
                              hintText: "Aşılayan Kişi",
                              hintStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              fillColor: Colors.white,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none),
                        ),
                      ),
                      //Aşının yapıldığı başlangıç tarihi
                      TakvimIcon(labeltext: "Aşılama Başlangıç Tarihi", controller: _asibaslangiccontroller,focusedDay: DateTime.now(),selectedDay: DateTime.now(),),

                      //Aşının yapıldığı bitiş tarihi
                      TakvimIcon(labeltext: "Aşılama Bitiş Tarihi", controller: _asibitiscontroller,focusedDay: DateTime.now(),selectedDay: DateTime.now(),)
                    ],
                  )
                : secilibaslik == "Not"
                    ? Column(
                        children: [
                          //Hayvanın Küpe Numarası Textfield
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => SearchSelectPage(
                                    inputType: TextInputType.number,
                                    controller: _hayvankupenocontroller,
                                    hinttext:
                                        "Hayvanın Küpe Numarasını Seçiniz...",
                                    items: veri.kupeno,
                                    selectedItem:_hayvankupenocontroller.text,
                                    onSelection: (v) {
                                      _hayvankupenocontroller.text = v;
                                      setState(() {});
                                    },
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  width: 1,
                                  color: Color(0xFF375BA3),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 5,
                                    offset: Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: TextField(
                                  enabled: false,
                                  controller: TextEditingController(
                                      text: _hayvankupenocontroller.text),
                                  decoration: const InputDecoration(
                                    labelStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    hintText: "Hayvanın Küpe Numarası",
                                    hintStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    suffixIcon: Padding(
                                      padding: EdgeInsets.only(left: 16),
                                      child: Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        size: 30,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          //Notun Konusu
                          Container(
                            margin: EdgeInsets.only(top: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                width: 1,
                                color: Color(0xFF375BA3),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 5,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: TextField(
                              keyboardType: TextInputType.text,
                              controller: _notunkonusucontroller,
                              cursorColor: Colors.black,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              onChanged: (value) {},
                              decoration: InputDecoration(
                                  filled: true,
                                  hintText: "Notun Konusu",
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  fillColor: Colors.white,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none),
                            ),
                          ),

                          //Notun iceriği
                          Container(
                            margin: EdgeInsets.only(top: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                width: 1,
                                color: Color(0xFF375BA3),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 5,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: TextField(
                              maxLines: 8,
                              keyboardType: TextInputType.text,
                              controller: _notunicerigicontroller,
                              cursorColor: Colors.black,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              onChanged: (value) {},
                              decoration: InputDecoration(
                                  filled: true,
                                  hintText: "Notunuz",
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  fillColor: Colors.white,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none),
                            ),
                          ),
                          //Notun başlangıç tarihi
                          TakvimIcon(labeltext: "Notun Başlangıç Tarihi", controller: _notbaslangiccontroller,focusedDay: DateTime.now(),selectedDay: DateTime.now(),),

                          //Not bitiş tarihi
                          TakvimIcon(labeltext: "Notun Bitiş Tarihi", controller: _notunbitistarihi,focusedDay: DateTime.now(),selectedDay: DateTime.now(),),
                        ],
                      )
                    : secilibaslik == "Hastalık"
                        ? Column(
                            children: [
                              //Hayvanın Küpe Numarası Textfield
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => SearchSelectPage(
                                        controller: _hayvankupenocontroller,
                                         inputType: TextInputType.number,
                                        hinttext:
                                            "Hayvanın Küpe Numarasını Seçiniz...",
                                        items: veri.kupeno,
                                        selectedItem: _hayvankupenocontroller.text,
                                        onSelection: (v) {
                                          _hayvankupenocontroller.text = v;
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.only(top: 16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      width: 1,
                                      color: Color(0xFF375BA3),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 5,
                                        offset: Offset(0, 5),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 16),
                                    child: TextField(
                                      enabled: false,
                                      controller: _hayvankupenocontroller,
                                      decoration: const InputDecoration(
                                        labelStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        hintText: "Hayvanın Küpe Numarası",
                                        hintStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                        suffixIcon: Padding(
                                          padding: EdgeInsets.only(left: 16),
                                          child: Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                            size: 30,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => SearchSelectPage(
                                        controller: _hastalikismicontroller,
                                         inputType: TextInputType.text,
                                        hinttext:
                                            "Hastalığın İsmini Giriniz...",
                                        items: veri.hastalikismi,
                                        selectedItem: _hastalikismicontroller.text,
                                        onSelection: (v) {
                                          _hastalikismicontroller.text = v;
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.only(top: 16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      width: 1,
                                      color: Color(0xFF375BA3),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 5,
                                        offset: Offset(0, 5),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 16),
                                    child: TextField(
                                      enabled: false,
                                      controller: _hastalikismicontroller,
                                      decoration: const InputDecoration(
                                        labelStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        hintText: "Hastalığı Seçiniz",
                                        hintStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                        suffixIcon: Padding(
                                          padding: EdgeInsets.only(left: 16),
                                          child: Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                            size: 30,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              //hastalik başlangıç tarihi
                              TakvimIcon(labeltext: "Hastalık Başlangıç Tarihi", controller: _hastalikbaslangiccontroller,focusedDay: DateTime.now(),selectedDay: DateTime.now(),),
                              //Hastalık bitiş tarihi
                              TakvimIcon(labeltext: "Hastalık Bitiş Tarihi", controller: _hastalikbitiscontroller,focusedDay: DateTime.now(),selectedDay: DateTime.now(),)
                            ],
                          )
                        : secilibaslik == "Tohumlama"
                            ? Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => SearchSelectPage(
                                             inputType: TextInputType.number,
                                            controller: _hayvankupenocontroller,
                                            hinttext:
                                                "Hayvanın Küpe Numarasını Seçiniz...",
                                            items: veri.kupeno,
                                            selectedItem: _hayvankupenocontroller.text,
                                            onSelection: (v) {
                                              _hayvankupenocontroller.text= v;
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(top: 16),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          width: 1,
                                          color: Color(0xFF375BA3),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.grey.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 5,
                                            offset: Offset(0, 5),
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 16),
                                        child: TextField(
                                          enabled: false,
                                          controller: _hayvankupenocontroller,
                                          decoration: const InputDecoration(
                                            labelStyle: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            hintText:
                                                "Tohumlanan Hayvanın Küpe Numarası",
                                            hintStyle: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                            suffixIcon: Padding(
                                              padding:
                                                  EdgeInsets.only(left: 16),
                                              child: Icon(
                                                Icons
                                                    .keyboard_arrow_down_rounded,
                                                size: 30,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => SearchSelectPage(
                                            controller: _hayvaninirkicontroller,
                                             inputType: TextInputType.text,
                                            hinttext:
                                                "Tohumlanan Hayvanın Irkını Seçiniz...",
                                            items: veri.irk,
                                            selectedItem:_hayvaninirkicontroller.text,
                                            onSelection: (v) {
                                              _hayvaninirkicontroller.text = v;
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(top: 16),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          width: 1,
                                          color: Color(0xFF375BA3),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.grey.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 5,
                                            offset: Offset(0, 5),
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 16),
                                        child: TextField(
                                          enabled: false,
                                          controller: _hayvaninirkicontroller,
                                          decoration: const InputDecoration(
                                            labelStyle: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            hintText:
                                                "Tohumlanan Hayvanın Irkını Seçiniz",
                                            hintStyle: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                            suffixIcon: Padding(
                                              padding:
                                                  EdgeInsets.only(left: 16),
                                              child: Icon(
                                                Icons
                                                    .keyboard_arrow_down_rounded,
                                                size: 30,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  //Boğa Küpe No Textfield
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => SearchSelectPage(
                                            controller: _boganinkupenocontroller,
                                             inputType: TextInputType.number,
                                            hinttext:
                                                "Boğanın Küpe Numarasını Seçiniz...",
                                            items: veri.bogakupeno,
                                            selectedItem:_boganinkupenocontroller.text,
                                            onSelection: (v) {
                                              _boganinkupenocontroller.text = v;
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(top: 16),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          width: 1,
                                          color: Color(0xFF375BA3),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.grey.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 5,
                                            offset: Offset(0, 5),
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 16),
                                        child: TextField(
                                          enabled: false,
                                          controller: _hayvaninirkicontroller,
                                          decoration: const InputDecoration(
                                            labelStyle: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            hintText:
                                                "Boğanın Küpe Numarasını Seçiniz",
                                            hintStyle: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                            suffixIcon: Padding(
                                              padding:
                                                  EdgeInsets.only(left: 16),
                                              child: Icon(
                                                Icons
                                                    .keyboard_arrow_down_rounded,
                                                size: 30,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => SearchSelectPage(
                                            controller: _boganinirkicontroller,
                                             inputType: TextInputType.text,
                                            hinttext:
                                                "Boğanın Irkını Seçiniz...",
                                            items: veri.irk,
                                            selectedItem: _boganinirkicontroller.text,
                                            onSelection: (v) {
                                              _boganinirkicontroller.text = v;
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(top: 16),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          width: 1,
                                          color: Color(0xFF375BA3),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.grey.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 5,
                                            offset: Offset(0, 5),
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 16),
                                        child: TextField(
                                          enabled: false,
                                          controller: _boganinirkicontroller,
                                          decoration: const InputDecoration(
                                            labelStyle: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            hintText:
                                                "Boğanın Irkını Seçiniz",
                                            hintStyle: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                            suffixIcon: Padding(
                                              padding:
                                                  EdgeInsets.only(left: 16),
                                              child: Icon(
                                                Icons
                                                    .keyboard_arrow_down_rounded,
                                                size: 30,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  
                                  //Tohumlama Yapan Veteriner Textfield
                                  Container(
                                    margin: EdgeInsets.only(top: 16),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        width: 1,
                                        color: Color(0xFF375BA3),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 5,
                                          offset: Offset(0, 5),
                                        ),
                                      ],
                                    ),
                                    child: TextField(
                                      controller: _tohumlamayapanveteriner,
                                      keyboardType: TextInputType.text,
                                      cursorColor: Colors.black,
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                          filled: true,
                                          hintText:
                                              "Tohumlamayı Yapan Veteriner",
                                          hintStyle: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                          fillColor: Colors.white,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none),
                                    ),
                                  ),
                                  //tohumlama başlangıç tarihi
                                  TakvimIcon(labeltext: "Tohumlama Başlangıç Tarihi", controller: _tohumlamabaslangiccontroller,focusedDay: DateTime.now(),selectedDay: DateTime.now(),),

                                  //Hastalık bitiş tarihi
                                  TakvimIcon(labeltext: "Tohumlama Bitiş Tarihi", controller:_tohumlamabitiscontroller,focusedDay: DateTime.now(),selectedDay: DateTime.now(),),
                                ],
                              )
                            : Container(),
          ],
        ));
  }
}
