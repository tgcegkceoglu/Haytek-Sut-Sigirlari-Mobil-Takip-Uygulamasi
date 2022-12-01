import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:haytek/classandvariable/bilgiler.dart';
import 'package:haytek/model/bottomnavigatorbar.dart';
import 'package:haytek/model/hastalikbilgileri/HastalikSayfasi.dart';
import 'package:haytek/model/hastalikbilgileri/hastalikekle.dart';
import 'package:haytek/model/header.dart';
import 'package:haytek/model/tohumlamaekle.dart';
import 'package:haytek/classandvariable/veriler.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:truncate/truncate.dart';

class TohumlamaSayfasi extends StatefulWidget {
  const TohumlamaSayfasi({Key? key}) : super(key: key);

  @override
  State<TohumlamaSayfasi> createState() => _TohumlamaSayfasiState();
}

tohumlamakelime(String metin) {
  String text = metin;
  String yenimetin =
      truncate(text, 10, omission: "...", position: TruncatePosition.end);
  return yenimetin;
}

Veriler veri = Veriler();
final dateFormat = DateFormat('dd/MM/yyyy');
CalendarFormat format = CalendarFormat.month;
DateTime selectedDay = DateTime.now();
DateTime focusedDay = DateTime.now();
TextEditingController kupeno = TextEditingController();
TextEditingController hayvanirkno = TextEditingController();
TextEditingController bogairkno = TextEditingController();
TextEditingController bogakupeno = TextEditingController();
TextEditingController tohumlamayapanvet = TextEditingController();
TextEditingController tohumlamabaslangic = TextEditingController();
TextEditingController tohumlamabitis = TextEditingController();

class _TohumlamaSayfasiState extends State<TohumlamaSayfasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      bottomNavigationBar: BottomNavigatorBarSayfa(
                        onpress: (){},
                          bottomtext: "Tohumlama Ekle",
                          hinttext: "Tohumlama Eklendi!"),
                      appBar: AppBar(
                        backgroundColor: Colors.transparent,
                        automaticallyImplyLeading: false,
                        title: Text(
                          "Tohumlama Ekle",
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
                        child: TohumalaEkleModal(),
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
        child: Column(
          children: [
            Header(baslik: "Tohumlama"),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 2, color: Color(0xFFECECEC)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 3,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: TextFormField(
                cursorColor: Colors.black,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 15),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Color(0xFF375BA3),
                    ),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "Tohumlama Bilgisi Ara"),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: veri.kupeno.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        kupeno.text = veri.kupeno[index].toString();
                        hayvanirkno.text = veri.irk[index].toString();
                        bogairkno.text = veri.bogairk[index].toString();
                        tohumlamayapanvet.text =
                            veri.asilayankisi[index].toString();
                        bogakupeno.text = veri.bogakupeno[index].toString();
                        tohumlamabaslangic.text =
                            veri.asilamatarihi[index].toString();
                        tohumlamabitis.text =
                            veri.asilamatarihison[index].toString();
                        showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: Colors.white,
                            context: context,
                            constraints: BoxConstraints(
                                maxHeight:
                                    MediaQuery.of(context).size.height * 0.8),
                            builder: (context) {
                              return Scaffold(
                                bottomNavigationBar: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              right: 16,
                                              left: 16,
                                              bottom: 16,
                                              top: 16),
                                          child: Container(
                                              padding: EdgeInsets.only(
                                                  right: 35, left: 35),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Color(0xFF375BA3),
                                                    Color(0xFF29E3D7)
                                                  ],
                                                  begin: FractionalOffset
                                                      .centerLeft,
                                                  end: FractionalOffset
                                                      .centerRight,
                                                ),
                                              ),
                                              child: TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    kupeno.text = veri
                                                        .kupeno[index]
                                                        .toString();
                                                    hayvanirkno.text = veri
                                                        .irk[index]
                                                        .toString();
                                                    bogairkno.text = veri
                                                        .bogakupeno[index]
                                                        .toString();
                                                    tohumlamabaslangic.text =
                                                        veri.asilamatarihi[
                                                                index]
                                                            .toString();
                                                    tohumlamabitis.text = veri
                                                        .asilamatarihison[index]
                                                        .toString();
                                                    startTimer(
                                                        "Bilgiler Güncellendi!");
                                                  });
                                                },
                                                child: Text(
                                                  "Güncelle",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white),
                                                ),
                                              ))),
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              right: 16,
                                              left: 16,
                                              bottom: 16,
                                              top: 16),
                                          child: Container(
                                              padding: EdgeInsets.only(
                                                  right: 35, left: 35),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Color(0xFF375BA3),
                                                    Color(0xFF29E3D7)
                                                  ],
                                                  begin: FractionalOffset
                                                      .centerLeft,
                                                  end: FractionalOffset
                                                      .centerRight,
                                                ),
                                              ),
                                              child: TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    Navigator.pop(context);
                                                  });
                                                },
                                                child: Text(
                                                  "İptal",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white),
                                                ),
                                              ))),
                                    ]),
                                body: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: ListView(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Bilgiler",
                                            style: TextStyle(
                                                color: Color(0xFF375BA3),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17),
                                          ),
                                          IconButton(
                                              color: Color(0xFF375BA3),
                                              constraints: BoxConstraints(),
                                              padding: EdgeInsets.zero,
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              icon: Icon(Icons.close))
                                        ],
                                      ),
                                      SizedBox(
                                        height: 13,
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(colors: [
                                            Color(0xFF375BA3),
                                            Color(0xFF29E3D7)
                                          ]),
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                          child: TextField(
                                            cursorColor: Colors.black,
                                            controller: kupeno,
                                            decoration: InputDecoration(
                                              labelText: "Küpe Numarası",
                                              labelStyle: TextStyle(
                                                  fontSize: 20,
                                                  color: Color(0xFF375BA3),
                                                  fontWeight: FontWeight.bold),
                                              contentPadding: EdgeInsets.zero,
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(colors: [
                                            Color(0xFF375BA3),
                                            Color(0xFF29E3D7)
                                          ]),
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                          child: TextField(
                                            cursorColor: Colors.black,
                                            controller: hayvanirkno,
                                            decoration: InputDecoration(
                                              labelText: "Hayvanın Irkı",
                                              labelStyle: TextStyle(
                                                  fontSize: 20,
                                                  color: Color(0xFF375BA3),
                                                  fontWeight: FontWeight.bold),
                                              contentPadding: EdgeInsets.zero,
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(colors: [
                                            Color(0xFF375BA3),
                                            Color(0xFF29E3D7)
                                          ]),
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                          child: TextField(
                                            cursorColor: Colors.black,
                                            controller: bogakupeno,
                                            decoration: InputDecoration(
                                              labelText: "Boğa Küpe No",
                                              labelStyle: TextStyle(
                                                  fontSize: 20,
                                                  color: Color(0xFF375BA3),
                                                  fontWeight: FontWeight.bold),
                                              contentPadding: EdgeInsets.zero,
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(colors: [
                                            Color(0xFF375BA3),
                                            Color(0xFF29E3D7)
                                          ]),
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                          child: TextField(
                                            cursorColor: Colors.black,
                                            controller: bogairkno,
                                            decoration: InputDecoration(
                                              labelText: "Boğanın Irkı",
                                              labelStyle: TextStyle(
                                                  fontSize: 20,
                                                  color: Color(0xFF375BA3),
                                                  fontWeight: FontWeight.bold),
                                              contentPadding: EdgeInsets.zero,
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(colors: [
                                            Color(0xFF375BA3),
                                            Color(0xFF29E3D7)
                                          ]),
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                          child: TextField(
                                            cursorColor: Colors.black,
                                            controller: tohumlamayapanvet,
                                            decoration: InputDecoration(
                                              labelText:
                                                  "Tohumlama Yapan Veteriner",
                                              labelStyle: TextStyle(
                                                  fontSize: 20,
                                                  color: Color(0xFF375BA3),
                                                  fontWeight: FontWeight.bold),
                                              contentPadding: EdgeInsets.zero,
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(colors: [
                                            Color(0xFF375BA3),
                                            Color(0xFF29E3D7)
                                          ]),
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                          child: TextField(
                                            cursorColor: Colors.black,
                                            inputFormatters: [maskFormatter],
                                            controller: tohumlamabaslangic,
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
                                                              body:
                                                                  TableCalendar(
                                                                locale: 'tr_TR',
                                                                focusedDay:
                                                                    focusedDay,
                                                                firstDay:
                                                                    DateTime(
                                                                        1990),
                                                                lastDay:
                                                                    DateTime(
                                                                        2050),
                                                                calendarFormat:
                                                                    format,
                                                                onFormatChanged:
                                                                    (CalendarFormat
                                                                        _format) {
                                                                  setState(() {
                                                                    format =
                                                                        _format; // Bugünün Tarihini Seçtirdik.
                                                                  });
                                                                },
                                                                calendarStyle:
                                                                    CalendarStyle(
                                                                        todayDecoration:
                                                                            BoxDecoration(
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              123,
                                                                              203,
                                                                              198),
                                                                          shape:
                                                                              BoxShape.circle,
                                                                        ),
                                                                        isTodayHighlighted:
                                                                            true,
                                                                        selectedDecoration:
                                                                            BoxDecoration(
                                                                          gradient:
                                                                              LinearGradient(
                                                                            colors: [
                                                                              Color(0xFF375BA3),
                                                                              Color(0xFF29E3D7)
                                                                            ],
                                                                            begin:
                                                                                FractionalOffset.centerLeft,
                                                                            end:
                                                                                FractionalOffset.centerRight,
                                                                          ),
                                                                          shape:
                                                                              BoxShape.circle,
                                                                        ),
                                                                        selectedTextStyle:
                                                                            TextStyle(color: Colors.white)),
                                                                daysOfWeekStyle:
                                                                    DaysOfWeekStyle(
                                                                  weekendStyle:
                                                                      TextStyle(
                                                                          color:
                                                                              Colors.black),
                                                                  weekdayStyle:
                                                                      TextStyle(
                                                                          color:
                                                                              Colors.black),
                                                                ),
                                                                headerStyle:
                                                                    HeaderStyle(
                                                                  formatButtonVisible:
                                                                      true,
                                                                  titleCentered:
                                                                      true,
                                                                  formatButtonShowsNext:
                                                                      false,
                                                                  formatButtonDecoration:
                                                                      BoxDecoration(
                                                                    border: Border.all(
                                                                        width:
                                                                            1,
                                                                        color: Color(
                                                                            0xFF375BA3)),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            34),
                                                                  ),
                                                                ),
                                                                selectedDayPredicate:
                                                                    (DateTime
                                                                        date) {
                                                                  return isSameDay(
                                                                      selectedDay,
                                                                      date);
                                                                },
                                                                startingDayOfWeek:
                                                                    StartingDayOfWeek
                                                                        .monday,
                                                                daysOfWeekVisible:
                                                                    true,
                                                                onDaySelected: (DateTime
                                                                        selectDay,
                                                                    DateTime
                                                                        focusDay) {
                                                                  setState(() {
                                                                    selectedDay =
                                                                        selectDay;
                                                                    focusedDay =
                                                                        focusDay;
                                                                    tohumlamabaslangic
                                                                            .text =
                                                                        dateFormat
                                                                            .format(selectDay);
                                                                    Navigator.pop(
                                                                        context);
                                                                  });
                                                                },
                                                              ),
                                                            ),
                                                          );
                                                        });
                                                  }),
                                              labelText:
                                                  "Tohumlama Başlangıç Tarihi",
                                              labelStyle: TextStyle(
                                                  fontSize: 20,
                                                  color: Color(0xFF375BA3),
                                                  fontWeight: FontWeight.bold),
                                              contentPadding: EdgeInsets.zero,
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(colors: [
                                            Color(0xFF375BA3),
                                            Color(0xFF29E3D7)
                                          ]),
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                          child: TextField(
                                            inputFormatters: [maskFormatter],
                                            cursorColor: Colors.black,
                                            controller: tohumlamabitis,
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
                                                              body:
                                                                  TableCalendar(
                                                                focusedDay:
                                                                    focusedDay,
                                                                firstDay:
                                                                    DateTime(
                                                                        1990),
                                                                lastDay:
                                                                    DateTime(
                                                                        2050),
                                                                calendarFormat:
                                                                    format,
                                                                onFormatChanged:
                                                                    (CalendarFormat
                                                                        _format) {
                                                                  setState(() {
                                                                    format =
                                                                        _format; // Bugünün Tarihini Seçtirdik.
                                                                  });
                                                                },
                                                                calendarStyle:
                                                                    CalendarStyle(
                                                                        todayDecoration:
                                                                            BoxDecoration(
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              123,
                                                                              203,
                                                                              198),
                                                                          shape:
                                                                              BoxShape.circle,
                                                                        ),
                                                                        isTodayHighlighted:
                                                                            true,
                                                                        selectedDecoration:
                                                                            BoxDecoration(
                                                                          gradient:
                                                                              LinearGradient(
                                                                            colors: [
                                                                              Color(0xFF375BA3),
                                                                              Color(0xFF29E3D7)
                                                                            ],
                                                                            begin:
                                                                                FractionalOffset.centerLeft,
                                                                            end:
                                                                                FractionalOffset.centerRight,
                                                                          ),
                                                                          shape:
                                                                              BoxShape.circle,
                                                                        ),
                                                                        selectedTextStyle:
                                                                            TextStyle(color: Colors.white)),
                                                                daysOfWeekStyle:
                                                                    DaysOfWeekStyle(
                                                                  weekendStyle:
                                                                      TextStyle(
                                                                          color:
                                                                              Colors.black),
                                                                  weekdayStyle:
                                                                      TextStyle(
                                                                          color:
                                                                              Colors.black),
                                                                ),
                                                                headerStyle:
                                                                    HeaderStyle(
                                                                  formatButtonVisible:
                                                                      true,
                                                                  titleCentered:
                                                                      true,
                                                                  formatButtonShowsNext:
                                                                      false,
                                                                  formatButtonDecoration:
                                                                      BoxDecoration(
                                                                    border: Border.all(
                                                                        width:
                                                                            1,
                                                                        color: Color(
                                                                            0xFF375BA3)),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            34),
                                                                  ),
                                                                ),
                                                                selectedDayPredicate:
                                                                    (DateTime
                                                                        date) {
                                                                  return isSameDay(
                                                                      selectedDay,
                                                                      date);
                                                                },
                                                                startingDayOfWeek:
                                                                    StartingDayOfWeek
                                                                        .monday,
                                                                daysOfWeekVisible:
                                                                    true,
                                                                onDaySelected: (DateTime
                                                                        selectDay,
                                                                    DateTime
                                                                        focusDay) {
                                                                  setState(() {
                                                                    selectedDay =
                                                                        selectDay;
                                                                    focusedDay =
                                                                        focusDay;
                                                                    tohumlamabitis
                                                                            .text =
                                                                        dateFormat
                                                                            .format(selectDay);
                                                                    Navigator.pop(
                                                                        context);
                                                                  });
                                                                },
                                                              ),
                                                            ),
                                                          );
                                                        });
                                                  }),
                                              labelText:
                                                  "Tohumlama Bitiş Tarihi",
                                              labelStyle: TextStyle(
                                                  fontSize: 20,
                                                  color: Color(0xFF375BA3),
                                                  fontWeight: FontWeight.bold),
                                              contentPadding: EdgeInsets.zero,
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      child: Text(""), /*  Bilgiler(
                        deger: false,
                        resim: veri.resimyolu[index],
                        icon: FaIcon(FontAwesomeIcons.seedling,
                            color: Color(0xFF375BA3)),
                        icerik: SingleChildScrollView(
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
                                          tohumlamakelime(veri.kupeno[index]))),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Hayvanın Irkı",
                                    style: TextStyle(
                                        color: Color(0xFF375BA3),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(tohumlamakelime(veri.irk[index])),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Boğanın Irkı",
                                    style: TextStyle(
                                        color: Color(0xFF375BA3),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(tohumlamakelime(veri.bogairk[index])),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Boğanın Küpe Numarası",
                                    style: TextStyle(
                                        color: Color(0xFF375BA3),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(tohumlamakelime(veri.bogakupeno[index])),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Tohumlama Yapan Veteriner",
                                    style: TextStyle(
                                        color: Color(0xFF375BA3),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(tohumlamakelime(
                                      veri.asilayankisi[index])),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Tohumlama Başlangıç Tarihi",
                                    style: TextStyle(
                                        color: Color(0xFF375BA3),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(veri.asilamatarihi[index]),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Tohumlama Bitiş Tarihi",
                                    style: TextStyle(
                                        color: Color(0xFF375BA3),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(veri.asilamatarihison[index]),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ), */
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Timer? _timer;
  void startTimer(String hinttext) {
    int _start = 50;
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
                              fontSize: 14,
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
          setState(() {
            _start--;
          });
        }
      },
    );
  }
}
