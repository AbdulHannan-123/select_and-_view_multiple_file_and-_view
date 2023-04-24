import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:path/path.dart' as path;

void main() {
  runApp(WhatsAppClone());
}

class WhatsAppClone extends StatefulWidget {
  @override
  _WhatsAppCloneState createState() => _WhatsAppCloneState();
}

class _WhatsAppCloneState extends State<WhatsAppClone> {
  int _currentIndex = 0;
  List<File> _documents = [];
  File? docs;
    List<Map<String, dynamic>> filesInfo = [];

  void _pickDocuments() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'txt'],
      allowMultiple: true,
    );

if (result != null) {
  // selectedFiles = result.files.map((file) => File.fromRawPath(file.bytes!)).toList();
  setState(() {
    filesInfo = result.files.map((file) => {
    'name': file.name,
    'size': file.size,
    'path' : file.path
  }).toList();
  });
}
  }

  Widget _buildDocumentIcon() {
    return IconButton(
      icon: Icon(Icons.attach_file),
      onPressed: _pickDocuments,
    );
  }

  Widget _buildDocumentPreview() {
    print(filesInfo[0]['name']);
    return filesInfo.isNotEmpty
        ? ListView.builder(
            // shrinkWrap: true,
            itemCount: filesInfo.length,
            itemBuilder: (context, index) {
              File file = File(filesInfo[index]['path']);
              return ListTile(
                title: Text(filesInfo[index]['name'], style: TextStyle(color: Colors.black),overflow: TextOverflow.ellipsis,),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Scaffold(
                        appBar: AppBar(
                          title: Text(filesInfo[index]['name']),
                        ),
                        body: SfPdfViewer.file(file),
                      ),
                    ),
                  );
                },
              );
            },
          )
        : Text('No documents selected');
  }

  @override
  Widget build(BuildContext context) {
    log("message222222");
    print(filesInfo.length);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Documents'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
            _buildDocumentIcon(),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ],
        ),
        body: Center(
          child: _buildDocumentPreview(),
          // chil,
        ),
      ),
    );
  }
}
