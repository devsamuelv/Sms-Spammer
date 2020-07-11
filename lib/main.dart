import 'package:SPAMMY_IOS/backend/messaging.dart';
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
  TextEditingController phoneNumber = new TextEditingController();
  TextEditingController messageContent = new TextEditingController();
  TextEditingController numberOfMessages = new TextEditingController();

  // todo use twillo for 1000 msg's a sec
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.title, style: TextStyle(fontSize: 25)),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
              child: CupertinoTextField(
                placeholder: "Phone Number",
                controller: phoneNumber,
                padding: EdgeInsets.all(12),
                onChanged: (value) => {if (null) {}},
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
              child: CupertinoTextField(
                controller: messageContent,
                placeholder: "Message Contents",
                padding: EdgeInsets.all(12),
                onChanged: (value) => {if (null) {}},
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 150.0, vertical: 15.0),
              child: CupertinoTextField(
                controller: numberOfMessages,
                padding: EdgeInsets.all(10),
                placeholder: "Amount of Messages",
                onChanged: (value) => {if (null) {}},
              ),
            ),
            CupertinoButton(
              child: Text('Spam'),
              color: Colors.blue,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => new CupertinoAlertDialog(
                    title: Text('💥 Are You Sure? 💥'),
                    content: Text('Address: ' +
                        phoneNumber.text +
                        "\n"
                            'Amount: ' +
                        numberOfMessages.text +
                        "\n"
                            'Message Content: ' +
                        messageContent.text +
                        "\n"),
                    actions: <Widget>[
                      CupertinoDialogAction(
                        child:
                            Text('Yes', style: TextStyle(color: Colors.green)),
                        onPressed: () {
                          Navigator.pop(context, 'Cancel');

                          Spam(int.parse(numberOfMessages.text),
                              phoneNumber.text, messageContent.text, context);
                        },
                      ),
                      CupertinoDialogAction(
                        child: Text('No', style: TextStyle(color: Colors.red)),
                        onPressed: () {
                          Navigator.pop(context, 'Cancel');
                        },
                      )
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
