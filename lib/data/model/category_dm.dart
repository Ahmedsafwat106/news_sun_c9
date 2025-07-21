import 'package:flutter/material.dart';

class CategoryDM {
  final String id;
  final String title;
  final String imagePath;
  final Color backgroundColor;
  final bool isLeftSided;

  CategoryDM({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.backgroundColor,
    required this.isLeftSided,
  });
}

List<CategoryDM> categories = [
  CategoryDM(
    id: "sports",
    title: "Sports",
    imagePath: "assets/sports.jpg",
    isLeftSided: true,
    backgroundColor: Colors.red,
  ),
  CategoryDM(
    id: "politics",
    title: "Politics",
    imagePath: "assets/politics.jpg",
    isLeftSided: false,
    backgroundColor: Colors.blue,
  ),
  CategoryDM(
    id: "health",
    title: "Health",
    imagePath: "assets/health.jpg",
    isLeftSided: true,
    backgroundColor: Colors.pink,
  ),
  CategoryDM(
    id: "business",
    title: "Business",
    imagePath: "assets/business.jpg",
    isLeftSided: false,
    backgroundColor: Colors.orange.shade900,
  ),
  CategoryDM(
    id: "environment",
    title: "Environment",
    imagePath: "assets/environment.jpg",
    isLeftSided: true,
    backgroundColor: Colors.lightBlue,
  ),
  CategoryDM(
    id: "science",
    title: "Science",
    imagePath: "assets/science.jpg",
    isLeftSided: false,
    backgroundColor: Colors.yellow.shade500,
  ),
];
