import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

import '../../../core/data/preferences_repository.dart';
import '../../../core/data/profile_repository.dart';
import '../../../core/models/app_preferences.dart';
import '../../../core/models/meal_models.dart';
import '../../../core/services/haptics_service.dart';
import '../../../core/services/permission_service.dart';
import '../../../core/utils/mock_data.dart';
import '../providers/capture_providers.dart';

class CameraScreen extends HookConsumerWidget {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useState<CameraController?>(null);
    final permissionStatus = useState<PermissionStatus?>(null);
    final initializing = useState(true);
    final imagePicker = useMemoized(ImagePicker.new);
    final uuid = useMemoized(Uuid.new);

    useEffect(() {
      Future<void> initCamera() async {
        final permission = await ref.read(permissionServiceProvider).requestCamera();
        permissionStatus.value = permission;
        if (!permission.isGranted) {
          initializing.value = false;
          return;
        }
        try {
          final cameras = await availableCameras();
          if (cameras.isEmpty) {
            initializing.value = false;
            return;
          }
          final camController = CameraController(
            cameras.first,
            ResolutionPreset.medium,
            enableAudio: false,
          );
          await camController.initialize();
          controller.value = camController;
        } catch (_) {
          initializing.value = false;
        } finally {
          initializing.value = false;
        }
      }

      initCamera();
      return () => controller.value?.dispose();
    }, []);

    Future<void> createPayload({
      required bool fromGallery,
      String? localPath,
    }) async {
      await ref.read(hapticsServiceProvider).mediumImpact();
      final user = ref.read(profileProvider) ?? MockData.demoProfile();
      final units = ref.read(preferencesProvider).units;
      final capture = CaptureInfo(
        localPath: localPath ?? 'capture-${DateTime.now().millisecondsSinceEpoch}',
        previewBase64: base64Encode(utf8.encode('mock-preview')),
        fromGallery: fromGallery,
      );
      final payload = MealPayload(
        localId: uuid.v4(),
        user: user,
        capture: capture,
        preferences: MockData.defaultPreferences(metric: units == UnitsPreference.metric),
      );
      ref.read(capturePayloadProvider.notifier).state = payload;
      if (context.mounted) {
        context.pushNamed('processing');
      }
    }

    Future<void> handleShutter() async {
      if (controller.value == null || !controller.value!.value.isInitialized) {
        await createPayload(fromGallery: false);
        return;
      }
      final picture = await controller.value!.takePicture();
      await createPayload(fromGallery: false, localPath: picture.path);
    }

    Future<void> handleGallery() async {
      final file = await imagePicker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        await createPayload(fromGallery: true, localPath: file.path);
      }
    }

    final hasPermission = permissionStatus.value?.isGranted ?? false;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Builder(
                  builder: (context) {
                    if (initializing.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (!hasPermission) {
                      return _PermissionEmptyState(permissionStatus.value);
                    }
                    final cam = controller.value;
                    if (cam == null || !cam.value.isInitialized) {
                      return _CameraPlaceholder();
                    }
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(32),
                      child: CameraPreview(cam),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _CameraActionButton(
                    icon: Icons.photo_library_outlined,
                    onTap: handleGallery,
                  ),
                  GestureDetector(
                    onTap: handleShutter,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 6),
                      ),
                      child: Center(
                        child: Container(
                          width: 56,
                          height: 56,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  _CameraActionButton(
                    icon: Icons.flash_on,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PermissionEmptyState extends StatelessWidget {
  const _PermissionEmptyState(this.status);

  final PermissionStatus? status;

  @override
  Widget build(BuildContext context) {
    final permanentlyDenied = status?.isPermanentlyDenied ?? false;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.lock, size: 64, color: Colors.white.withValues(alpha: 0.8)),
          const SizedBox(height: 16),
          Text(
            'Camera permission required',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 12),
          Text(
            'Enable access in settings to capture meals.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white70),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () => openAppSettings(),
            child: Text(permanentlyDenied ? 'Open Settings' : 'Try Again'),
          ),
        ],
      ),
    );
  }
}

class _CameraPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.center_focus_strong, color: Colors.white, size: 64),
            SizedBox(height: 12),
            Text('Center your meal', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}

class _CameraActionButton extends StatelessWidget {
  const _CameraActionButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}
