import 'dart:io';

import 'package:path/path.dart' as p;

String fixture(String name) => File(p.join('./test/fixtures/$name'))
    .readAsStringSync()
    .replaceAll('\n', '')
    .replaceAll(' ', '')
    .replaceAll('\r', '');
