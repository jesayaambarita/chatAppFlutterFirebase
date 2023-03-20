import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});
  //reference for our collection
  final CollectionReference chatCollection =
      FirebaseFirestore.instance.collection("chats");
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  //get the data
  getUserGroups() async {
    return userCollection.doc(uid).snapshots();
  }

  Future createGroup(String nama, String id, String groupName) async {
    DocumentReference groupDocumentReference = await chatCollection.add({
      "groupName": groupName,
      "groupIcon": "",
      "admin": "${uid}_$nama",
      "members": [],
      "groupId": "",
      "recentMessage": "",
      "recentMessageSender": "",
    });
    //update the members
    await groupDocumentReference.update({
      "members": FieldValue.arrayUnion(["${uid}_$nama"]),
      "groupId": groupDocumentReference.id,
    });

    DocumentReference userDocumentReference = await userCollection.doc(uid);
    return await userDocumentReference.update({
      "chats":
          FieldValue.arrayUnion(["${groupDocumentReference.id}_$groupName"])
    });
  }

  //getting the chats
  getChats(String groupId) async {
    return chatCollection
        .doc(groupId)
        .collection("messages")
        .orderBy("time")
        .snapshots();
  }

  Future getUser() async {
    DocumentReference r = userCollection.doc(uid);
    DocumentSnapshot document = await r.get();
    return document['nama'];
  }

  Future getEmail() async {
    DocumentReference r = userCollection.doc(uid);
    DocumentSnapshot document = await r.get();
    return document['email'];
  }

  Future getTanggal() async {
    DocumentReference r = userCollection.doc(uid);
    DocumentSnapshot document = await r.get();
    return document['tanggal'];
  }

  Future getGroupAdmin(String groupId) async {
    DocumentReference d = chatCollection.doc(groupId);
    DocumentSnapshot documentSnapshot = await d.get();
    return documentSnapshot['admin'];
  }

  getGroupMembers(String groupId) async {
    return chatCollection.doc(groupId).snapshots();
  }

  searchByName(String groupName) {
    return chatCollection.where("groupName", isEqualTo: groupName).get();
  }

  //function -> bool
  Future<bool> isUserJoined(
      String groupName, String userName, String groupId) async {
    DocumentReference userDocumentReferences = userCollection.doc(uid);
    DocumentSnapshot documentSnapshot = await userDocumentReferences.get();
    List<dynamic> groups = await documentSnapshot['chats'];
    if (groups.contains("${groupId}_$groupName")) {
      return true;
    } else {
      return false;
    }
  }

  //toggling the group join/exit
  Future toogleGroupJoin(
      String groupId, String userName, String groupName) async {
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentReference groupDocumentReference = chatCollection.doc(groupId);

    DocumentSnapshot documentSnapshot = await userDocumentReference.get();
    List<dynamic> groups = await documentSnapshot['chats'];
    //if user has our groups
    if (groups.contains("${groupId}_$groupName")) {
      await userDocumentReference.update({
        "chats": FieldValue.arrayRemove(["${groupId}_$groupName"])
      });
      await groupDocumentReference.update({
        "members": FieldValue.arrayRemove(["${uid}_$userName"])
      });
    } else {
      await userDocumentReference.update({
        "chats": FieldValue.arrayUnion(["${groupId}_$groupName"])
      });
      await groupDocumentReference.update({
        "members": FieldValue.arrayUnion(["${uid}_$userName"])
      });
    }
  }

  //SEND Message

  sendMessage(String groupId, Map<String, dynamic> chatMessageData) async {
    chatCollection.doc(groupId).collection("messages").add(chatMessageData);
    chatCollection.doc(groupId).update({
      "recentMessage": chatMessageData['message'],
      "recentMessageSender": chatMessageData['sender'],
      "recentMessageTime": chatMessageData['time'].toString(),
    });
  }
}
