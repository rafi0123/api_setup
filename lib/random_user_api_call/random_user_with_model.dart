import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:learn_api/services/utility/app_url.dart';

class RandomUserWithNameModel extends StatefulWidget {
  const RandomUserWithNameModel({super.key});

  @override
  State<RandomUserWithNameModel> createState() =>
      _RandomUserWithNameModelState();
}

class _RandomUserWithNameModelState extends State<RandomUserWithNameModel> {
  var data;
  Future<void> getUser() async {
    final response = await http.get(Uri.parse(AppUrl.randomBaseUrl));

    if (response.statusCode == 200) {
      print('Successfully');
      data = jsonDecode(response.body.toString());
    } else {
      print('Error white fetching api');
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
          child: SingleChildScrollView(
            child: Column(children: [
              FutureBuilder(
                  future: getUser(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView.builder(
                          itemCount: data.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (ctx, i) {
                            print(data);
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    data['results'][i]['picture']['large']),
                              ),
                              title:
                                  Text(data['results'][i]['gender'].toString()),
                            );
                          });
                    }
                  })
            ]),
          ),
        ));
  }
}
