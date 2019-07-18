import 'package:ab_test_demo/mixpanel_channel.dart';
import 'package:ab_test_demo/remote_config_channel.dart';
import 'package:flutter/material.dart';

import 'app.dart';

void main() => runApp(App());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'A/B Testing Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key key,
    this.title,
  }) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  RemoteConfigChannel _channel = RemoteConfigChannel();
  MixpanelChannel _mixpanelChannel = MixpanelChannel();

  String firstText = '';

  @override
  void initState() {
    super.initState();
    this.fetchRemoteData();
  }

  void fetchRemoteData() async {
    print('kepanggil');

    _channel.getFirstTextString().then((value) {
      _mixpanelChannel.trackFirstStringVariation(text: value);

      setState(() {
        firstText = value;
      });
    }).catchError((error) {
      // Call crashlytics
      setState(() {
        firstText = error.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: Container(
              child: Center(
                child: Text(firstText),
              ),
              color: Colors.amber,
              width: MediaQuery.of(context).size.width * 2 / 3,
              height: 100,
              margin: EdgeInsets.only(
                top: 10.0,
                bottom: 10.0,
              ),
            ),
          ),
          Center(
            child: Container(
              child: Center(
                child: Text('This is another sample text'),
              ),
              color: Colors.lightBlue,
              width: MediaQuery.of(context).size.width * 2 / 3,
              height: 100,
              margin: EdgeInsets.only(
                top: 10.0,
                bottom: 10.0,
              ),
            ),
          ),
          Center(
            child: RaisedButton(
              child: Text('Go to First Detail'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FirstDetailPage(),
                  ),
                );
              },
            ),
          ),
          Center(
            child: RaisedButton(
              child: Text('Go to Second Detail'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SecondDetailPage(),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class FirstDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First A/B Testing Detail'),
      ),
      body: Center(
        child: Text('This is a detail page'),
      ),
    );
  }
}

class SecondDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second A/B Testing Detail'),
      ),
      body: Center(
        child: Text('This is a detail page'),
      ),
    );
  }
}
