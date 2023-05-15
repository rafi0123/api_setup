import 'package:flutter/material.dart';
import 'package:learn_api/services/user_api.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  List<dynamic> userList = [];
  Future<void> fetchUser() async {
    var response = await UserAPI.getUser();
    userList = response['results'];
    debugPrint('Is it Working or NOt' + response.toString());
  }

  // @override
  // void initState() {
  //   fetchUser();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          FutureBuilder(
              future: fetchUser(),
              builder: ((context, snapshot) {
                return ListView.builder(
                    itemCount: userList.length,
                    shrinkWrap: true,
                    itemBuilder: (ctx, i) {
                      return ListTile(
                        title: Text(userList[i]['gender']),
                        leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(userList[i]['picture']['large'])),
                      );
                    });
              })),
        ],
      )),
    );
  }
}
