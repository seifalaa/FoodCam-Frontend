import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:foodcam_frontend/constants.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  Future<void> pickImage() async {
    final picker = ImagePicker();
    late File image;
    final pickedImage = await picker.pickImage(
      source: ImageSource.camera,
    );
    setState(() {
      if (pickedImage != null) {
        image = File(pickedImage.path);
      }
    });

    final request = http.MultipartRequest(
        "POST", Uri.parse("http://$kIpAddress:8000/MachineView/"));

    final String imageName = image.path.split('/').last;
    final stream = http.ByteStream(image.openRead());
    stream.cast();
    final length = await image.length();
    final multipartFileSign =
        http.MultipartFile('photo', stream, length, filename: imageName);

    request.files.add(multipartFileSign);
    await request.send();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await pickImage();
          },
          child: const Text('click'),
        ),
      ),
    );
  }
}
