import 'package:flutter/services.dart';

class MixpanelChannel {
  static const platform = const MethodChannel('mixpanel');

  Future<String> trackFirstStringVariation({String text}) async {
    return await platform.invokeMethod('trackFirstText', <String, dynamic>{
      'name': 'FirstStringVariation',
      'properties': {
        'text': text,
      },
    });
  }
}
