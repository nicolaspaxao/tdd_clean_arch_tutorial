import 'dart:io';

String fixture(String filePath) =>
    File('test/fixture/$filePath').readAsStringSync();
