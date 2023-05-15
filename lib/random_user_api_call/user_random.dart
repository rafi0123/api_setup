import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:learn_api/models/user.dart';
import 'package:learn_api/services/user_api.dart';

class UserRandom extends StatefulWidget {
  const UserRandom({super.key});

  @override
  State<UserRandom> createState() => _UserRandomState();
}

class _UserRandomState extends State<UserRandom> {
  List<User> usersList = [];
  Future<void> fetchUser() async {
    final response = await UserAPI.randomUser();
    setState(() {
      usersList = response;
    });
  }

  @override
  void initState() {
    fetchUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Services'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
                itemCount: usersList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (ctx, i) {
                  final dateTime =
                      DateTime.parse(usersList[i].dob.date.toString());
                  final formate = DateFormat('d MMMM yyyy');
                  final formatedDOB = formate.format(dateTime);
                  return ListTile(
                    subtitle: Text(usersList[i].email),
                    title: Text(usersList[i].fullName),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(usersList[i].picture.large),
                    ),
                    trailing: Text(formatedDOB),
                  );
                })
          ],
        ),
      )),
    );
  }
}
