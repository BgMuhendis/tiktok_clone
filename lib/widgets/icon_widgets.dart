 import 'package:flutter/material.dart';
import 'package:tiktok/theme/color.dart';

Widget getAlbum(albumImg) {
    return Container(
      width: 55,
      height: 55,
      child: Stack(
        children: [
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: black,
            ),
          ),
          Center(
            child: Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(albumImg), fit: BoxFit.cover)),
            ),
          )
        ],
      ),
    );
  }
   Widget getIcon(icon, size, count) {
    return Column(
      children: [
        Icon(
          icon,
          size: size,
          color: white,
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          count,
          style: TextStyle(color: white, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
Widget getProfile(profileImg) {
    return Container(
      width: 55,
      height: 60,
      child: Stack(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                border: Border.all(color: white),
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(profileImg),
                  fit: BoxFit.cover,
                )),
          ),
          Positioned(
            left: 18,
            bottom: -5,
            child: Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(shape: BoxShape.circle, color: primary),
              child: Center(
                child: Icon(
                  Icons.add,
                  color: white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }