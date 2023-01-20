import 'dart:ui';

import 'package:detailmanagement/blocs/app_bloc.dart';
import 'package:detailmanagement/blocs/app_event.dart';
import 'package:detailmanagement/blocs/app_state.dart';
import 'package:detailmanagement/detailover.dart';
import 'package:detailmanagement/repository/repository.dart';

import 'package:flutter/material.dart';
import 'complete.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart';
import 'package:flutter_bloc/flutter_bloc.dart ';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  State<MyApp> createState() => MyAppState();
}

class Model {
  late int id;
  late String name;
  late String user;
  late String email;
  late String number;
  late String website;
  late String company;
  late String astreet;
  late String acity;
  late String azip;

  Model(this.id, this.name, this.user, this.email, this.number, this.website,
      this.company, this.astreet, this.acity, this.azip);

  factory Model.fromjson(Map<String, dynamic> json) {
    return Model(
        json['id'],
        json['name'],
        json['username'],
        json['email'],
        json['phone'],
        json['website'],
        json['company']['name'],
        json['address']['street'],
        json['address']['city'],
        json['address']['zipcode']);
  }
}

class MyAppState extends State<MyApp> {
  late List<Model> details;
  late List<Model> sDetail = [];
  late String search = "";
  void Display(BuildContext context, int index) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return CompleteDetail(index);
    }));
  }

  void searchF(String val) {
    setState(() {
      search = val;
    });
  }

  String Intial = "Id";
  List<String> Items = ["Id", "Name", "Email", "Company"];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RepositoryProvider(
        create: (context) => UserRepository(),
        child: BlocProvider(
          create: ((context) => User_bloc(
                RepositoryProvider.of<UserRepository>(context),
                false,
                0,
              )..add(Load_Event())),
          child: Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              toolbarHeight: 70,
              title: Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Tek Detail",
                        style: TextStyle(
                            fontFamily: 'sans sheriff',
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 10, 181, 161)),
                      ),
                      DropdownButton(
                          value: Intial,
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Color.fromARGB(255, 10, 181, 161),
                          ),
                          items: Items.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(
                                items,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 10, 181, 161),
                                  fontSize: 16,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              Intial = newValue!;
                            });
                          })
                    ]),
              ),
              backgroundColor: Colors.black,
            ),
            body: BlocBuilder<User_bloc, User_state>(
              builder: ((context, state) {
                if (state is UserLoad) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 10, 181, 161),
                    ),
                  );
                }

                if (state is UserLoaded) {
                  details = state.details;
                  sDetail = [];
                  for (int i = 0; i < details.length; i++) {
                    String s1, s2;
                    s1 = search.toLowerCase();
                    s2 = details[i].name.toLowerCase();

                    if (s2.contains(s1)) {
                      sDetail.add(details[i]);
                    }
                  }
                  switch (Intial) {
                    case "Name":
                      sDetail.sort(((a, b) => (a.name).compareTo(b.name)));
                      break;
                    case "Id":
                      sDetail.sort(((a, b) => (a.id).compareTo(b.id)));
                      break;
                    case "Email":
                      sDetail.sort(((a, b) => (a.email).compareTo(b.email)));
                      break;
                    case "Company":
                      sDetail
                          .sort(((a, b) => (a.company).compareTo(b.company)));
                      break;
                  }

                  return Container(
                    height: MediaQuery.of(context).size.height,
                    color: Colors.black,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height: 70,
                            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                            child: Card(
                              color: Colors.black,
                              child: TextField(
                                style: TextStyle(
                                  color: Color.fromARGB(255, 10, 181, 161),
                                ),
                                cursorColor: Color.fromARGB(255, 10, 181, 161),
                                onChanged: searchF,
                                decoration: InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 10, 181, 161),
                                      ),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 10, 181, 161),
                                      ),
                                    ),
                                    labelText: "Search... ",
                                    labelStyle: TextStyle(
                                      color: Color.fromARGB(255, 10, 181, 161),
                                    ),
                                    contentPadding:
                                        EdgeInsets.fromLTRB(10, 5, 10, 10)),
                              ),
                            ),
                          ),
                          ...sDetail
                              .map((e) => Overview(
                                  Model(
                                      e.id,
                                      e.name,
                                      e.user,
                                      e.email,
                                      e.number,
                                      e.website,
                                      e.company,
                                      e.astreet,
                                      e.acity,
                                      e.azip),
                                  Display))
                              .toList(),
                          Center(
                              child: sDetail.isEmpty
                                  ? Text(
                                      "No Match Found !!",
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 10, 181, 161),
                                        fontSize: 18,
                                      ),
                                    )
                                  : Text(""))
                        ],
                      ),
                    ),
                  );
                }
                if (state is UserError) {
                  String msg = state.ErrorMsg;
                  return Text(msg);
                }
                return Container();
              }),
            ),
          ),
        ),
      ),
    );
  }
}
