import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Example1 extends StatefulWidget {
  const Example1({super.key});

  @override
  State<Example1> createState() => _Example1State();
}

class _Example1State extends State<Example1> {
  List<Photos> photoList = [];
  Future<List<Photos>> getUser() async {
    final response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        Photos photos = Photos(title: i['title'], url: i['url']);
        photoList.add(photos);
      }
      return photoList;
    } else {
      return photoList;
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
                          itemCount: photoList.length,
                          itemBuilder: (ctx, i) {
                            return ListTile(
                              leading: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(photoList[i].url)),
                              title: Text(photoList[i].title),
                            );
                          });
                    }
                  }),
            ),
          ]),
        ));
  }
}

class Photos {
  final String title;
  final String url;

  Photos({required this.title, required this.url});
}
