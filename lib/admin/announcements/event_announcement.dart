import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart'; // Add this import

class EventAnnouncement extends StatefulWidget {
  const EventAnnouncement({Key? key}) : super(key: key);

  @override
  State<EventAnnouncement> createState() => _EventAnnouncementState();
}

class _EventAnnouncementState extends State<EventAnnouncement> {
  List<Map<String, dynamic>> pdfData = [];
  int? selectedIndex; // Track selected index
  bool isLoading = false;

  Future<String> uploadPdf(String fileName, File file) async {
    try {
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('event/$fileName.pdf');
      firebase_storage.UploadTask uploadTask = ref.putFile(file);
      await uploadTask.whenComplete(() {});
      String url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      print("Error uploading file: $e");
      return "";
    }
  }

  void pickFile() async {
    final pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (pickedFile != null) {
      setState(() {
        isLoading = true;
      });

      String fileName = pickedFile.files.single.name!;
      List<int> fileBytes = pickedFile.files.single.bytes!;
      Uint8List fileUint8List = Uint8List.fromList(fileBytes);
      File file = File.fromRawPath(fileUint8List);
      final url = await uploadPdf(fileName, file);
      if (url.isNotEmpty) {
        print("File uploaded successfully");
        setState(() {
          pdfData.add({"name": fileName, "url": url});
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Announcement Page'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    itemCount: pdfData.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(8),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(),
                              color: selectedIndex == index
                                  ? Colors.grey.withOpacity(0.5)
                                  : null,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                  'assets/images/pdf.png',
                                  height: 100,
                                  width: 100,
                                ),
                                Text(
                                  pdfData[index]['name'],
                                  style: TextStyle(fontSize: 18),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                if (selectedIndex != null)
                  Expanded(
                    child: PDFView(
                      filePath: pdfData[selectedIndex!]['url'],
                    ),
                  ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.upload_file),
        onPressed: pickFile,
      ),
    );
  }
}
