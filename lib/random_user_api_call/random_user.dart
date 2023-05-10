import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../services/utility/app_url.dart';

class RandomUser extends StatefulWidget {
  const RandomUser({super.key});

  @override
  State<RandomUser> createState() => _RandomUserState();
}

class _RandomUserState extends State<RandomUser> {
  List<dynamic> users = [];
  Future<void> getRandomUser() async {
    print('Responding...');
    final response = await http.get(Uri.parse(AppUrl.randomBaseUrl));
    final data = jsonDecode(response.body);

    setState(() {
      users = data['results'];
    });
    print('Completed');
  }

  @override
  void initState() {
    getRandomUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
                itemCount: users.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (ctx, i) {
                  // String dateTime = DateTime.now().year.toString() +
                  //     DateTime.now().month.toString() +
                  //     DateTime.now().day.toString();

                  final dateTime =
                      DateTime.parse(users[i]['dob']['date'].toString());
                  final formate = DateFormat('d MMMM yyyy');
                  final formattedDOB = formate.format(dateTime);

                  return ListTile(
                    leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(users[i]['picture']['large'])),
                    title: Text(users[i]['name']['title'] +
                        " " +
                        users[i]['name']['first'] +
                        " " +
                        users[i]['name']['last']),
                    subtitle: Text(formattedDOB),
                    trailing: Text(users[i]['dob']['age'].toString()),
                  );
                })
          ],
        ),
      )),
    );
  }
}
