import 'package:learn_api/models/user_dob.dart';
import 'package:learn_api/models/user_name.dart';
import 'package:learn_api/models/user_pic.dart';

class User {
  final String gender;
  final String email;
  final String phone;
  final String cell;
  final String nat;
  final Name name;
  final UserDOB dob;
  final UserPic picture;
  User({
    required this.gender,
    required this.email,
    required this.phone,
    required this.cell,
    required this.nat,
    required this.name,
    required this.dob,
    required this.picture,
  });

  factory User.fromMap(Map<String, dynamic> user) {
    final name = Name(
        title: user['name']['title'],
        first: user['name']['first'],
        last: user['name']['last']);
    final date = (user['dob']['date']);
    final dob =
        UserDOB(date: DateTime.parse(date), age: user['dob']['age'].toString());
    final userPicture = UserPic(
        large: user['picture']['large'],
        medium: user['picture']['medium'],
        thumbnail: user['picture']['thumbnail']);
    return User(
        gender: user['gender'],
        email: user['email'],
        phone: user['phone'],
        cell: user['cell'],
        nat: user['nat'],
        name: name,
        dob: dob,
        picture: userPicture);
  }

  String get fullName {
    return '${name.title}${name.first}${name.last}';
  }
}
