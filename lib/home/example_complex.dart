import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:learn_api/models/user_complex_model.dart';

class ExampleComplex extends StatefulWidget {
  const ExampleComplex({super.key});

  @override
  State<ExampleComplex> createState() => _ExampleComplexState();
}

class _ExampleComplexState extends State<ExampleComplex> {
  List<ComplexUserModel> complexList = [];
  Future<List<ComplexUserModel>> getUser() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        complexList.add(ComplexUserModel.fromJson(i));
      }
      return complexList;
    } else {
      return complexList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Api Learning'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(children: [
            Expanded(
              child: FutureBuilder(
                  future: getUser(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView.builder(
                          itemCount: complexList.length,
                          itemBuilder: (ctx, i) {
                            return ListTile(
                              title: Text(
                                  // complexList[i].address!.city.toString(),
                                  snapshot.data![i].address!.geo!.lat
                                      .toString()),
                            );
                          });
                    }
                  }),
            ),
          ]),
        ));
  }
}
