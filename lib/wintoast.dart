
import 'dart:async';

import 'package:flutter/services.dart';

class Wintoast {
  static const MethodChannel _channel =
      const MethodChannel('wintoast');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
