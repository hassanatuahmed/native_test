import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  ImageInput(this.onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  var _storedImage;
    final ImagePicker _picker = ImagePicker();


  Future<void> _takePicture() async {

     final XFile? imageFile = await _picker.pickImage(source: ImageSource.camera);
    //  var imageFile = await ImagePicker.pickImage(
    //   source: ImageSource.camera,
    //   maxWidth: 600,
    // );
    if (imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = File(imageFile.path);
    });

  

    final appDir = await syspaths.getApplicationDocumentsDirectory();
    print("hello");
    print(appDir);
    final fileName = path.basename(imageFile.path);
    //File fileName = File(appDir.path + 'fileName');
    final savedImage = await File(imageFile.path).copy('${appDir.path}/$fileName');
    //File file = File(savedImage.path);
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  'No Image Taken',
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: FlatButton.icon(
            icon: Icon(Icons.camera),
            label: Text('Take Picture'),
            textColor: Theme.of(context).primaryColor,
            onPressed: _takePicture,
          ),
        ),
      ],
    );
  }
}
