import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.name,
    required this.email,
  });

  final String name, email;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        maxRadius: 22,
        backgroundColor: Colors.white,
        child: Icon(
          CupertinoIcons.person,
          color: Colors.black,
          size: 28,
        ),
      ),
      title: Text(
        name,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      subtitle: Text(email,
          style: const TextStyle(
            color: Colors.white,
          )),
    );
  }
}
