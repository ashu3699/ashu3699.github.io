import 'package:flutter/material.dart';

class Project {
  final String title;
  final String description;
  final String imageUrl;
  final Widget appWidget;
  final String route;

  Project({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.appWidget,
    required this.route,
  });
}
