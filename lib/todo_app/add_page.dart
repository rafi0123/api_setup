import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  final Map? todo;
  const AddPage({super.key, this.todo});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  bool isEdit = false;

  @override
  void initState() {
    if (widget.todo != null) {
      isEdit = true;
      final todo = widget.todo;
      final title = todo!['title'];
      final description = todo['description'];
      titleController.text = title;
      descController.text = description;
    }
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Edit Todo' : 'Add Todo')),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text('Title'),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                    hintText: 'Title',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.black87)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.black87))),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('Description'),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: descController,
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                    hintText: 'Description',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.black87)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.black87))),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      getFormData();
                    },
                    child: Text(isEdit ? 'Update' : 'Submit')),
              ),
            ],
          ),
        ),
      )),
    );
  }

  Future<void> getFormData() async {
    // get data from the form
    final body = {
      "title": titleController.text,
      "description": descController.text,
      "is_completed": false,
    };
    // submit data to server
    final response = await http.post(
      Uri.parse('https://api.nstack.in/v1/todos'),
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );

    // print(response.statusCode);
    // print(response.body);

    if (response.statusCode == 201) {
      titleController.clear();
      descController.clear();
      debugPrint('Success');
      showSuccessSnackBar('Successfully Submited');
    } else {
      debugPrint('Error');
      showErrorSnackBar('Error');
    }
  }

  showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: Colors.red, content: Text(message)));
  }
}
