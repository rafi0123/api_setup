import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleWithOutModel extends StatefulWidget {
  const ExampleWithOutModel({super.key});

  @override
  State<ExampleWithOutModel> createState() => _ExampleWithOutModelState();
}

class _ExampleWithOutModelState extends State<ExampleWithOutModel> {
  var data;
  Future<void> getUser() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    data = jsonDecode(response.body);

    if (response.statusCode == 200) {
     
    } else {
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
                          itemCount: data.length,
                          itemBuilder: (ctx, i) {
                            return ListTile(
                              title: Text(data[0]['name'].toString()),
                              subtitle: Text(data[0]['address']['city']),
                              trailing: Text(data[0]['address']['geo']['lng']),
                            );
                          });
                    }
                  }),
            ),
          ]),
        ));
  }
}
