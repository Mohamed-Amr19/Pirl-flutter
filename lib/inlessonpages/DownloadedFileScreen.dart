// import 'dart:convert';
// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// //import 'package:flutter_file_downloader/flutter_file_downloader.dart';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';

// class FileList extends StatefulWidget {
//   @override
//   _FileListState createState() => _FileListState();
// }

// class _FileListState extends State<FileList> {
//   List<String> _fileList = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadFileList();
//   }

//   var dio = Dio();

//   void _loadFileList() async {
//     // final response =
//     //     await http.get(Uri.parse('http://192.168.1.6:8000/list-directory/'));
//     final response =
//         await http.get(Uri.http("192.168.1.6:8000","list-directory/material"));
//     print("a7aaaaaaaaaaa");
//     print(response.body); // Replace with your server URL
//     final jsonData = json.decode(response.body);
//     print(jsonData);
//     setState(() {
//       _fileList = List<String>.from(jsonData);
//     });
//   }


//   Future download2(Dio dio, String url, String savePath) async {
//     print("a777777777777777777777777777777777777777777777777777777777a");
//     try {
//       Response response = await dio.get(
//         url,

//         //Received data with List<int>
//         options: Options(
//             responseType: ResponseType.bytes,
//             followRedirects: false,
//             validateStatus: (status) {
//               if (status == null) {
//                 return false;
//               }
//               return status < 500;
//             }),
//       );
//       print(response.headers);
//       File file = File(savePath);
//       var raf = file.openSync(mode: FileMode.write);
//       // response.data is List<int> type
//       raf.writeFromSync(response.data);
//       await raf.close();
//     } catch (e) {
//       print(e);
//     }
//   }

//   // Future<void> _downloadFile(String filename) async {
//   //   final url =
//   //       'http://192.168.1.110:8001/files/$filename'; // Replace with your server URL

//   //   // var tempDir = await getApplicationDocumentsDirectory();
//   //   // print('temp dir ${tempDir}');
//   //   String fullPath = tempDir.path + "/${filename}'";
//   //   print('full path ${fullPath}');

//   //   //download2(dio, url, fullPath);

//   //   final response = await http.get(Uri.parse(url));

//   //   final bytes = response.bodyBytes;
//   //   print(response.body);

//   //   final appDir = await getApplicationDocumentsDirectory();
//   //   final file = File('${appDir.path}/$filename');
//   //   await file.writeAsBytes(bytes);
//   //   ScaffoldMessenger.of(context).showSnackBar(
//   //     SnackBar(
//   //       content: Text('$filename downloaded'),
//   //       duration: Duration(seconds: 2),
//   //     ),
//   //   );
//   // }

//   Future<void> downloadFile(String url, String filename) async {
//     final response = await http.get(Uri.parse(url + filename),
//         headers: {'accept': 'application/octet-stream'});
//     final bytes = response.bodyBytes;
//     print(response.body);
//     final appDir = await getApplicationDocumentsDirectory();
//     final file = File('${appDir.path}/$filename');
//     print(file.path);
//     await file.writeAsBytes(bytes);
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('$filename downloaded'),
//         duration: Duration(seconds: 2),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('File List'),
//       ),
//       body: ListView.builder(
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(_fileList[index]),
//             onTap: () {
//               downloadFile(
//                   'http://192.168.1.110:8000/files/', _fileList[index]);
//             },
//           );
//         },
//         itemCount: _fileList.length,
//       ),
//     );
//   }
// }
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/functions/funcs.dart';
import 'package:lecle_downloads_path_provider/lecle_downloads_path_provider.dart';
//import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class DownloadedFilesScreen extends StatefulWidget {
  const DownloadedFilesScreen({super.key});

  @override
  _DownloadedFilesScreenState createState() => _DownloadedFilesScreenState();
}

class _DownloadedFilesScreenState extends State<DownloadedFilesScreen> {
  late List<File> files;

  late Directory currentDirectory;
  List<FileSystemEntity> directoryContents = [];
  List<Directory> directoryStack = [];

  bool folderexist = false;
  @override
  void initState() {
    super.initState();
    setInitialDirectory();
    loadDownloadedFiles();
    
  }
  Directory downloadsDirectory = Directory("");
  Future<void> loadDownloadedFiles() async {
    Directory? downloadsDirectory = await DownloadsPath.downloadsDirectory();
    //String? downloadsDirectory = (await DownloadsPath.downloadsDirectory())?.path;
    if (downloadsDirectory!=null)
    {
      print(downloadsDirectory.toString());
      downloadsDirectory = Directory ("${downloadsDirectory.path}/PIRL/${ApiEndPoints.className}/${ApiEndPoints.lessonId}");
      print(downloadsDirectory.toString());
    }
    folderexist = await downloadsDirectory!.exists();
    Directory downloadDir = Directory(downloadsDirectory.path);
    List<FileSystemEntity> fileEntities = downloadDir.listSync();
    List<File> downloadedFiles = [];

    for (var fileEntity in fileEntities) {
      if (fileEntity is File) {
        downloadedFiles.add(fileEntity);
      }
    }

      setState(() {
      files = downloadedFiles;
      print("asdfasdfasd");
      print(files);
    });
  }

  void openFile(File file) {
    OpenFile.open(file.path);
    print("im function");
    print(file.path);
  }


   void setInitialDirectory() async {
    Directory? downloadsDirectory = await DownloadsPath.downloadsDirectory();
    //String? downloadsDirectory = (await DownloadsPath.downloadsDirectory())?.path;
    if (downloadsDirectory!=null)
    {
      print(downloadsDirectory.toString());
      downloadsDirectory = Directory ("${downloadsDirectory.path}/PIRL/${ApiEndPoints.className}");
      print(downloadsDirectory.toString());
    } // Set your initial directory here
    await loadDirectory(downloadsDirectory!);
  }

  Future<void> loadDirectory(Directory directory) async {
    setState(() {
      currentDirectory = directory;
    });

    List<FileSystemEntity> contents = await directory.list().toList();
    setState(() {
      directoryContents = contents;
    });
  }

   void navigateToDirectory(Directory directory) async {
    directoryStack.add(currentDirectory);
    await loadDirectory(directory);
  }

  void navigateBack() async {
    if (directoryStack.isNotEmpty) {
      Directory previousDirectory = directoryStack.removeLast();
      await loadDirectory(previousDirectory);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mycolors.backgroundColor,
      appBar: AppBar(
        backgroundColor: mycolors.appbarcolor,
        title: const Text('Downloaded Files'),
      ),
      body: folderexist == false
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          ElevatedButton(
            onPressed: navigateBack,
            child: const Text('Back'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: directoryContents.length,
              itemBuilder: (context, index) {
                FileSystemEntity entity = directoryContents[index];
                String name = entity.path.split('/').last;
                bool isDirectory = entity is Directory;

                return ListTile(
                  title: Text(name),
                  leading: Icon(isDirectory ? Icons.folder : Icons.file_copy),
                  onTap: () {
                    if (isDirectory) {
                      navigateToDirectory(entity);
                    } else {
                      openFile(entity as File);
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
