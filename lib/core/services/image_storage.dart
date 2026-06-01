import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// Stockage local des photos (reçus, véhicules) dans le dossier de l'app.
class ImageStorage {
  ImageStorage._();
  static final ImageStorage instance = ImageStorage._();

  final ImagePicker _picker = ImagePicker();

  Future<String?> pickAndStore({bool fromCamera = false}) async {
    final XFile? picked = await _picker.pickImage(
      source: fromCamera ? ImageSource.camera : ImageSource.gallery,
      maxWidth: 1600,
      imageQuality: 80,
    );
    if (picked == null) return null;

    final dir = await getApplicationDocumentsDirectory();
    final photosDir = Directory(p.join(dir.path, 'photos'));
    if (!photosDir.existsSync()) {
      photosDir.createSync(recursive: true);
    }
    final ext = p.extension(picked.path);
    final name = 'img_${DateTime.now().millisecondsSinceEpoch}$ext';
    final dest = p.join(photosDir.path, name);
    await File(picked.path).copy(dest);
    return dest;
  }
}
