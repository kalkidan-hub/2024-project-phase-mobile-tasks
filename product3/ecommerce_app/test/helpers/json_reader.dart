import 'dart:io';

String readJson(String path) {
  return File(path).readAsStringSync();
}
