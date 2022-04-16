import 'dart:convert';
import 'dart:io';

import 'package:emmaus/data/model/drive_model.dart';
import 'package:emmaus/ui/drive_detail/widget/folder_upload_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

import '../constants.dart';
import '../ui/drive_detail/widget/file_upload_dialog.dart';

const baseUrl = 'https://official-emmaus.com/g5/bbs';

class DriveController extends GetxController {
  final _driveModel = DriveModel(
          directory: "",
          fileName: "",
          fileType: "",
          id: 0,
          createAt: DateTime.now())
      .obs;
  set driveModel(value) => _driveModel.value = value;
  get driveModel => _driveModel.value;

  final _file = File("").obs;
  set file(value) => _file.value = value;
  get file => _file.value;

  final _driveList = <DriveModel>[].obs;
  List<DriveModel> get driveList => _driveList;
  set driveList(val) => _driveList.value = val;

  final _isLoading = false.obs;
  get isLoading => _isLoading.value;
  set isLoading(val) => _isLoading.value = val;

  Widget getFileImage(String fileType) {
    if (fileType == 'folder') {
      return Image.asset(
        "images/folder.png",
        width: 30,
      );
    } else {
      final mimeType = lookupMimeType(fileType);
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
    driveList.clear();
    isLoading = false;
    try {
      var map = <String, dynamic>{};
      map['directory'] = "$directory/";
      final response = await http.post(
          Uri.parse('https://official-emmaus.com/g5/bbs/emmaus_drive_list.php'),
          body: map);
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

  add() async {
    print(driveModel.fileName);
    print(driveModel.fileType);
    print(driveModel.directory);
    print(file);
    try {
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              "https://www.official-emmaus.com/g5/bbs/emmaus_drive_add.php"));
      print("https://official-emmaus.com/g5/bbs/emmaus_drive_add.php");
      request.fields['fileName'] = driveModel.fileName;
      request.fields['fileType'] = driveModel.fileType;
      request.fields['directory'] = driveModel.directory;

      request.files
          .add(await http.MultipartFile.fromPath("driveFile", file.path));

      print(request);
      http.Response response =
          await http.Response.fromStream(await request.send());
      print(response.body);
      if (response.statusCode == 200) {
        if (response.body == "true") {
          Get.back();
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
    try {
      var url = Uri.parse(
          'https://official-emmaus.com/g5/bbs/emmaus_drive_add_folder.php');
      var result = await http.post(url, body: {
        "name": driveModel.fileName,
        "directory": driveModel.directory
      });

      print(result.body);
      if (result.body == "true") {
        Get.back();
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
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false,
        onFileLoading: (value) {
          debugPrint(value.toString());
        });
    Get.back();
    print(result!.names);
    print(result.names[0]!.split(".").last);
    TextEditingController fileNameController = TextEditingController();
    fileNameController.text = result.names[0]!.split(".").first;
    file = File(result.files.single.path!);

    driveModel = DriveModel(
        directory: "$directory/",
        fileName: fileNameController.text,
        fileType: result.names[0]!.split(".").last,
        id: 0,
        createAt: DateTime.now());
    Get.defaultDialog(
        title: "파일 업로드",
        titleStyle: TextStyle(
          fontSize: 12,
          fontFamily: "Nanum",
          fontWeight: FontWeight.w700,
        ),
        content: FileUploadDialog(
          fileNameController: fileNameController,
          fileType: result.names[0]!.split(".").last,
          directory: directory,
        ),
        confirm: ElevatedButton(
          onPressed: add,
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

  cameraSave(String directory) async {
    print(directory);
    Get.dialog(
        const Center(
          child: CircularProgressIndicator(),
        ),
        barrierDismissible: false);
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    Get.back();
    print(pickedFile?.path);
    TextEditingController fileNameController = TextEditingController();
    fileNameController.text = "photo" + DateTime.now().toString();
    file = File(pickedFile?.path ?? "");

    driveModel = DriveModel(
        directory: "$directory/",
        fileName: fileNameController.text,
        fileType: "jpg",
        id: 0,
        createAt: DateTime.now());
    Get.defaultDialog(
        title: "파일 업로드",
        titleStyle: TextStyle(
          fontSize: 12,
          fontFamily: "Nanum",
          fontWeight: FontWeight.w700,
        ),
        content: FileUploadDialog(
          fileNameController: fileNameController,
          fileType: "jpg",
          directory: directory,
        ),
        confirm: ElevatedButton(
          onPressed: () {
            add();
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
        createAt: DateTime.now());
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
}
