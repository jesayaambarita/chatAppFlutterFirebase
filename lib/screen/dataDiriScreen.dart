import 'package:flutter/material.dart';
import 'package:projek_pertama/screen/pilihKursiScreen.dart';

class DataDiri extends StatefulWidget {
  const DataDiri({super.key});

  @override
  State<DataDiri> createState() => _DataDiriState();
}

class _DataDiriState extends State<DataDiri> {
  TextEditingController _textEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<Item> _items = [];
  generateList(int length) {
    return List.generate(length, (index) => Item());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _items = generateList(10);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text("Isi Data Diri"),
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
          Container(
            margin: EdgeInsets.all(20),
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return ExpansionPanelList(
                  expansionCallback: (_, __) {
                    setState(() {
                      _items[index].isOpen = !_items[index].isOpen;
                    });
                  },
                  children: [
                    ExpansionPanel(
                      canTapOnHeader: true,
                      headerBuilder: (context, isOpen) {
                        return Row(
                          children: <Widget>[
                            SizedBox(
                              width: 10,
                            ),
                            Icon(Icons.person),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Data Pemesanan",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        );
                      },
                      body: Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: Form(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Nama Lengkap"),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 15, 0, 10),
                                child: TextFormField(
                                  validator: (value) {},
                                  controller: _textEditingController,
                                  decoration: InputDecoration(
                                    labelText: "Nama Lengkap",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                    ),
                                  ),
                                  onTap: () async {},
                                ),
                              ),
                              Text("Tanggal Lahir"),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 15, 0, 10),
                                child: TextFormField(
                                  validator: (value) {},
                                  controller: _textEditingController,
                                  decoration: InputDecoration(
                                    suffixIcon: Icon(Icons.arrow_drop_down),
                                    labelText: "Tanggal Lahir",
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
                              Text("Email"),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 15, 0, 10),
                                child: TextFormField(
                                  validator: (value) {},
                                  controller: _textEditingController,
                                  decoration: InputDecoration(
                                    labelText: "Email",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                    ),
                                  ),
                                  onTap: () async {},
                                ),
                              ),
                              Text("Telepon"),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 15, 0, 10),
                                child: TextFormField(
                                  validator: (value) {},
                                  controller: _textEditingController,
                                  decoration: InputDecoration(
                                    labelText: "Telepon",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                    ),
                                  ),
                                  onTap: () async {},
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      isExpanded: _items[index].isOpen,
                    ),
                  ],
                );
              },
            ),
          ),
          Positioned(
            bottom: 0.0,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PilihKursi()),
                );
              },
              child: Container(
                height: 48,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
                child: Center(
                  child: Text(
                    "Pilih Kursi",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Item {
  bool isOpen;
  Item({this.isOpen = false});
}
