import 'package:flutter/material.dart';

Widget appBar(context, String headingAppbar) {
  return Padding(
    padding: const EdgeInsets.only(top: 8.0),
    child: Row(
      children: [
        Container(
          height: 55,
          width: 55,
          margin: EdgeInsets.only(left: 20),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade600,
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              context == null ? Icons.lock_rounded : Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 20),
        Text(
          headingAppbar,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 36,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}
