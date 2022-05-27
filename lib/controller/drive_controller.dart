import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';
import '../data/model/drive_model.dart';
import '../ui/drive_detail/widget/file_upload_dialog.dart';
import '../ui/drive_detail/widget/folder_upload_dialog.dart';

class DriveController extends GetxController {
  final _driveModel = DriveModel(
          directory: "",
          fileName: "",
          fileType: "",
          id: 0,
          createAt: DateTime.now(),
          totalDirectory: '')
      .obs;

  set driveModel(value) => _driveModel.value = value;

  DriveModel get driveModel => _driveModel.value;

  final _driveList = <DriveModel>[].obs;

  List<DriveModel> get driveList => _driveList;

  set driveList(val) => _driveList.value = val;

  final _isLoading = false.obs;

  get isLoading => _isLoading.value;

  set isLoading(val) => _isLoading.value = val;

  final _directoryList = <String>[].obs;
  List<String> get directoryList => _directoryList;
  set directoryList(val) => _directoryList.value = val;

  final _directoryName = "".obs;
  get directoryName => _directoryName.value;
  set directoryName(val) => _directoryName.value = val;

  Future<bool> removeFile(int index) async {
    String path = directoryList.join("/");
    print(path);
    try {
      print(
          "./drive/$path/${driveList[index].fileName}.${driveList[index].fileType}");
      print(driveList[index].id);
      var url = Uri.parse('$kBaseUrl/emmaus_drive_remove.php');
      var result = await http.post(url, body: {
        "path": "./drive/$path/${driveList[index].fileName}",
        "type": driveList[index].fileType,
        "id": driveList[index].id.toString(),
      });

      print(result.body);
      if (result.body == "true") {
        Get.back();
        print("directory : ${directoryList.last}");
        getDriveList(directoryList.last);
        return true;
      }
    } catch (_) {
      print('exception : $_');
      return false;
    }
    return false;
  }

  addDirectory(String directory) {
    directoryList.add(directory);
    print(directoryList);
  }

  deleteDirectory() {
    directoryList.removeLast();
    _directoryList.refresh();
    print("list : $directoryList");

    if (directoryList.isNotEmpty) {
      print("fileName : ${directoryList.last}");
      directoryName = directoryList.last;
      getDriveList(directoryList.last);
    }
  }

  Widget getFileImage(String fileType) {
    if (fileType == 'folder') {
      return Image.asset(
        "images/folder.png",
        width: 30,
      );
    } else {
      final mimeType = lookupMimeType(".$fileType");
      print(mimeType);
      switch (mimeType!.split("/").first) {
        case "image":
          return const Text(
            "IMG",
            style: TextStyle(color: Color(0xFFFE7301)),
          );
        case "video":
          return const Text(
            "VIDEO",
            style: TextStyle(color: Color(0xFF8800FF)),
          );

        case "text":
          return const Text(
            "TXT",
            style: TextStyle(color: Colors.black),
          );

        case "application":
          switch (mimeType.split("/").last) {
            case "vnd.ms-excel":
            case "vnd.openxmlformats-officedocument.spreadsheetml.sheet":
              return const Text(
                "XLS",
                style: TextStyle(color: Color(0xFF0A783F)),
              );

            case "pdf":
              return const Text(
                "PDF",
                style: TextStyle(color: Color(0xFFDE0202)),
              );

            default:
              return const Text(
                "DOC",
                style: TextStyle(color: Color(0xFF0000D5)),
              );
          }
        default:
          return Container();
      }
    }
  }

  getDriveList(String directory) async {
    print(directory);
    directory = directory.replaceAll("/", "");
    driveList.clear();
    isLoading = false;
    try {
      var map = <String, dynamic>{};
      map['directory'] = "$directory/";
      final response = await http
          .post(Uri.parse('$kBaseUrl/emmaus_drive_list.php'), body: map);
      print("Get Drive List Response : ${response.body}");
      if (response.statusCode == 200) {
        driveList = parseResponse(response.body);
        isLoading = true;
      }
    } catch (e) {
      print("exception : $e");
      driveList = <DriveModel>[];
      isLoading = true;
    }
  }

  static List<DriveModel> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<DriveModel>((json) => DriveModel.fromJson(json)).toList();
  }

  add(
    Uint8List ufile,
  ) async {
    print(driveModel.fileName);
    print(driveModel.fileType);
    print(driveModel.directory);
    Get.dialog(
        const Center(
          child: CircularProgressIndicator(),
        ),
        barrierDismissible: false);
    print(directoryList.join("/"));
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse("$kBaseUrl/emmaus_drive_add.php"));
      print(directoryList.first);
      print("$kBaseUrl/emmaus_drive_add.php");
      request.fields['fileName'] = driveModel.fileName;
      request.fields['fileType'] = driveModel.fileType;
      request.fields['directory'] = directoryList.join("/") + "/";
      request.fields['currentFolder'] = driveModel.directory;
      request.fields['mainDirectory'] = directoryList.first;

      request.files.add(http.MultipartFile.fromBytes(
        "driveFile",
        ufile,
        contentType: MediaType('application', 'octet-stream'),
        filename: "userfile",
      ));
      print(request);
      http.Response response =
          await http.Response.fromStream(await request.send());
      print(response.body);
      if (response.statusCode == 200) {
        if (response.body == "true") {
          Get.back();
          Get.back();
          getDriveList(driveModel.directory);
          return true;
        } else {
          return false;
        }
      } else {
        print('Error -add');
        return false;
      }
    } catch (_) {
      print('exception : $_');
      return false;
    }
  }

  Future addFolder() async {
    print(driveModel.fileName);
    print(directoryList.join("/"));
    try {
      var url = Uri.parse('$kBaseUrl/emmaus_drive_add_folder.php');
      var result = await http.post(url, body: {
        "name": driveModel.fileName,
        "directory": directoryList.join("/") + "/",
        "currentFolder": driveModel.directory,
      });

      print(result.body);
      if (result.body == "true") {
        Get.back();
        getDriveList(driveModel.directory);
        return true;
      }
    } catch (_) {
      print('exception : $_');
      return false;
    }
  }

  fileSave(String directory) async {
    Get.dialog(
        const Center(
          child: CircularProgressIndicator(),
        ),
        barrierDismissible: false);
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: false);
    Uint8List mediaData = result!.files.first.bytes!;
    //var mediaData = await ImagePickerWeb.getImageInfo;
    Get.back();
    print(result.files.first.name);
    TextEditingController fileNameController = TextEditingController();
    fileNameController.text = result.files.first.name.split(".")[0];

    driveModel = DriveModel(
        directory: "$directory/",
        fileName: fileNameController.text,
        fileType: result.files.first.name.split(".")[1],
        id: 0,
        createAt: DateTime.now(),
        totalDirectory: '');
    Get.defaultDialog(
        title: "파일 업로드",
        titleStyle: TextStyle(
          fontSize: 12,
          fontFamily: "Nanum",
          fontWeight: FontWeight.w700,
        ),
        content: FileUploadDialog(
          fileNameController: fileNameController,
          fileType: driveModel.fileType,
          directory: directory,
        ),
        confirm: ElevatedButton(
          onPressed: () {
            add(mediaData);
          },
          child: Text("저장"),
          style: ElevatedButton.styleFrom(primary: kSelectColor),
        ),
        cancel: OutlinedButton(
          onPressed: () {
            Get.back();
          },
          child: Text("취소"),
          style: OutlinedButton.styleFrom(primary: kSelectColor),
        ));
  }

  folderSave(String directory) async {
    TextEditingController folderNameController = TextEditingController();
    driveModel = DriveModel(
        directory: "$directory/",
        fileName: folderNameController.text,
        fileType: 'folder',
        id: 0,
        createAt: DateTime.now(),
        totalDirectory: '');
    Get.defaultDialog(
        title: "폴더 생성",
        titleStyle: TextStyle(
          fontSize: 12,
          fontFamily: "Nanum",
          fontWeight: FontWeight.w700,
        ),
        content: FolderUploadDialog(
          folderNameController: folderNameController,
          directory: directory,
        ),
        confirm: ElevatedButton(
          onPressed: addFolder,
          child: Text("생성"),
          style: ElevatedButton.styleFrom(primary: kSelectColor),
        ),
        cancel: OutlinedButton(
          onPressed: () {
            Get.back();
          },
          child: Text("취소"),
          style: OutlinedButton.styleFrom(primary: kSelectColor),
        ));
  }

  void downloadFile(String url) async {
    launch(url);
  }
}
