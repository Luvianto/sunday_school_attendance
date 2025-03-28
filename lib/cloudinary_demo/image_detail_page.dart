import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:sunday_school_attendance/app/services/cloudinary_service.dart';

class ImageDetailPage extends StatefulWidget {
  final FilePickerResult selectedFile;
  const ImageDetailPage({super.key, required this.selectedFile});

  @override
  State<ImageDetailPage> createState() => _ImageEditorPageState();
}

class _ImageEditorPageState extends State<ImageDetailPage> {
  final cloudinaryService = CloudinaryService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              readOnly: true,
              initialValue: widget.selectedFile.files.first.name,
              decoration: InputDecoration(
                label: Text('Name'),
              ),
            ),
            TextFormField(
              readOnly: true,
              initialValue: widget.selectedFile.files.first.extension,
              decoration: InputDecoration(
                label: Text('Extension'),
              ),
            ),
            TextFormField(
              readOnly: true,
              initialValue: '${widget.selectedFile.files.first.size} bytes',
              decoration: InputDecoration(
                label: Text('Size'),
              ),
            ),
            SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                  ),
                ),
                SizedBox(width: 24.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      final result = await cloudinaryService
                          .uploadProfilePicture(widget.selectedFile);
                      if (result) {
                        debugPrint('Good job');
                        // Navigator.pop(context);
                      } else {
                        debugPrint('Not good job');
                      }
                    },
                    child: Text('Upload'),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
