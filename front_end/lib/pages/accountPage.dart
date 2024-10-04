import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:front_end/logic/httpReq.dart';
import 'package:front_end/logic/userSingleTon.dart';
import 'package:front_end/model/user.dart';
import 'package:front_end/widgets/constants.dart';
import 'package:front_end/widgets/customButton.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:front_end/widgets/userShower.dart';
import 'package:front_end/widgets/uploadPopUp.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/services.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final ImagePicker _picker = ImagePicker();
  File? _image;
  String? _uploadedImageUrl;
  User? user = UserSingleton.getUser();

  @override
  void initState() {
    super.initState();
    _fetchUserImage();
  }

  Future<String> uploadImage(File image, int id) async {
    final uri = Uri.parse('https://your-server-url/upload/$id');
    final request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath(
        'image',
        image.path,
        contentType: MediaType('image', 'jpeg'),
      ));

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final data = jsonDecode(responseData);
        return data['image_url'];
      } else {
        throw Exception('Failed to upload image: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Image upload failed: $e');
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      try {
        final imageUrl = await uploadImage(_image!, user!.userId);
        setState(() {
          _uploadedImageUrl = imageUrl;
        });
        _showUploadPopup('Image uploaded successfully!', true);
      } catch (e) {
        _showUploadPopup('Failed to upload image: $e', false);
      }
    }
  }

  Future<void> _fetchUserImage() async {
    final uri = Uri.parse('https://your-server-url/user/${user!.userId}');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _uploadedImageUrl = data['image_url'];
      });
    } else {
      print('Failed to fetch user image');
    }
  }

  void _showUploadPopup(String message, bool isSuccess) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return UploadPopup(
          message: message,
          isSuccess: isSuccess,
          onPressed: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  void _logout() {
    print("User logged out");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(backgroundColor),
          title: const Text(
            'Logout',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
            ),
          ),
          content: const Text(
            'You have been logged out.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 18,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showAddCarDialog() {
    String part1 = ''; // First part (2 letters)
    String part2 = ''; // Second part (2 numbers)
    String part3 = ''; // Third part (3 letters)

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            'Add Car',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          content: Row(
            children: [
              Expanded(
                flex: 2,
                child: TextField(
                  maxLength: 2,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp("[A-Z]")), // Only letters
                  ],
                  onChanged: (value) {
                    part1 = value;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Letter',
                    counterText: '',
                    labelStyle: TextStyle(color: Colors.grey),
                  ),
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: TextField(
                  maxLength: 2,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChanged: (value) {
                    part2 = value;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Number',
                    counterText: '',
                    labelStyle: TextStyle(color: Colors.grey),
                  ),
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 3,
                child: TextField(
                  maxLength: 3,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[A-Z]")),
                  ],
                  onChanged: (value) {
                    part3 = value;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Letter',
                    counterText: '',
                    labelStyle: TextStyle(color: Colors.grey),
                  ),
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.redAccent,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final String numberPlate = '$part1$part2$part3';

                if (part1.length == 2 &&
                    part2.length == 2 &&
                    part3.length == 3) {
                  try {
                    bool answer = await sendNumberPlate(numberPlate);
                    print("answer = $answer");
                    setState(() {});
                    Navigator.of(context).pop();
                    _showUploadPopup('Car added successfully!', true);
                  } catch (e) {
                    Navigator.of(context).pop();
                    _showUploadPopup('Failed to add car: $e', false);
                  }
                } else {
                  _showUploadPopup('Please fill all fields correctly.', false);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(itemColorHighlighted),
                foregroundColor: Colors.white,
              ),
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 100,
                      height: 80,
                      decoration: const BoxDecoration(
                        color: Color(backgroundColor),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(200),
                          bottomRight: Radius.circular(200),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: _pickImage, // Open image picker when tapped
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 4),
                        ),
                        child: Center(
                          child: CircleAvatar(
                            radius: 100,
                            backgroundColor: const Color(itemColorHighlighted),
                            backgroundImage: _uploadedImageUrl != null
                                ? NetworkImage(_uploadedImageUrl!)
                                : (_image != null ? FileImage(_image!) : null),
                            child: _uploadedImageUrl == null && _image == null
                                ? const Icon(Icons.person,
                                    size: 60, color: Colors.black)
                                : null,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                OutlinedButton(
                  onPressed: _logout,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.red),
                  ),
                  child: const Text(
                    "Logout",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                const SizedBox(height: 5),
                Expanded(
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      const UserShower(),
                      CustomElevatedButton(
                          width: 400,
                          height: 50,
                          minHeight: 50,
                          onPressed: _showAddCarDialog,
                          label: "Add Car"),
                      const SizedBox(height: 10),
                    ],
                  )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
