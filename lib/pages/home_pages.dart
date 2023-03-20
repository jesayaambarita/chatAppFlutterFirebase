import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projek_pertama/helper/SignUpHelper.dart';
import 'package:projek_pertama/helper/database_service.dart';
import 'package:projek_pertama/helper/helper_function.dart';
import 'package:projek_pertama/pages/search_page.dart';
import 'package:projek_pertama/widget/group_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String nama = "";
  String email = "";
  Stream? chat;
  bool _isLoading = false;
  String groupName = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gettingUserData();
  }

  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  String getName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  String getMessage(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  gettingUserData() async {
    await HelperFunction.getUserNameFromSF().then(
      (value) {
        setState(() {
          nama = value!;
        });
      },
    );
    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getUserGroups()
        .then((value) {
      setState(() {
        chat = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () {
          popUpDialog(context);
        },
        child: FloatingActionButton(
          onPressed: () {
            popUpDialog(context);
          },
          elevation: 0,
          backgroundColor: Colors.orange,
          child: Icon(Icons.add),
        ),
      ),
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(Icons.search),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return SearchPage();
                },
              ),
            );
          },
        ),
        centerTitle: true,
        title: Text("Chatting"),
        elevation: 0,
        backgroundColor: Colors.orangeAccent,
        actions: <Widget>[
          // SizedBox(
          //   height: 20,
          //   width: 20,
          //   child: Container(
          //     decoration: BoxDecoration(
          //       image: DecorationImage(
          //         image: NetworkImage(
          //             'https://img.okezone.com/content/2020/10/05/408/2288632/menikmati-keindahan-danau-toba-dari-3-bukit-ini-sangat-menakjubkan-FyS99UvKQf.jpg'),
          //         fit: BoxFit.cover,
          //       ),
          //       borderRadius: BorderRadius.all(
          //         Radius.circular(20),
          //       ),
          //     ),
          //   ),
          // ),
          Icon(Icons.person_2_outlined),
          SizedBox(
            width: 13,
          ),
        ],
      ),
      body: groupList(),
    );
  }

  popUpDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: ((context, setState) {
            return AlertDialog(
              title: const Text(
                "Buat group",
                textAlign: TextAlign.center,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _isLoading == true
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.orange,
                          ),
                        )
                      : TextField(
                          onChanged: (val) {
                            setState(() {
                              groupName = val;
                            });
                          },
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        )
                ],
              ),
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.cancel_outlined,
                    color: Colors.red,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    if (groupName != "") {
                      setState(() {
                        _isLoading = true;
                      });
                      DatabaseService(
                              uid: FirebaseAuth.instance.currentUser!.uid)
                          .createGroup(nama,
                              FirebaseAuth.instance.currentUser!.uid, groupName)
                          .whenComplete(
                        () {
                          _isLoading = false;
                        },
                      );
                      Navigator.of(context).pop();
                    }
                  },
                  icon: Icon(
                    Icons.check_outlined,
                    color: Colors.green,
                  ),
                ),
              ],
            );
          }));
        });
  }

  groupList() {
    return StreamBuilder(
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data['chats'] != null) {
            if (snapshot.data['chats'].length != 0) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  int reverseIndex = snapshot.data['chats'].length - index - 1;
                  return GroupTile(
                    userName: snapshot.data['nama'],
                    groupName: getName(snapshot.data['chats'][reverseIndex]),
                    groupId: getId(snapshot.data['chats'][reverseIndex]),
                  );
                },
                itemCount: snapshot.data['chats'].length,
              );
            } else {
              return noChatWidget();
            }
          } else {
            return noChatWidget();
          }
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.orange,
            ),
          );
        }
      },
      stream: chat,
    );
  }

  noChatWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              popUpDialog(context);
            },
            child: Icon(
              Icons.add_circle,
              color: Colors.grey,
              size: 75,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Kamu belum punya percakapan, Tekan untuk mencari user yang terdaftar",
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
