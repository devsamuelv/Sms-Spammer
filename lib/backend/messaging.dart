import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sms/sms.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:permission_handler_platform_interface/permission_handler_platform_interface.dart';

Future<PermissionStatus> getPermissionStatus = Permission.sms.status;

bool firstMsgSend = false;

void Spam(int amount, String phoneNumber, String messageContent,
    BuildContext context) async {
  getPermissionStatus.then((status) {
    if (status.isUndetermined) {
      Permission.sms.request();
    }

    if (status.isGranted) {
      SmsSender sender = new SmsSender();
      SmsMessage message = new SmsMessage(phoneNumber, messageContent);

      for (int i = 0; i != amount; i++) {
        sender.sendSms(message).then((state) {
          if (state.state == SmsMessageState.Sent) {
            print("SMS is sent!");
          } else if (state.state == SmsMessageState.Delivered) {
            if (!firstMsgSend) {
              showDialog(
                context: context,
                builder: (context) => new CupertinoAlertDialog(
                  title: Text('✔ Message Sent ✔'),
                  actions: <Widget>[
                    CupertinoDialogAction(
                      child: Text('Ok', style: TextStyle(color: Colors.red)),
                      onPressed: () {
                        Navigator.pop(context, 'Cancel');
                      },
                    )
                  ],
                ),
              );

              firstMsgSend = true;
            }
          } else if (state.state == SmsMessageState.Fail) {
            if (!firstMsgSend) {
              showDialog(
                context: context,
                builder: (context) => new CupertinoAlertDialog(
                  title: Text('⛔ Failed To Send Message ⛔'),
                  actions: <Widget>[
                    CupertinoDialogAction(
                      child: Text('Ok', style: TextStyle(color: Colors.red)),
                      onPressed: () {
                        Navigator.pop(context, 'Cancel');
                      },
                    )
                  ],
                ),
              );

              firstMsgSend = true;
            }
          }
        });
      }

      print(message.address);
    }
  });
}
