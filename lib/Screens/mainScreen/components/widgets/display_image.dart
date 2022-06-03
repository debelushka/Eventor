import 'dart:io';

import 'package:eventor_two/constants.dart';
import 'package:flutter/material.dart';

class DisplayImage extends StatelessWidget {
  final String imagePath;

  const DisplayImage({
    Key? key,
    required this.imagePath,
    // required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = kPrimaryColor;
    return Center(
        child: Stack(children: [
      buildImage(color),
      Positioned(
        child: buildEditIcon(color),
        right: 4,
        bottom: 10,
      )
    ]));
  }

  Widget buildImage(Color color) {
    final image = imagePath.contains('https://')
        ? NetworkImage(imagePath)
        : FileImage(File(imagePath));

    return CircleAvatar(
      radius: 75,
      backgroundColor: color,
      child: CircleAvatar(
        backgroundImage: image as ImageProvider,
        radius: 70,
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
      all: 8,
      child: Icon(
        Icons.edit,
        color: color,
        size: 20,
      ));

  Widget buildCircle({
    required Widget child,
    required double all,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: Colors.white,
          child: child,
        ),
      );
}
