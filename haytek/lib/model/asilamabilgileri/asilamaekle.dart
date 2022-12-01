import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:haytek/Firebase_VeriTabani/hayvanekle/hayvanekle.dart';
import 'package:haytek/Firebase_VeriTabani/notlar/asilama.dart';
import 'package:haytek/Firebase_VeriTabani/notlar/hastalik.dart';
import 'package:haytek/model/hastalikbilgileri/HastalikSayfasi.dart';
import 'package:haytek/model/textfieldarama.dart';
import 'package:haytek/classandvariable/veriler.dart';
import 'package:haytek/view/hastaliksayfasi.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:table_calendar/table_calendar.dart';

class AsilamaEkleModal extends StatefulWidget {
  const AsilamaEkleModal({Key? key}) : super(key: key);

  @override
  State<AsilamaEkleModal> createState() => _AsilamaEkleModalState();
}

FirebaseAuth _auth = FirebaseAuth.instance;
CalendarFormat _format = CalendarFormat.month;
DateTime _selectedDay = DateTime.now();
DateTime _focusedDay = DateTime.now();
final _dateFormat = 'dd.MM.yyyy';
Veriler veri = Veriler();
final _formattedDate = DateFormat(_dateFormat).format(DateTime.now());
TextEditingController _hayvankupenocontroller = TextEditingController();
TextEditingController _asilamaismicontroller = TextEditingController();
TextEditingController _asilamanot = TextEditingController();
TextEditingController _asilayankisi = TextEditingController();
TextEditingController _asilamabaslangiccontroller =TextEditingController(text: _formattedDate);
TextEditingController _asilamabitiscontroller =TextEditingController(text: _formattedDate);
var maskFormatter = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy);

class _AsilamaEkleModalState extends State<AsilamaEkleModal> {
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
                    createAsilama(hayvaninkupeno:_hayvankupenocontroller.text, asilayankisiismi: _asilayankisi.text, asilamanot: _asilamanot.text, yapilanasiismi: _asilamaismicontroller.text, asilamabaslangic: DateFormat(_dateFormat)
                          .parse(_asilamabaslangiccontroller.text), asilamabitis: DateFormat(_dateFormat)
                          .parse(_asilamabitiscontroller.text),);
                    _startTimer("Aşılama Eklendi!");
                     Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => viewHastalikSayfasi()),).then((res) => modelHastalikSayfasi());
                   
                  },
                  child: Text(
                    "Aşılamayı Ekle",
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
                      inputType: TextInputType.text,
                      controller: _asilamaismicontroller,
                      hinttext: "Aşının İsmini Giriniz...",
                      items: veri.asiismi,
                      selectedItem: _asilamaismicontroller.text,
                      onSelection: (v) {
                        _asilamaismicontroller.text = v;
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
                    controller: _asilamaismicontroller,
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: "Aşıyı Seçiniz",
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
            //aşı başlangıç tarihi
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
                controller: _asilamabaslangiccontroller,
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
                                        _asilamabaslangiccontroller.text =
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
                  labelText: 'Aşılama Başlangıç Tarihi',
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
                controller: _asilamabitiscontroller,
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
                                        _asilamabitiscontroller.text =
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
                  labelText: 'Aşılama Bitiş Tarihi',
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
                  controller: _asilamanot,
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

  Future createAsilama({
     File? secilendosya,
    required String hayvaninkupeno,
    required String asilayankisiismi,
    required String asilamanot,
    required String yapilanasiismi,
    required DateTime asilamabaslangic,
    required DateTime asilamabitis,
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
              .collection('asilama')
              .doc();
          final asi = AsilamaEkleFirebase(asilamanot: asilamanot, asilayankisiismi: asilayankisiismi, hayvanId: hayvanId, asilamaId: docUser.id, hayvaninkupeno: hayvaninkupeno, yapilanasiismi: yapilanasiismi, asilamabaslangic: asilamabaslangic, asilamabitis: asilamabitis);
          await docUser.set(asi.toJson());
        }
      }
    }
  }

  List<String> _hayvanlarkupeno = [];
  List<String> _hayvanIdleri = [];
  Future<List<dynamic>> _readTumHayvanlar() async {
    Query<Map<String, dynamic>> sorgu = FirebaseFirestore.instance
        .collection('kullanicilar')
        .doc(_auth.currentUser!.uid)
        .collection('hayvanlar')
        .where("hayvaninkupeno");

    QuerySnapshot<Map<String, dynamic>> snapshot = await sorgu.get();

    if (snapshot.docs.isNotEmpty) {
      for (DocumentSnapshot<Map<String, dynamic>> dokuman in snapshot.docs) {
        Map<String, dynamic>? hayvanMap = dokuman.data();
        hayvanMap?["id"] = dokuman.id;
        if (hayvanMap != null) {
          HayvanEkleFirebase hayvan = HayvanEkleFirebase.fromJson(hayvanMap);
          _hayvanlarkupeno.add(hayvan.hayvaninkupeno);
          _hayvanIdleri.add(hayvan.hayvanId);
        }
      }
    }
    return _hayvanlarkupeno;
  }

  Timer? _timer;
  void _startTimer(String hinttext) {
    int _start = 100;
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
          if (mounted) {
            setState(() {
              _start--;
            });
          }
        }
      },
    );
  }
}
