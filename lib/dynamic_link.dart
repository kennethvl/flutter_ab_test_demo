import 'package:flutter/services.dart';

class DynamicLink {
  static const platform = const MethodChannel('dynamic-link');

  Future<String> generateLink(String link, String prefix) {
    return platform.invokeMethod('generate', <String, dynamic>{
      'link': link,
      'prefix': prefix,
    }).then((data) {
      print(data);
      return data;
    });
  }
}
