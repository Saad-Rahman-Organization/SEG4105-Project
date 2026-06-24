import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  Future<PermissionStatus> checkCamera() => Permission.camera.status;

  Future<PermissionStatus> requestCamera() => Permission.camera.request();

  Future<bool> openSettings() => openAppSettings();
}

final permissionServiceProvider = Provider<PermissionService>((ref) {
  return PermissionService();
});
