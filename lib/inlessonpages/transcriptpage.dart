import 'dart:convert';
//import 'dart:html';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:lecle_downloads_path_provider/lecle_downloads_path_provider.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../functions/funcs.dart';

class transcriptpage extends StatefulWidget {
  const transcriptpage({Key? key}) : super(key: key);

  @override
  State<transcriptpage> createState() => _transcriptpageState();
}

class _transcriptpageState extends State<transcriptpage> {

  @override
  void initState() {
    super.initState();
    _loadFileList();
  }

  List<String> _fileList = [];
  void _loadFileList() async {
    // final response =
    //     await http.get(Uri.parse('http://192.168.1.6:8000/list-directory/'));
    final response =
        await http.get(Uri.http(ApiEndPoints.baseUrl,"list-directory/transcripts"));
    print("a7aaaaaaaaaaa");
    print(response.body); // Replace with your server URL
    final jsonData = json.decode(response.body);
    print(jsonData);
    setState(() {
      _fileList = List<String>.from(jsonData);
    });
  }

  Future<void> downloadFile2(String fileName) async {
    Dio dio = Dio();
    Directory? downloadsDirectory = await DownloadsPath.downloadsDirectory();
    try {
      String downloadUrl = "http://${ApiEndPoints.baseUrl}/transcripts/$fileName";
      //String downloadUrl = "http://${ApiEndPoints.baseUrl}/material/" + fileName;
      Directory saveDir =  downloadsDirectory!;
      String savePath = '${saveDir.path}/PIRL/${ApiEndPoints.className}/${ApiEndPoints.lessonId}/$fileName'; // Set your desired save path here
      
      print("save dir: $saveDir");
      // Request write permission if not granted
      PermissionStatus permissionStatus = await Permission.storage.request();
      if (permissionStatus.isGranted) {
        // Create the directory if it doesn't exist
        if (!await saveDir.exists()) {
          await saveDir.create(recursive: true);
          print('Directory created');
        }
      }
      
      print("hi im downloading lmfrod");
      await dio.download(downloadUrl, savePath);
      print('File downloaded successfully');
      
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$fileName downloaded'),
        duration: const Duration(seconds: 2),
      ),);
      
      print("savepath: $savePath");
    } catch (e) {
      print('Error downloading file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mycolors.backgroundColor,
      appBar: AppBar(
        backgroundColor: mycolors.appbarcolor,
        title: const Text('Lecture Transcripts'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_fileList[index]),
            onTap: () {
              downloadFile2(
                   _fileList[index]);
            },
          );
        },
        itemCount: _fileList.length,
      ),
    );
  }
}