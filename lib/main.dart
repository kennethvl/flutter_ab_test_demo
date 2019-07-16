import 'package:ab_test_demo/config.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<RemoteConfig>(
        future: Config().setupRemoteConfig(),
        builder: (BuildContext context, AsyncSnapshot<RemoteConfig> snapshot) {
          return snapshot.hasData
              ? MyHomePage(title: 'A/B Testing Home')
              : Container();
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key key,
    this.title,
    this.remoteConfig,
  }) : super(key: key);

  final String title;
  final RemoteConfig remoteConfig;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() async {
    super.initState();

    await widget.remoteConfig.fetch(expiration: const Duration(seconds: 0));
    await widget.remoteConfig.activateFetched();
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
                child: Text(widget.remoteConfig.getString('first_text')),
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
                if (widget.remoteConfig.getString('second_action') ==
                    'second') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SecondDetailPage(),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FirstDetailPage(),
                    ),
                  );
                }
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
