import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:haytek/Firebase_VeriTabani/hayvanekle/hayvanekle.dart';
import 'package:haytek/Firebase_VeriTabani/notlar/hastalik.dart';
import 'package:haytek/model/hastalikbilgileri/HastalikSayfasi.dart';
import 'package:haytek/model/textfieldarama.dart';
import 'package:haytek/classandvariable/veriler.dart';
import 'package:haytek/model/tohumlamaekle.dart';
import 'package:haytek/view/hastaliksayfasi.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:table_calendar/table_calendar.dart';

class HastalikEkleModal extends StatefulWidget {
  const HastalikEkleModal({Key? key}) : super(key: key);

  @override
  State<HastalikEkleModal> createState() => _HastalikEkleModalState();
}

FirebaseAuth _auth = FirebaseAuth.instance;
CalendarFormat _format = CalendarFormat.month;
DateTime _selectedDay = DateTime.now();
DateTime _focusedDay = DateTime.now();
final _dateFormat = 'dd/MM/yyyy';
Veriler veri = Veriler();
bool _textfieldkontrol = false;
bool _tarihkontrol = false;
final _formattedDate = DateFormat(_dateFormat).format(DateTime.now());
TextEditingController _hayvankupenocontroller = TextEditingController();
TextEditingController _hastalikismicontroller = TextEditingController();
TextEditingController _hastaliknot = TextEditingController();
TextEditingController _hastalikbaslangiccontroller =
    TextEditingController(text: _formattedDate);
TextEditingController _hastalikbitiscontroller =
    TextEditingController(text: _formattedDate);
var maskFormatter = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy);

class _HastalikEkleModalState extends State<HastalikEkleModal> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  initState() {
    _readTumHayvanlar();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:()async{
       return true;
      },
      child: Scaffold(
        bottomNavigationBar: Padding(
            padding:
                const EdgeInsets.only(right: 16, left: 16, bottom: 16, top: 16),
            child: Container(
                padding: EdgeInsets.only(right: 35, left: 35),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  gradient: LinearGradient(
                    colors: [Color(0xFF375BA3), Color(0xFF29E3D7)],
                    begin: FractionalOffset.centerLeft,
                    end: FractionalOffset.centerRight,
                  ),
                ),
                child: TextButton(
                  onPressed: () {
                    textemptycontrol();
                     if(_textfieldkontrol && _tarihkontrol){
                        createHastalik(
                        hayvanresim: _hayvanlarresim[_hayvanlarkupeno.indexOf(_hayvankupenocontroller.text.toString())],
                        hastaliknot: _hastaliknot.text,
                        hayvaninkupeno: _hayvankupenocontroller.text,
                        hastalikismi: _hastalikismicontroller.text,
                        hastalikbaslangic: DateFormat(_dateFormat)
                            .parse(_hastalikbaslangiccontroller.text),
                        hastalikbitis: DateFormat(_dateFormat)
                            .parse(_hastalikbitiscontroller.text),
                        );
                        startTimer("Hastalık Eklendi!",true);
                        
                      }
                      else{
                        _tarihkontrol ==false ? startTimer("Hastalık Başlangıç Veya Bitiş Tarihini Yanlış Girdiniz!", false):null;
                        _textfieldkontrol ==false ?  startTimer("Boş Alan Bırakmayınız",false) : null;
                      }
                    },
                  child: Text(
                    "Hastalığı Ekle",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ))),
        body: ListView(
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
                      hinttext: "Hayvanın Küpe Numarasını Seçiniz...",
                      items: _hayvanlarkupeno,
                      selectedItem: _hayvankupenocontroller.text,
                      onSelection: (v) {
                        _hayvankupenocontroller.text = v;
                        setState(() {
                        });
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
                      inputType: TextInputType.text,
                      controller: _hastalikismicontroller,
                      hinttext: "Hastalığın İsmini Giriniz...",
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
                inputFormatters: [maskFormatter],
                keyboardType: TextInputType.number,
                controller: _hastalikbaslangiccontroller,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      icon: Icon(
                        Icons.calendar_month,
                        color: Color(0xFF375BA3),
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                child: Scaffold(
                                  body: TableCalendar(
                                    locale: 'tr_TR',
                                    focusedDay: _focusedDay,
                                    firstDay: DateTime(1990),
                                    lastDay: DateTime.now()
                                        .subtract(Duration(days: 0)),
                                    calendarFormat: _format,
                                    onFormatChanged: (CalendarFormat _format) {
                                      setState(() {
                                        _format =
                                            _format; // Bugünün Tarihini Seçtirdik.
                                      });
                                    },
                                    calendarStyle: CalendarStyle(
                                        todayDecoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 123, 203, 198),
                                          shape: BoxShape.circle,
                                        ),
                                        isTodayHighlighted: true,
                                        selectedDecoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0xFF375BA3),
                                              Color(0xFF29E3D7)
                                            ],
                                            begin: FractionalOffset.centerLeft,
                                            end: FractionalOffset.centerRight,
                                          ),
                                          shape: BoxShape.circle,
                                        ),
                                        selectedTextStyle:
                                            TextStyle(color: Colors.white)),
                                    daysOfWeekStyle: DaysOfWeekStyle(
                                      weekendStyle:
                                          TextStyle(color: Colors.black),
                                      weekdayStyle:
                                          TextStyle(color: Colors.black),
                                    ),
                                    headerStyle: HeaderStyle(
                                      formatButtonVisible: true,
                                      titleCentered: true,
                                      formatButtonShowsNext: false,
                                      formatButtonDecoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1, color: Color(0xFF375BA3)),
                                        borderRadius: BorderRadius.circular(34),
                                      ),
                                    ),
                                    selectedDayPredicate: (DateTime date) {
                                      return isSameDay(_selectedDay, date);
                                    },
                                    startingDayOfWeek: StartingDayOfWeek.monday,
                                    daysOfWeekVisible: true,
                                    onDaySelected:
                                        (DateTime selectDay, DateTime focusDay) {
                                      setState(() {
                                        _selectedDay = selectDay;
                                        _focusedDay = focusDay;
                                        _hastalikbaslangiccontroller.text =
                                            DateFormat(_dateFormat)
                                                .format(selectDay);
                                        Navigator.pop(context);
                                      });
                                    },
                                  ),
                                ),
                              );
                            });
                      }),
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  labelText: 'Hastalık Başlangıç Tarihi',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  labelStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
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
                inputFormatters: [maskFormatter],
                keyboardType: TextInputType.number,
                controller: _hastalikbitiscontroller,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      icon: Icon(
                        Icons.calendar_month,
                        color: Color(0xFF375BA3),
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                  maxHeight: MediaQuery.of(context).size.height*0.6),
                                  child: Scaffold(
                                    body: TableCalendar(
                                      rowHeight: 48,
                                      locale: 'tr_TR',
                                      focusedDay: _focusedDay,
                                      firstDay: DateTime(1990),
                                      lastDay: DateTime.now()
                                          .subtract(Duration(days: 0)),
                                      calendarFormat: _format,
                                      onFormatChanged: (CalendarFormat _format) {
                                        setState(() {
                                          _format =
                                              _format; // Bugünün Tarihini Seçtirdik.
                                        });
                                      },
                                      calendarStyle: CalendarStyle(
                                          
                                          todayDecoration: BoxDecoration(
                                            color:
                                                Color.fromARGB(255, 123, 203, 198),
                                            shape: BoxShape.circle,
                                          ),
                                          isTodayHighlighted: true,
                                          selectedDecoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Color(0xFF375BA3),
                                                Color(0xFF29E3D7)
                                              ],
                                              begin: FractionalOffset.centerLeft,
                                              end: FractionalOffset.centerRight,
                                            ),
                                            shape: BoxShape.circle,
                                          ),
                                          selectedTextStyle:
                                              TextStyle(color: Colors.white)),
                                      daysOfWeekStyle: DaysOfWeekStyle(
                                        weekendStyle:
                                            TextStyle(color: Colors.black),
                                        weekdayStyle:
                                            TextStyle(color: Colors.black),
                                      ),
                                      headerStyle: HeaderStyle(
                                        formatButtonVisible: true,
                                        titleCentered: true,
                                        formatButtonShowsNext: false,
                                        formatButtonDecoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1, color: Color(0xFF375BA3)),
                                          borderRadius: BorderRadius.circular(34),
                                        ),
                                      ),
                                      selectedDayPredicate: (DateTime date) {
                                        return isSameDay(_selectedDay, date);
                                      },
                                      startingDayOfWeek: StartingDayOfWeek.monday,
                                      daysOfWeekVisible: true,
                                      onDaySelected:
                                          (DateTime selectDay, DateTime focusDay) {
                                        setState(() {
                                          _selectedDay = selectDay;
                                          _focusedDay = focusDay;
                                          _hastalikbitiscontroller.text =
                                              DateFormat(_dateFormat)
                                                  .format(selectDay);
                                          Navigator.pop(context);
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              );
                            });
                      }),
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  labelText: 'Hastalık Bitiş Tarihi',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  labelStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
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
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: TextField(
                  cursorColor: Color(0xFF375BA3),
                  maxLines: 5,
                  controller: _hastaliknot,
                  decoration: const InputDecoration(
                      labelStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      labelText: "Eklemek İstediğiniz Not",
                      alignLabelWithHint: true),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future createHastalik({
    File? secilendosya,
    required String hayvanresim,
    required String hayvaninkupeno,
    required String hastaliknot,
    required String hastalikismi,
    required DateTime hastalikbaslangic,
    required DateTime hastalikbitis,
  }) async {
    Query<Map<String, dynamic>> sorgu = FirebaseFirestore.instance
        .collection('kullanicilar')
        .doc(_auth.currentUser!.uid)
        .collection('hayvanlar')
        .where("hayvaninkupeno", isEqualTo: _hayvankupenocontroller.text);
    QuerySnapshot<Map<String, dynamic>> snapshot = await sorgu.get();

    if (snapshot.docs.isNotEmpty) {
      for (DocumentSnapshot<Map<String, dynamic>> dokuman in snapshot.docs) {
        Map<String, dynamic>? hayvanMap = dokuman.data();
        hayvanMap?["id"] = dokuman.id;
        if (hayvanMap != null) {
          HayvanEkleFirebase hayvan = HayvanEkleFirebase.fromJson(hayvanMap);
          String hayvanId = hayvan.hayvanId;
          final docUser = FirebaseFirestore.instance
              .collection('kullanicilar')
              .doc(_auth.currentUser!.uid)
              .collection('hayvanlar')
              .doc(hayvanId)
              .collection('hastalik')
              .doc();
          final hastalik = HastalikEkleFirebase(
              hayvanresim: hayvanresim,
              hastaliknot: hastaliknot,
              hastalikId: docUser.id,
              hayvanId: hayvanId,
              hayvaninkupeno: hayvaninkupeno,
              hastalikismi: hastalikismi,
              hastalikbaslangic: hastalikbaslangic,
              hastalikbitis: hastalikbitis);
          await docUser.set(hastalik.toJson());
        }
      }
    }
  }

  List<String> _hayvanlarkupeno = [];
  List<String> _hayvanlarresim=[];
  Future<List<dynamic>> _readTumHayvanlar() async {
    Query<Map<String, dynamic>> sorgu = FirebaseFirestore.instance
        .collection('kullanicilar')
        .doc(_auth.currentUser!.uid)
        .collection('hayvanlar')
        .where("hayvaninkupeno");

    QuerySnapshot<Map<String, dynamic>> snapshot = await sorgu.get();

    if (sorgu !=null && snapshot.docs.isNotEmpty) {
      for (DocumentSnapshot<Map<String, dynamic>> dokuman in snapshot.docs) {
        Map<String, dynamic>? hayvanMap = dokuman.data();
        hayvanMap?["id"] = dokuman.id;
        if (hayvanMap != null) {
          HayvanEkleFirebase hayvan = HayvanEkleFirebase.fromJson(hayvanMap);
          _hayvanlarkupeno.add(hayvan.hayvaninkupeno);
          _hayvanlarresim.add(hayvan.resim.toString());
        }
      }
    }
    return _hayvanlarkupeno;
  }

  Timer? _timer;
  void startTimer(String hinttext, bool deger) {
    int _start = 50;
    const oneSec = const Duration(milliseconds: 10);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0 && deger == true) {
          setState(() {
            timer.cancel();
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => viewHastalikSayfasi()),).then((res) => modelHastalikSayfasi());
          });
        } else if (_start == 0 && deger == false) {
          setState(() {
            timer.cancel();
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
                      height: 40,
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
                          child: Wrap(
                            children: [
                              Text(
                                hinttext,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "lucida",
                                  fontSize: 12,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ],
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


  
  textemptycontrol(){
    if(_hayvankupenocontroller.text.isNotEmpty &&  _hastalikismicontroller.text.isNotEmpty){
       _textfieldkontrol = true;
       DateTime hastalikbaslangic = new DateFormat(_dateFormat).parse(_hastalikbaslangiccontroller.text);
       DateTime hastalikbitis = new DateFormat(_dateFormat).parse(_hastalikbitiscontroller.text);
       if(hastalikbitis.difference(hastalikbaslangic).inDays>0){
           _tarihkontrol=true;
       }
      else{
         _tarihkontrol=false;
      }
    }
    else{
      _textfieldkontrol =false;
    }
  }
}
