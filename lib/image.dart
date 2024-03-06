




import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class image extends StatefulWidget {
  const image({super.key});

  @override
  State<image> createState() => _imageState();
}

class _imageState extends State<image> {
  Uint8List? _image;
  File? selectedIMage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          children: [
            _image != null
              ? CircleAvatar(
              radius: 100,
              backgroundImage: MemoryImage(_image!))
            : const  CircleAvatar(
            radius: 100,
      ),
            Positioned(
              bottom: -0,
                left: 140,
                child: IconButton(onPressed: (){
                  showImagePickerOption(context);
                },icon:const Icon(Icons.add_a_photo),))
          ],
        ),
      ),
    );
  }
  void showImagePickerOption(BuildContext context){
   showModalBottomSheet(
     backgroundColor: Colors.blue[100],
       context: context, builder: (builder){
     return Padding(
       padding: const EdgeInsets.all(18.0),
       child: SizedBox(
        width: MediaQuery.of(context).size.width,
         height: MediaQuery.of(context).size.height/4.5,
         child: Row(
           children: [
             Expanded(
               child: InkWell(
                 onTap: (){
                   _picImageFromGallery();
                 },
                 child:const SizedBox(
                   child: Column(
                     children: [
                       Icon(Icons.image,size: 70,),
                       Text('Gallery')
                     ],
                   ),
                 ),
               ),
             ),
             Expanded(
               child: InkWell(
                 onTap: (){
                   _picImageFromCemra();
                 },
                 child: SizedBox(
                   child: Column(
                     children: [
                       Icon(Icons.camera_alt,size: 70,),
                       Text('Camera')
                     ],
                   ),
                 ),
               ),
             )
           ],
         ),
       ),
     );

   });
  }
  Future _picImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if(returnImage == null)return;
    setState(() {
      selectedIMage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });

  }
  Future _picImageFromCemra() async {
    final returnImage =
    await ImagePicker().pickImage(source: ImageSource.camera);
    if(returnImage == null)return;
    setState(() {
      selectedIMage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });

  }
  var request =  http.MultipartRequest(
      'POST', Uri.parse(myurl)

  );
  //Header....
  request.headers['Authorization'] ='bearer $authorizationToken';

  request.fields['PropertyName'] = propertyName;
  request.fields['Country'] = country.toString();
  request.fields['Description'] = des;
  request.fields['State'] = state.toString();
  request.files.add(http.MultipartFile.fromBytes(
  'ImagePaths',
  learnImage,
  filename: 'some-file-name.jpg',
  contentType: MediaType("image", "jpg"),
  )
  );
  var response = await request.send();
  print(response.stream);
  print(response.statusCode);
  final res = await http.Response.fromStream(response);
  print(res.body);
}
