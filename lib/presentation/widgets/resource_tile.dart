import 'dart:io';
import 'package:dio/dio.dart';
import 'package:download_any_file/utils/directory_path.dart';
import 'package:download_any_file/presentation/widgets/download_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as Path;

class ResourceTile extends StatefulWidget {
  const ResourceTile({super.key, required this.fileUrl, required this.title});
  final String fileUrl;
  final String title;

  @override
  State<ResourceTile> createState() => _ResourceTileState();
}

class _ResourceTileState extends State<ResourceTile> {
  bool downloading = false;
  bool fileExists = false;
  double progress = 0;
  String fileName = "";
  late String filePath;
  late CancelToken cancelToken;
  var getPathFile = DirectoryPath();

  startDownload() async {
    cancelToken = CancelToken();
    var storePath = await getPathFile.getPath();
    filePath = '$storePath/$fileName';
    setState(() {
      downloading = true;
      progress = 0;
    });

    try {
      await Dio().download(widget.fileUrl, filePath,
          onReceiveProgress: (count, total) {
        setState(() {
          progress = (count / total);
        });
      }, cancelToken: cancelToken);
      setState(() {
        downloading = false;
        fileExists = true;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error downloading file')),
      );
      setState(() {
        downloading = false;
      });
    }
  }

  cancelDownload() {
    cancelToken.cancel();
    setState(() {
      downloading = false;
    });
  }

  checkFileExists() async {
    var storePath = await getPathFile.getPath();
    filePath = '$storePath/$fileName';
    bool fileExistCheck = await File(filePath).exists();
    setState(() {
      fileExists = fileExistCheck;
    });
  }

  openFile() {
    OpenFile.open(filePath);
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      fileName = Path.basename(widget.fileUrl);
    });
    checkFileExists();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        shadowColor: Colors.grey.shade200,
        child: ListTile(
          contentPadding: const EdgeInsets.all(16.0),
          title: Text(
            widget.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing: SizedBox(
            width: 50,
            height: 50,
            child: DownloadButton(
                downloading: downloading,
                progress: progress,
                onDownload: startDownload,
                onCancel: cancelDownload,
                openFile: openFile,
                fileExists: fileExists),
          ),
        ),
      ),
    );
  }
}
