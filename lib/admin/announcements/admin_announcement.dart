import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as Path;

class AdminAnnouncement extends StatefulWidget {
  const AdminAnnouncement({Key? key}) : super(key: key);

  @override
  _AdminAnnouncementState createState() => _AdminAnnouncementState();
}

class _AdminAnnouncementState extends State<AdminAnnouncement> {
  File? _pdf;

  Future<void> _pickPDF() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      if (result != null) {
        setState(() {
          _pdf = File(result.files.single.path!);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No PDF selected')),
        );
      }
    } catch (e) {
      print('Error picking PDF: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick PDF')),
      );
    }
  }

  Future<void> _uploadPDF() async {
    try {
      if (_pdf != null) {
        String fileName = Path.basename(_pdf!.path);
        Reference firebaseStorageRef =
            FirebaseStorage.instance.ref().child('pdfs/$fileName');
        UploadTask uploadTask = firebaseStorageRef.putFile(_pdf!);
        await uploadTask.whenComplete(() => print('PDF Uploaded'));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No PDF selected')),
        );
      }
    } catch (e) {
      print('Error uploading PDF: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload PDF')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Announcement Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _pdf != null
                ? Text('Selected PDF: ${Path.basename(_pdf!.path)}')
                : Text('No PDF selected'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickPDF,
              child: Text('Select PDF'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadPDF,
              child: Text('Upload PDF to Firebase'),
            ),
          ],
        ),
      ),
    );
  }
}
