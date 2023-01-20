import 'package:flutter/material.dart';

class Each extends StatelessWidget {
  final String aspect;
  final String value;

  Each(this.aspect, this.value);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
      decoration: BoxDecoration(
          color: const Color.fromARGB(80, 10, 181, 161),
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: const [
            BoxShadow(color: Color.fromARGB(255, 10, 181, 161), blurRadius: 8)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$aspect",
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 15)),
          Text(
            "$value",
            style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.normal),
          )
        ],
      ),
    );
  }
}
