import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodcam_frontend/constants.dart';
import 'package:foodcam_frontend/controllers/backend_controller.dart';
import 'package:foodcam_frontend/controllers/homepage_controller.dart';
import 'package:foodcam_frontend/models/category.dart';
import 'package:foodcam_frontend/widgets/category_box.dart';
//import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  Future<void> pickImage() async {
    // DIO WORKING CODE
    //var _dio = Dio();
    //Response response = await _dio.post("http://$kIpAddress:8000/dj-rest-auth/token/refresh/", data: FormData.fromMap({'photo':await MultipartFile.fromFile('lib/assets/allergy.png',filename: 'allergy.png')}));

    // HTTP Working Code
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
    //final multipartFileSign =
    //http.MultipartFile.fromBytes('photo', (await rootBundle.load('lib/assets/allergy.png')).buffer.asUint8List(), filename: imageName);
    final multipartFileSign = http.MultipartFile('photo', stream, length, filename: imageName);

    request.files.add(multipartFileSign);
    final http.StreamedResponse response = await request.send();
    print(String.fromCharCodes(await response.stream.toBytes()));
    //print(response.data.toString());

  }

  final BackEndController _backEndController = BackEndController();

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
