import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:learn_api/todo_app/add_page.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  List usersList = [];
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Todo List'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: fetchData,
        child: SafeArea(
            child: Column(
          children: [
            Visibility(
              visible: !isLoading,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: ListView.builder(
                  itemCount: usersList.length,
                  shrinkWrap: true,
                  // physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (ctx, i) {
                    final id = usersList[i]['_id'] as String;
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text('$i'),
                      ),
                      title: Text(usersList[i]['title'].toString()),
                      subtitle: Text(usersList[i]['description'].toString()),
                      trailing: PopupMenuButton(onSelected: (value) {
                        if (value == 'edit') {
                          //open Edit page
                          
                        } else if (value == 'delete') {
                          // Delete and remove
                          deleteById(id);
                        }
                      }, itemBuilder: (context) {
                        return const [
                          PopupMenuItem(
                            child: Text('Edit'),
                            value: 'edit',
                          ),
                          PopupMenuItem(
                            child: Text('Delete'),
                            value: 'delete',
                          ),
                        ];
                      }),
                    );
                  }),
            )
          ],
        )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddPage()));
          // navigateToAddPage();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> navigateToAddPage( Map item) async {
    final route = MaterialPageRoute(builder: ((context) => AddPage(todo: item)));
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchData();
  }

  Future<void> deleteById(String id) async {
    // delete the item
    final url = 'https://api.nstack.in/v1/todos/$id';
    final response = await http.delete(Uri.parse(url));

    if (response.statusCode == 200) {
      final filtered =
          usersList.where((element) => element['_id'] != id).toList();
      setState(() {
        usersList = filtered;
      });
      // remove the item from the list
    } else {
      // Error
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Deletion Failed')));
    }
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });
    final response = await http
        .get(Uri.parse('https://api.nstack.in/v1/todos?page=1&limit=10'));
    final data = jsonDecode(response.body) as Map;
    if (response.statusCode == 200) {
      debugPrint('Successfully Fetched Data');
      final result = data['items'] as List;
      setState(() {
        usersList = result;
      });
    } else {
      debugPrint('Error while Fetching data');
    }
    setState(() {
      isLoading = false;
    });
  }
}
