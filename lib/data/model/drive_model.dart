class DriveModel {
  int id;
  String fileName;
  String fileType;
  DateTime createAt;
  String directory;

  DriveModel({
    required this.id,
    required this.fileName,
    required this.fileType,
    required this.createAt,
    required this.directory,
  });

  factory DriveModel.fromJson(Map<String, dynamic> json) {
    return DriveModel(
      id: int.parse(json['id']),
      fileName: json['fileName'],
      fileType: json['fileType'],
      createAt: DateTime.parse(json['createAt']),
      directory: json['directory'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'fileName': fileName,
        'fileType': fileType,
        'createAt': createAt,
        'directory': directory,
      };
}
