import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/drive_controller.dart';
import '../../../data/model/drive_model.dart';

class FolderUploadDialog extends StatelessWidget {
  const FolderUploadDialog({
    Key? key,
    required this.folderNameController,
    required this.directory,
  }) : super(key: key);

  final TextEditingController folderNameController;
  final String directory;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "폴더명 : ",
              style: TextStyle(
                fontSize: 11,
                fontFamily: "Nanum",
                fontWeight: FontWeight.w500,
              ),
            ),
            Flexible(
                child: TextField(
              controller: folderNameController,
              onChanged: (text) {
                final driveController = Get.put(DriveController());
                driveController.driveModel = DriveModel(
                    fileName: folderNameController.text,
                    fileType: "folder",
                    directory: "$directory/",
                    id: 0,
                    createAt: DateTime.now());
              },
              style: TextStyle(
                fontSize: 14,
                fontFamily: "Nanum",
                fontWeight: FontWeight.w700,
              ),
            )),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Text(
              "저장되는 위치 : ",
              style: TextStyle(
                fontSize: 11,
                fontFamily: "Nanum",
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              directory,
              style: TextStyle(
                fontSize: 14,
                fontFamily: "Nanum",
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
