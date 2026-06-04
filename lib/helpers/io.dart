import 'dart:io' show Directory;
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

/// Path to a directory where the application may place data that is
/// user-generated, or that cannot otherwise be recreated by your application.
///
/// Consider using another path, such as [getApplicationSupportDirectory],
/// [getApplicationCacheDirectory], or [getExternalStorageDirectory], if the
/// data is not user-generated.
///
/// Example implementations:
/// - `NSDocumentDirectory` on iOS and macOS.
/// - The Flutter engine's `PathUtils.getDataDirectory` API on Android.
///
/// Throws a [MissingPlatformDirectoryException] if the system is unable to
/// provide the directory.

PathProviderPlatform get _platform => PathProviderPlatform.instance;

Future<Directory> getPromptCreatorDocumentsDirectory() async {
  final String? path = await _platform.getApplicationDocumentsPath();
  if (path == null) {
    throw Exception(
      'helpers/io.dart: Unable to get application documents custom directory',
    );
  }
  await Directory('$path/promptCreatorData').exists().then((exists) async {
    if (!exists) {
      await Directory('$path/promptCreatorData').create(recursive: true);
    }
  });
  return Directory('$path/promptCreatorData');
}
