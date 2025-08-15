import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_setup.dart';

class TestHelper {
  static Widget createTestApp({required Widget child, ThemeData? theme}) {
    return MaterialApp(theme: theme ?? ThemeData(), home: child);
  }
}

mixin BlocTestMixin on WidgetTester {
  void setupBlocMocks() {
    TestSetup.setupTestEnvironment();
  }

  void tearDownBlocMocks() {
    TestSetup.tearDownTestEnvironment();
  }
}
