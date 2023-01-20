import 'package:flutter/material.dart';

class Address extends StatelessWidget {
  final String aspect;
  final Map<String, Object> value;

  Address(this.aspect, this.value);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
      decoration: BoxDecoration(
          color: const Color.fromARGB(80, 10, 181, 161),
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: const [
            BoxShadow(color: Color.fromARGB(255, 10, 181, 161), blurRadius: 12)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$aspect",
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w900, fontSize: 15),
          ),
          Column(
            children: [
              Text(
                "${value['street']}",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.normal),
              ),
              Text(
                "${value['city']}",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.normal),
              ),
              Text(
                "${value['zipcode']}",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
