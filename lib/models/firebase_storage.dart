import 'dart:async';

import 'package:firebase_storage/firebase_storage.dart';

Future<String> storageUrl(String path) async {
  final StorageReference ref = FirebaseStorage.instance.ref().child(path);
  return ref.getDownloadURL();
}
