import 'package:flutter/material.dart';
import 'each.dart';
import 'address.dart';
import 'main.dart';
import 'company.dart';
import 'package:flutter_bloc/flutter_bloc.dart ';
import 'blocs/app_bloc.dart';
import 'repository/repository.dart';
import 'blocs/app_state.dart';
import 'blocs/app_event.dart';

class CompleteDetail extends StatelessWidget {
  final int index;
  CompleteDetail(this.index);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => UserRepository(),
      child: BlocProvider(
          create: ((context) => User_bloc(
                RepositoryProvider.of<UserRepository>(context),
                true,
                index,
              )..add(Load_Event())),
          child: BlocBuilder<User_bloc, User_state>(builder: ((context, state) {
            if (state is UserSelected) {
              Model Detail = state.details;
              Map<String, String> address = {
                "street": Detail.astreet,
                "city": Detail.acity,
                "zipcode": Detail.azip
              };
              print(Detail);
              return Scaffold(
                backgroundColor: Colors.black,
                appBar: AppBar(
                  title: Container(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: const Text(
                      "TekDetail",
                      style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                  backgroundColor: Colors.black,
                ),
                body: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: [
                        Each('ID', "${Detail.id}"),
                        Each('Name', Detail.name),
                        Each('UserName', Detail.user),
                        Each('Email', Detail.email),
                        Each('Phone Number', Detail.number),
                        Each('Website', Detail.website),
                        Each("Company", Detail.company),
                        Address("Address", address),
                      ],
                    ),
                  ),
                ),
              );
            }
            if (state is UserError) {
              final String msg = state.ErrorMsg;
              return Text(msg);
            }
            return Container();
          }))),
    );
  }
}
