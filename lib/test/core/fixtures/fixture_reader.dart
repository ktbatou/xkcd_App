import 'dart:io';

String fixture(String name) {
  var dir = Directory.current.path;

  return File('$dir/test/core/fixtures/$name').readAsStringSync();
}
