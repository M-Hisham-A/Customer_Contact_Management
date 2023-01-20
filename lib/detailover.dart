import 'package:flutter/material.dart';
import 'main.dart';

class Overview extends StatelessWidget {
  final Model details;
  final Function select;

  Overview(this.details, this.select);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {select(context, details.id)},
      child: Container(
          decoration: BoxDecoration(
              color: const Color.fromARGB(80, 10, 181, 161),
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: const [
                BoxShadow(
                    color: Color.fromARGB(255, 10, 181, 161), blurRadius: 8)
              ]),
          padding: const EdgeInsets.fromLTRB(10, 20, 20, 30),
          margin: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          width: double.infinity,
          child: Row(
            children: [
              Container(
                height: 90,
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Image.network(
                    "https://images.squarespace-cdn.com/content/v1/602608c3ee61023a4aafd9ae/1613108613475-8NZKUOTPUDZWHL7HTQK6/Bitmoji.png"),
              ),
              Container(
                  child: Row(
                children: [
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${details.name}",
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          "${details.email}",
                          style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )),
            ],
          )),
    );
  }
}
