import 'package:flutter/services.dart';

class RemoteConfigChannel {
  static const platform = const MethodChannel('ab-test');

  Future<String> getFirstTextString() async {
    return await platform
        .invokeMethod('fetchFirstText', <String, dynamic>{'key': 'first_text'});
  }
}
