import 'package:flutter/material.dart';

class DownloadButton extends StatelessWidget {
  final bool downloading;
  final double progress;
  final VoidCallback onDownload;
  final VoidCallback onCancel;
  final VoidCallback openFile;
  final bool fileExists;

  const DownloadButton({
    Key? key,
    required this.downloading,
    required this.progress,
    required this.onDownload,
    required this.onCancel,
    required this.openFile,
    required this.fileExists,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: downloading ? onCancel : onDownload,
      child: downloading ? cancelButton() : openDownloadButton(),
    );
  }

  openDownloadButton() {
    return IconButton(
      icon: fileExists
          ? const Icon(Icons.folder_open, color: Colors.green)
          : const Icon(Icons.download),
      onPressed: () {
        fileExists ? openFile() : onDownload();
      },
    );
  }

  cancelButton() {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircularProgressIndicator(
          value: progress,
          strokeWidth: 3,
          backgroundColor: Colors.grey.shade300,
          valueColor: const AlwaysStoppedAnimation<Color>(
            Colors.blue,
          ),
        ),
        IconButton(
          onPressed: onCancel,
          icon: const Icon(Icons.close, color: Colors.red),
        ),
      ],
    );
  }
}
