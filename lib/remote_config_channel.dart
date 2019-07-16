import 'package:flutter/services.dart';

class RemoteConfigChannel {
  static const platform = const MethodChannel('ab-test');

  Future<String> getFirstTextString() {
    return platform
        .invokeMethod('fetchFirstText', <String, dynamic>{'key': 'first_text'});
  }
}
