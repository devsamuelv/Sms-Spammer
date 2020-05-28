import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spammy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Spammy'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  TextEditingController controller1 = new TextEditingController();
  TextEditingController controller2 = new TextEditingController();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  // todo use twillo for 1000 msg's a sec
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
              child: CupertinoTextField(
                placeholder: "Phone Number",
                controller: controller1,
                onChanged: (value) => {if (null) {}},
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
              child: CupertinoTextField(
                controller: controller2,
                placeholder: "Message Contents",
                onChanged: (value) => {if (null) {}},
              ),
            ),
            CupertinoButton(
              child: Text('Spam'),
              color: Colors.blue,
              onPressed: () => {},
            )
          ],
        ),
      ),
    );
  }
}
