import 'package:download_any_file/data/models/resources_model.dart';
import 'package:download_any_file/presentation/widgets/resource_tile.dart';
import 'package:download_any_file/utils/check_permission.dart';
import 'package:flutter/material.dart';

class ResourcesListView extends StatefulWidget {
  const ResourcesListView({super.key});

  @override
  State<ResourcesListView> createState() => _ResourcesListViewState();
}

class _ResourcesListViewState extends State<ResourcesListView> {
  @override
  void initState() {
    super.initState();
    checkStoragePermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: dataList.length,
        itemBuilder: (BuildContext context, int index) {
          var data = dataList[index];
          return ResourceTile(
            fileUrl: data['url']!,
            title: data['title']!,
          );
        },
      ),
    );
  }
}
