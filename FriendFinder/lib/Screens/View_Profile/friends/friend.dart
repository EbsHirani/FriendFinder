import 'dart:convert';
import 'package:meta/meta.dart';

class Friend {
  Friend({
    @required this.avatar,
    @required this.name,
    @required this.email,
    @required this.location,
    @required this.friendsCount,
    @required this.desc
  });

  final String avatar;
  final String name;
  final String email;
  final String location;
  final int friendsCount;
  final String desc;

  List<String> likings = [
    "absd",
      "afasd",
      "adjkfa",
  ];
  void fromMap(Map map) {
    likings = [
      "absd",
      "afasd",
      "adjkfa",
    ];
  }
  }

  // Friend fromMap(Map map) {
  //   likings = 
  // }

  String _capitalize(String input) {
    return input.substring(0, 1).toUpperCase() + input.substring(1);
  }

