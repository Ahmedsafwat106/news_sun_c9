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
    backgroundColor: Color(0xFFEF5350), // Red-ish
  ),
  CategoryDM(
    id: "politics",
    title: "Politics",
    imagePath: "assets/politics.jpg",
    isLeftSided: false,
    backgroundColor: Color(0xFF1565C0), // Main blue
  ),
  CategoryDM(
    id: "health",
    title: "Health",
    imagePath: "assets/health.jpg",
    isLeftSided: true,
    backgroundColor: Color(0xFF66BB6A), // Green
  ),
  CategoryDM(
    id: "business",
    title: "Business",
    imagePath: "assets/business.jpg",
    isLeftSided: false,
    backgroundColor: Color(0xFFFFA726), // Orange
  ),
  CategoryDM(
    id: "environment",
    title: "Environment",
    imagePath: "assets/environment.jpg",
    isLeftSided: true,
    backgroundColor: Color(0xFF26C6DA), // Cyan
  ),
  CategoryDM(
    id: "science",
    title: "Science",
    imagePath: "assets/science.jpg",
    isLeftSided: false,
    backgroundColor: Color(0xFFFFEB3B), // Yellow
  ),
];
