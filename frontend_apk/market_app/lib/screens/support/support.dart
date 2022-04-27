import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:image_picker/image_picker.dart';
import 'package:market_app/components/rounded_button.dart';
import 'package:market_app/details/colors.dart';
import 'package:path_provider/path_provider.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  List<String> attachments = [];
  bool isHTML = false;

  final _recipientController = TextEditingController(
    text: 'nikolas2000tas@gmail.com',
  );

  final _subjectController = TextEditingController(text: 'Problem with App');

  final _bodyController = TextEditingController(
    text: 'Mail body.',
  );

  Future<void> send() async {
    final Email email = Email(
      body: _bodyController.text,
      subject: _subjectController.text,
      recipients: [_recipientController.text],
      attachmentPaths: attachments,
      isHTML: isHTML,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      print(error);
      platformResponse = error.toString();
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(platformResponse),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   actions: <Widget>[
      //     IconButton(
      //       onPressed: send,
      //       icon: Icon(Icons.send),
      //     )
      //   ],
      // ),

      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("You can contact the developer if you have any bugs :)"),
              Container(
                width: size.width * 0.9,
                height: size.height * 0.7,
                child: Padding(
                  padding: EdgeInsets.only(top: 70.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _subjectController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Subject',
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextField(
                            controller: _bodyController,
                            maxLines: null,
                            expands: true,
                            textAlignVertical: TextAlignVertical.top,
                            decoration: InputDecoration(
                                labelText: 'Body',
                                border: OutlineInputBorder()),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            for (var i = 0; i < attachments.length; i++)
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      attachments[i],
                                      softWrap: false,
                                      overflow: TextOverflow.fade,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.remove_circle),
                                    onPressed: () => {_removeAttachment(i)},
                                  )
                                ],
                              ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                icon: Icon(Icons.attach_file),
                                onPressed: _openImagePicker,
                              ),
                            ),
                          ],
                        ),
                      ),
                      RoundedButton(
                          width: size.width * 0.7,
                          text: "Send Message",
                          press: send,
                          textcolor: secondaryBlack,
                          backgroundColor: primaryBlue)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _openImagePicker() async {
    final picker = ImagePicker();
    PickedFile? pick = await picker.getImage(source: ImageSource.gallery);
    if (pick != null) {
      setState(() {
        attachments.add(pick.path);
      });
    }
  }

  void _removeAttachment(int index) {
    setState(() {
      attachments.removeAt(index);
    });
  }

  Future<void> _attachFileFromAppDocumentsDirectoy() async {
    try {
      final appDocumentDir = await getApplicationDocumentsDirectory();
      final filePath = appDocumentDir.path + '/file.txt';
      final file = File(filePath);
      await file.writeAsString('Text file in app directory');

      setState(() {
        attachments.add(filePath);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to create file in applicion directory'),
        ),
      );
    }
  }
}
