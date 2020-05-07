import 'dart:io';

import 'package:owo/src/client.dart';
void main(List<String> args) async {
/// Initialize the client with your API key and optional 
/// custom url (Visit https://whats-th.is/faq.html for more info about this)
  var owo = OwOClient(
      apiKey: 'YOUR API KEY',
      customUrl: 'https://bad-me.me');

/// !!!!!!!!!!!!!!!!  VERY IMPORTANT TO INIT THE CLIENT TO SET HEADERS !!!!!!!!!!!!!!!!!!!!!!!!
  await owo.init(); //////////
//////////////////////////////



/// l => left, which holds errors for every method
/// r => right, which holds result for every method

/// Uploading the file(s)
  var resp =
      await owo.upload(files: [File('/full/path/to/the/file.file_extension')]);
  resp.fold((l) {
    print(l.errorcode);
  }, (r) {
    r.files.forEach((element) {
      print(element.url);
    });
  });
  
  /// Shortening any URL
  var key = await owo.shorten(url: 'https://metaboy.info');
  key.fold((l) => print(l.description), (r) => print(r));

/// Getting all objects for the api key in context
  var objects = await owo.getAllObjects();
  objects.fold((l) => print(l.description), (r) => r.data.forEach((element) {
    print(element.key);
  }));
  
/// Getting an object with specified key
var object = await owo.getObject(key: '2xEGFFw.png');
  object.fold((l) => print(l.description), (r) => print(r.data.key));
  
/// Deleting an object with specfied key
  var delete = await owo.deleteObject(key: '2xEGFFw.png');
  delete.fold((l) => print(l.description), (r) => print(r.data.deleteReason));
}