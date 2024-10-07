import 'package:download_any_file/presentation/resource_list_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter PDF Download',
      debugShowCheckedModeBanner: false,
      home: ResourcesListView(),
    );
  }
}
