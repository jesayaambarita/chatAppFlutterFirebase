import 'package:flutter/material.dart';
import 'package:projek_pertama/screen/dataDiriScreen.dart';

class HasilPencarianTiket extends StatefulWidget {
  const HasilPencarianTiket({super.key});

  @override
  State<HasilPencarianTiket> createState() => _HasilPencarianTiketState();
}

class _HasilPencarianTiketState extends State<HasilPencarianTiket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text("Hasil Pencarian Tiket"),
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
      body: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Text(
                  "Hasil Pencarian",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 15),
                child: Text(
                  "Ditemukan 5 armada ke tempat tujuan",
                  style: TextStyle(
                    fontSize: 10,
                  ),
                ),
              ),
              ListView.builder(
                itemCount: 6,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Card(
                      child: SizedBox(
                        height: 140,
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 15, 10, 0),
                                child: Text(
                                  "Bu.001",
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(10, 10, 20, 0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Ekonomi Toilet Double Dacker",
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "14.00 WIB",
                                          style: TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          "Rp.100.000",
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "Tersisa 8 kursi",
                                          style: TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Divider(
                                height: 10,
                                color: Colors.grey.shade400,
                                thickness: 1,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DataDiri()),
                                  );
                                },
                                child: Center(
                                    child: Text(
                                  "Detail Fasilitas",
                                  style: TextStyle(fontSize: 15),
                                )),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
