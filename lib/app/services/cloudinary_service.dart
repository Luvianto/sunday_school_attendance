import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class CloudinaryService {
  String cloudName = dotenv.env['CLOUDINARY_CLOUD_NAME'] ?? '';

  Future<bool> uploadProfilePicture(FilePickerResult? filePickerResult) async {
    if (filePickerResult == null || filePickerResult.files.isEmpty) {
      print('No File Selected!');
      return false;
    }

    File file = File(filePickerResult.files.single.path!);

    var url =
        Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');
    var request = http.MultipartRequest("POST", url);

    var fileBytes = await file.readAsBytes();

    var multipartFile = http.MultipartFile.fromBytes(
      'file',
      fileBytes,
      filename: file.path.split("/").last,
    );

    request.files.add(multipartFile);
    request.fields["upload_preset"] = "student_profile_test";
    request.fields["resource_type"] = "image";

    var response = await request.send();

    var responseBody = await response.stream.bytesToString();
    print('responseBody: $responseBody');

    if (response.statusCode == 200) {
      print('Upload Success');
      return true;
    } else {
      print('Upload failed with status: ${response.statusCode}');
      return false;
    }
  }
}
