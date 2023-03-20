import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projek_pertama/helper/database_service.dart';
import 'package:projek_pertama/pages/group_info.dart';
import 'package:projek_pertama/widget/message_tile.dart';

class ChatPage extends StatefulWidget {
  final String groupId;
  final String groupName;
  final String userName;
  const ChatPage(
      {super.key,
      required this.userName,
      required this.groupName,
      required this.groupId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Stream<QuerySnapshot>? chats;
  bool _isLoading = false;
  String admin = "";
  TextEditingController messageController = TextEditingController();
  File? _image;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getChatandAdmin();
  }

  void kirim() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  getChatandAdmin() {
    DatabaseService().getChats(widget.groupId).then((val) {
      setState(() {
        chats = val;
      });
    });
    DatabaseService().getGroupAdmin(widget.groupId).then((value) {
      setState(() {
        admin = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.camera_alt_outlined,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return GroupInfo(
                        adminName: admin,
                        groupName: widget.groupName,
                        groupId: widget.groupId);
                  },
                ),
              );
            },
            icon: Icon(Icons.info_outline),
          )
        ],
        title: Text(widget.groupName),
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
        children: <Widget>[
          chatMessages(),
          Container(
            alignment: Alignment.bottomCenter,
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[500],
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      controller: messageController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Kirim Pesan...",
                        hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  IconButton(
                    onPressed: () async {
                      kirim();
                      _image != null
                          ? showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return StatefulBuilder(
                                    builder: ((context, setState) {
                                  return AlertDialog(
                                    title: const Text(
                                      "Upload Gambar",
                                      textAlign: TextAlign.center,
                                    ),
                                    content: Image.file(
                                      _image!,
                                      fit: BoxFit.fill,
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
                                          ambil();
                                        },
                                        icon: Icon(
                                          Icons.check_outlined,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ],
                                  );
                                }));
                              })
                          : Center(
                              child: Icon(
                                Icons.camera_alt_outlined,
                                size: 50,
                                color: Colors.grey,
                              ),
                            );
                    },
                    icon: Icon(
                      Icons.add_link_rounded,
                      color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      sendMessage();
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.orange.shade600,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.send_outlined,
                          size: 20,
                          color: Colors.white,
                        ),
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

  chatMessages() {
    return StreamBuilder(
      stream: chats,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? Container(
                // decoration: BoxDecoration(
                //   image: DecorationImage(
                //       image: NetworkImage(
                //           "https://img.freepik.com/premium-vector/hand-drawn-comic-book-speech-bubble-speak-calling-callout-seamless-pattern-background_8580-927.jpg?w=740"),
                //       fit: BoxFit.cover),
                // ),
                margin: EdgeInsets.only(bottom: 60),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return MessageTile(
                        message: snapshot.data.docs[index]['message'],
                        sender: snapshot.data.docs[index]['sender'],
                        time: snapshot.data.docs[index]['time'].toString(),
                        sentByMe: widget.userName ==
                            snapshot.data.docs[index]['sender']);
                  },
                  itemCount: snapshot.data.docs.length,
                ),
              )
            : Center(
                child: Container(
                    // child: Image.network(
                    //     "https://o.remove.bg/downloads/30d0be27-b8a4-419b-a28c-1040fe2e9a5a/gambar-removebg-preview.png"),
                    ),
              );
      },
    );
  }

  ambil() async {
    final Reference storageRef =
        FirebaseStorage.instance.ref().child('images/${DateTime.now()}');

    // Mengupload gambar ke Firebase Storage
    final UploadTask uploadTask = storageRef.putFile(_image!);
    await uploadTask.whenComplete(() => null);

    // Mendapatkan URL dari gambar yang diupload
    final String imageUrl = await storageRef.getDownloadURL();
    Map<String, dynamic> imageUpload = {
      "sender": widget.userName,
      "time": DateTime.now().millisecondsSinceEpoch,
      "image": imageUrl,
    };
    DatabaseService().sendMessage(widget.groupId, imageUpload);
    setState(() {
      messageController.clear();
    });
  }

  sendMessage() async {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "message": messageController.text,
        "sender": widget.userName,
        "time": DateTime.now().millisecondsSinceEpoch,
      };
      DatabaseService().sendMessage(widget.groupId, chatMessageMap);
      setState(() {
        messageController.clear();
      });
    }
  }
}
