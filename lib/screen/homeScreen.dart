import 'package:flutter/material.dart';
import 'package:projek_pertama/screen/hasilPencarian.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var top = 0.0;

  late ScrollController _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                elevation: 0,
                expandedHeight: 350,
                flexibleSpace: Stack(
                  children: <Widget>[
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
                    SafeArea(
                      child: Container(
                        margin: EdgeInsets.all(20),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Selamat Datang',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      'Jesaya Sohasuhatan',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                Image(
                                  image: AssetImage("images/logo.png"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0.0,
                      top: 0.0,
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
              // SliverPadding(
              //   padding: EdgeInsets.all(8.0),
              //   sliver: SliverGrid.builder(
              //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //         crossAxisCount: 2,
              //         mainAxisSpacing: 8.0,
              //         crossAxisSpacing: 8.0),
              //     itemBuilder: (BuildContext context, int index) {
              //       return Container(
              //         decoration: BoxDecoration(
              //           color: Colors.white,
              //           borderRadius: BorderRadius.all(
              //             Radius.circular(10),
              //           ),
              //         ),
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
          _card(),
        ],
      ),
    );
  }

  Widget _card() {
    TextEditingController _textEditingController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    String _selectedItem;
    final double defaultMargin = 130;
    final double defaultStart = 250;
    final double defaultEnd = defaultStart / 2;
    double top = defaultMargin;
    double scale = 1.0;
    if (_scrollController.hasClients) {
      double offset = _scrollController.offset;
      top -= offset;
      if (offset < defaultMargin - defaultStart) {
        scale = 1.0;
      } else if (offset < defaultStart - defaultEnd) {
        scale = (defaultMargin - defaultEnd - offset) / defaultEnd;
      } else {
        scale = 0.0;
      }
    }
    return Positioned(
      top: top,
      bottom: 60,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 400,
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(7),
                ),
                color: Colors.white,
              ),
              child: Container(
                margin: EdgeInsets.all(10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text("Keberangkatan"),
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 20),
                        child: DropdownButtonFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Pillih Kota Keberangkatan';
                            }
                          },
                          decoration: InputDecoration(
                            labelText: "Pilih Keberangkatan",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                          ),
                          items: [
                            DropdownMenuItem(
                              child: Text("Sibolga"),
                              value: "option1",
                            ),
                            DropdownMenuItem(
                              child: Text("Medan"),
                              value: "option2",
                            ),
                            DropdownMenuItem(
                              child: Text("Tanjung Pura"),
                              value: "option3",
                            ),
                            DropdownMenuItem(
                              child: Text("Pekanbaru"),
                              value: "option4",
                            ),
                          ],
                          onChanged: (newValue) {},
                        ),
                      ),
                      Container(
                        child: Text("Tujuan"),
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 20),
                        child: DropdownButtonFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Pilih Kota Tujuan';
                            }
                          },
                          decoration: InputDecoration(
                            labelText: "Pilih Tujuan",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                          ),
                          items: [
                            DropdownMenuItem(
                              child: Text("Sibolga"),
                              value: "option1",
                            ),
                            DropdownMenuItem(
                              child: Text("Medan"),
                              value: "option2",
                            ),
                            DropdownMenuItem(
                              child: Text("Tanjung Pura"),
                              value: "option3",
                            ),
                            DropdownMenuItem(
                              child: Text("Pekanbaru"),
                              value: "option4",
                            ),
                          ],
                          onChanged: (newValue) {},
                        ),
                      ),
                      Container(
                        child: Text("Tanggal"),
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 20),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Pilih Jadwal Keberangkatan';
                            }
                          },
                          controller: _textEditingController,
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.arrow_drop_down),
                            labelText: "Pilih Tanggal",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                          ),
                          onTap: () async {
                            DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1000),
                              lastDate: DateTime(2045),
                            );
                            if (picked != null) {
                              _textEditingController.text =
                                  picked.toString().substring(0, 10);
                            }
                          },
                        ),
                      ),
                      Container(
                        child: Text("Armada"),
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 20),
                        child: DropdownButtonFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Pilih Armada Bus';
                            }
                          },
                          decoration: InputDecoration(
                            labelText: "Pilih Armada",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                          ),
                          items: [
                            DropdownMenuItem(
                              child: Text("Ekonomi Toilet"),
                              value: "option1",
                            ),
                            DropdownMenuItem(
                              child: Text("Ekonomi Ac"),
                              value: "option2",
                            ),
                            DropdownMenuItem(
                              child: Text("Executive"),
                              value: "option3",
                            ),
                            DropdownMenuItem(
                              child: Text("Ac Toilet"),
                              value: "option4",
                            ),
                          ],
                          onChanged: (newValue) {},
                        ),
                      ),
                      Container(
                        child: Text("Penumpang"),
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 10),
                        child: DropdownButtonFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Pilih Jumlah Penumpang';
                            }
                          },
                          decoration: InputDecoration(
                            labelText: "Pilih Jumlah",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                          ),
                          items: [
                            DropdownMenuItem(
                              child: Text("3"),
                              value: "option1",
                            ),
                            DropdownMenuItem(
                              child: Text("2"),
                              value: "option2",
                            ),
                            DropdownMenuItem(
                              child: Text("4"),
                              value: "option3",
                            ),
                            DropdownMenuItem(
                              child: Text("1"),
                              value: "option4",
                            ),
                          ],
                          onChanged: (newValue) {},
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        child: Text(
                          "Anak dengan usia diatas 3 tahun dikenakan biaya penuh",
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HasilPencarianTiket()),
                          );
                        },
                        child: Container(
                          height: 48,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Cari Tiket",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
