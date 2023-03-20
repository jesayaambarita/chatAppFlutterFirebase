import 'package:flutter/material.dart';
import 'package:projek_pertama/pages/chat_page.dart';
import 'package:projek_pertama/provider/constant.dart';

class GroupTile extends StatefulWidget {
  final String userName;
  final String groupName;
  final String groupId;
  const GroupTile(
      {super.key,
      required this.userName,
      required this.groupName,
      required this.groupId});

  @override
  State<GroupTile> createState() => _GroupTileState();
}

class _GroupTileState extends State<GroupTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return ChatPage(
              userName: widget.userName,
              groupName: widget.groupName,
              groupId: widget.groupId);
        }));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.orange,
            child: Text(
              widget.groupName.substring(0, 1).toUpperCase(),
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
            ),
          ),
          title: Text(
            widget.groupName,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            "Gabung Percakapan ${widget.userName}",
            style: TextStyle(fontSize: 13),
          ),
        ),
      ),
    );
  }
}
