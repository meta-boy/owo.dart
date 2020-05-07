import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:owo/owo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'OwO Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Home());
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget url = Container();
  Widget shortendUrl = Container();

  File file;
  String apiKey, customUrl = 'https://owo.whats-th.is/', toShorten;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      file = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OwO Example App'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                file == null ? Text('No image selected.') : Image.file(file),
                url,
                Row(
                  children: <Widget>[
                    Text('API Key: '),
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            apiKey = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text('Custom Url: '),
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            customUrl = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton.extended(
                      icon: Icon(Icons.file_download),
                      onPressed: () async {
                        await getImage();
                      },
                      label: Text('Select Image')),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton.extended(
                      icon: Icon(Icons.file_upload),
                      onPressed: () async {
                        print(apiKey);
                        if (apiKey == null) return;
                        setState(() {
                          url = Center(
                            child: CircularProgressIndicator(),
                          );
                        });
                        var owo =
                            OwOClient(apiKey: apiKey);
                        await owo.init();
                        var res = await owo.upload(files: [file]);
                        res.fold(
                            (l) => url =
                                Text('${l.errorcode}: ${l.description}'), (r) {
                          url = SelectableText(r.files[0].url);
                        });
                        setState(() {});
                      },
                      label: Text('Upload File')),
                ),
                shortendUrl,
                Row(
                  children: <Widget>[
                    Text('URL to shorten: '),
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            toShorten = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton.extended(
                      icon: Icon(Icons.file_download),
                      onPressed: () async {
                        print(apiKey);
                        if (apiKey == null) return;
                        setState(() {
                          shortendUrl = Center(
                            child: CircularProgressIndicator(),
                          );
                        });
                        var owo = OwOClient(apiKey: apiKey);

                        await owo.init();

                        var res = await owo.shorten(url: toShorten);
                        res.fold(
                            (l) => shortendUrl =
                                Text('${l.errorcode}: ${l.description}'), (r) {
                          shortendUrl = SelectableText(r);
                        });
                        setState(() {});
                      },
                      label: Text('Shorten')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
