import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:convert';

class PilihKursi extends StatefulWidget {
  const PilihKursi({super.key});

  @override
  State<PilihKursi> createState() => _PilihKursiState();
}

class _PilihKursiState extends State<PilihKursi> {
  Color _color = Colors.greenAccent;
  bool _clicked1 = false;
  bool _clicked2 = false;
  // String jsonData = jsonEncode(data);

  Map<String, dynamic> data = {
    'noKursi': 'A1',
    'kursi': 'A2',
    'kursi2': 'A3',
    'kursi3': 'A4',
    'kursi4': 'B1',
    'kursi5': 'B2',
    'kursi6': 'B3',
    'kursi7': 'B4',
    'kursi8': 'C1',
    'kursi9': 'C2',
    'kursi10': 'C3',
    'kursi11': 'C4',
    'kursi12': 'D1',
    'kursi13': 'D2',
    'kursi14': 'D3',
    'kursi15': 'D4',
    'kursi16': 'E1',
    'kursi17': 'E2',
    'kursi18': 'E3',
    'kursi19': 'E4',
    'kursi20': 'F1',
    'kursi21': 'F2',
    'kursi22': 'F3',
    'kursi23': 'F4',
    'kursi24': 'F5',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text("Pilih Kursi"),
        flexibleSpace: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.orange,
                    Colors.orange.shade500,
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0.0,
              top: 0.0,
              right: 0.0,
              left: 0.0,
              child: Opacity(
                opacity: 0.1,
                child: Image.asset(
                  "images/backgroundAppbar.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Material(
                  elevation: 1,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 30,
                            decoration:
                                BoxDecoration(color: Colors.orange.shade500),
                            child: Container(
                              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Row(
                                children: <Widget>[
                                  Center(
                                    child: Text(
                                      "Medan",
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Center(
                                    child: Icon(
                                      Icons.arrow_forward,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Center(
                                    child: Text(
                                      "Sibolga",
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Center(
                                    child: Text(
                                      ".",
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Center(
                                    child: Text(
                                      "28 Feb",
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Center(
                                    child: Text(
                                      ".",
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Center(
                                    child: Text(
                                      "3 Orang",
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 60,
                                  ),
                                  Center(
                                    child: Icon(
                                      Icons.edit,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(20, 15, 10, 20),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.bus_alert_outlined),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "BU.001",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Executive Double Dacker",
                                        style: TextStyle(fontSize: 11),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 400,
                  child: Material(
                    elevation: 1,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 110,
                                  height: 30,
                                  color: Colors.grey.shade500,
                                  child: Center(
                                    child: Text(
                                      "Pintu Keluar",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 110,
                                  height: 30,
                                  color: Colors.redAccent,
                                  child: Center(
                                    child: Text(
                                      "Supir",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _clicked1 = !_clicked1;
                                    });
                                  },
                                  child: Container(
                                    width: 40,
                                    height: 30,
                                    color: _clicked1
                                        ? Colors.greenAccent
                                        : Colors.grey.shade400,
                                    child: Center(
                                      child: Text(
                                        "A1",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _clicked2 = !_clicked2;
                                    });
                                  },
                                  child: Container(
                                    width: 40,
                                    height: 30,
                                    color: _clicked2
                                        ? Colors.greenAccent
                                        : Colors.grey.shade400,
                                    child: Center(
                                      child: Text(
                                        "A2",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 40,
                                  height: 30,
                                  color: Colors.grey.shade400,
                                  child: Center(
                                    child: Text(
                                      "A3",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 40,
                                  height: 30,
                                  color: Colors.grey.shade400,
                                  child: Center(
                                    child: Text(
                                      "A4",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 40,
                                  height: 30,
                                  color: Colors.grey.shade400,
                                  child: Center(
                                    child: Text(
                                      "B1",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 40,
                                  height: 30,
                                  color: Colors.grey.shade400,
                                  child: Center(
                                    child: Text(
                                      "B2",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 40,
                                  height: 30,
                                  color: Colors.grey.shade400,
                                  child: Center(
                                    child: Text(
                                      "B3",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 40,
                                  height: 30,
                                  color: Colors.grey.shade400,
                                  child: Center(
                                    child: Text(
                                      "B4",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 40,
                                  height: 30,
                                  color: Colors.grey.shade400,
                                  child: Center(
                                    child: Text(
                                      "C1",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 40,
                                  height: 30,
                                  color: Colors.grey.shade400,
                                  child: Center(
                                    child: Text(
                                      "C2",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 40,
                                  height: 30,
                                  color: Colors.grey.shade400,
                                  child: Center(
                                    child: Text(
                                      "C3",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 40,
                                  height: 30,
                                  color: Colors.grey.shade400,
                                  child: Center(
                                    child: Text(
                                      "C4",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 40,
                                  height: 30,
                                  color: Colors.grey.shade400,
                                  child: Center(
                                    child: Text(
                                      "D1",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 40,
                                  height: 30,
                                  color: Colors.grey.shade400,
                                  child: Center(
                                    child: Text(
                                      "D2",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 40,
                                  height: 30,
                                  color: Colors.grey.shade400,
                                  child: Center(
                                    child: Text(
                                      "D3",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 40,
                                  height: 30,
                                  color: Colors.grey.shade400,
                                  child: Center(
                                    child: Text(
                                      "D4",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 130,
                                  height: 30,
                                  color: Colors.grey.shade400,
                                  child: Center(
                                    child: Text(
                                      "Pintu Keluar",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 40,
                                  height: 30,
                                  color: Colors.grey.shade400,
                                  child: Center(
                                    child: Text(
                                      "D5",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 40,
                                  height: 30,
                                  color: Colors.grey.shade400,
                                  child: Center(
                                    child: Text(
                                      "D6",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 40,
                                  height: 30,
                                  color: Colors.grey.shade400,
                                  child: Center(
                                    child: Text(
                                      "E1",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 40,
                                  height: 30,
                                  color: Colors.grey.shade400,
                                  child: Center(
                                    child: Text(
                                      "E2",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 40,
                                  height: 30,
                                  color: Colors.grey.shade400,
                                  child: Center(
                                    child: Text(
                                      "E3",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 40,
                                  height: 30,
                                  color: Colors.grey.shade400,
                                  child: Center(
                                    child: Text(
                                      "E4",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 40,
                                  height: 30,
                                  color: Colors.grey.shade400,
                                  child: Center(
                                    child: Text(
                                      "F1",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 40,
                                  height: 30,
                                  color: Colors.grey.shade400,
                                  child: Center(
                                    child: Text(
                                      "F2",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 40,
                                  height: 30,
                                  color: Colors.grey.shade400,
                                  child: Center(
                                    child: Text(
                                      "F3",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 40,
                                  height: 30,
                                  color: Colors.grey.shade400,
                                  child: Center(
                                    child: Text(
                                      "F4",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 310,
                                  height: 30,
                                  color: Colors.grey.shade400,
                                  child: Center(
                                    child: Text(
                                      "F5",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 30,
                      height: 30,
                      color: Colors.grey.shade400,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Tersedia"),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                      width: 30,
                      height: 30,
                      color: Colors.greenAccent,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Dipilih"),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                      width: 30,
                      height: 30,
                      color: Colors.redAccent,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Tidak Tersedia"),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0.0,
            child: GestureDetector(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => PilihKursi()),
                // );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 0, 0, 10),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.chair_outlined),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Kursi :"),
                        Container(
                          margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                          child: _clicked1
                              ? Text("$data[0]")
                              : Text("Tidak Ada Dipilih"),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 48,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.green,
                    ),
                    child: Center(
                      child: Text(
                        "Simpan Kursi",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
