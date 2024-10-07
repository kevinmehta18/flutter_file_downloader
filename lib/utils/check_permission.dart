import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> checkStoragePermission() async {
  final plugin = DeviceInfoPlugin();
  final android = await plugin.androidInfo;
  if (android.version.sdkInt < 33) {
    if (await Permission.storage.request().isGranted) {
      return true;
    } else if (await Permission.storage.request().isPermanentlyDenied) {
      await openAppSettings();
    }
  } else {
    if (await Permission.photos.request().isGranted) {
      return true;
    } else if (await Permission.photos.request().isPermanentlyDenied) {
      await openAppSettings();
    }
  }
  return false;
}
