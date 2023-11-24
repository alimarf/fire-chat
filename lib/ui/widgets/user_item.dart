import 'package:fire_chat/ui/pages/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../model/user.dart';

class UserItem extends StatefulWidget {
  const UserItem({super.key, required this.user});

  final UserModel user;

  @override
  State<UserItem> createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => ChatPage(userId: widget.user.uid))),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(widget.user.image),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: CircleAvatar(
                  backgroundColor:
                      widget.user.isOnline ? Colors.green : Colors.grey,
                  radius: 8,
                ),
              ),
            ],
          ),
          title: Text(
            widget.user.name,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            'Last seen ${timeago.format(widget.user.lastActive)}',
            maxLines: 2,
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 12,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      );
}
