import 'package:ab_test_demo/dynamic_link.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Deeplink"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Body(),
      ),
    );
  }
}

class Body extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BodyState();
  }
}

class BodyState extends State<Body> {
  TextEditingController generatedLink = TextEditingController();
  TextEditingController linkController = TextEditingController();
  TextEditingController prefixController = TextEditingController();
  DynamicLink instance;

  @override
  void initState() {
    super.initState();
    instance = DynamicLink();
    linkController.text = 'https://sebastianusk.page.link';
    prefixController.text = 'https://sebastianusk.page.link';
  }

  void generate() {
    instance
        .generateLink(linkController.text, prefixController.text)
        .then((result) {
      print("result here $result");
      generatedLink.text = result;
    }).catchError((error) {
      print("error here $error");
      generatedLink.text = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("bebas");
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Link'),
          TextField(controller: linkController),
          Text('Prefix'),
          TextField(controller: prefixController),
          RaisedButton(
            child: Text('Generate!'),
            onPressed: generate,
          ),
          TextField(controller: generatedLink),
        ],
      ),
    );
  }
}
