import 'package:flutter/material.dart';

enum Category {
  food(icon: Icon(Icons.lunch_dining)),
  travel(icon: Icon(Icons.flight)),
  leisure(icon: Icon(Icons.movie)),
  work(icon: Icon(Icons.work));

  final Icon icon;

  const Category({required this.icon});
}
