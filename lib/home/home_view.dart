import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/users_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Photos> userList = [];
  Future<List<Photos>> getUser() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    var data = jsonDecode(response.body);
    print(data);

    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        userList.add(Photos.fromJson(i));
      }
      return userList;
    } else {
      return userList;
    }
  }

  // @override
  // void initState() {
  //   getUser();
  //   super.initState();
  // }

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
                          itemCount: userList.length,
                          itemBuilder: (ctx, i) {
                            return ListTile(
                              title: Text(
                                userList[i].title.toString(),
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              subtitle: Text(userList[i].body.toString()),
                            );
                          });
                    }
                  }),
            ),
          ]),
        ));
  }
}
