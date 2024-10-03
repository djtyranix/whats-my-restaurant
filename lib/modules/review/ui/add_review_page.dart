import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddReviewPage extends StatefulWidget {
  static const routeName = '/add_review';

  final String id;

  const AddReviewPage({super.key, required this.id});

  @override
  State<AddReviewPage> createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Add Review"
        ),
      ),
    );
  }
}