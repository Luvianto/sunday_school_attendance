import 'package:cloudinary_flutter/image/cld_image.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:sunday_school_attendance/app/services/cloudinary_service.dart';
import 'package:sunday_school_attendance/cloudinary_demo/image_detail_page.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _CloudinaryDemoState();
}

class _CloudinaryDemoState extends State<UploadPage> {
  FilePickerResult? _filePickerResult;

  void _openFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'mp4'],
      type: FileType.custom,
    );
    setState(() {
      _filePickerResult = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CldImageWidget(
            publicId: 'cld-sample-4',
            cloudinary: Cloudinary.fromCloudName(
              cloudName: CloudinaryService().cloudName,
            ),
          ),
          ElevatedButton(
              onPressed: () {
                if (_filePickerResult != null && context.mounted) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ImageDetailPage(selectedFile: _filePickerResult!),
                    ),
                  );
                }
              },
              child: Text('Upload Page')),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openFilePicker();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
