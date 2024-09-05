import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:front_end/widgets/constants.dart';
import 'package:front_end/widgets/customButton.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:front_end/widgets/userShower.dart';
import 'package:front_end/widgets/uploadPopUp.dart';
import 'package:http_parser/http_parser.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final ImagePicker _picker = ImagePicker();
  File? _image;
  String? _uploadedImageUrl;
  final String _userId = '1'; // Replace with actual user ID

  @override
  void initState() {
    super.initState();
    _fetchUserImage();
  }

  Future<String> uploadImage(File image, int id) async {
    final uri = Uri.parse(
        'https://your-server-url/upload/$id'); // Replace with your server URL
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
        return data[
            'image_url']; // Extract and return the image URL from response
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
        final imageUrl = await uploadImage(_image!, int.parse(_userId));
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
    final uri = Uri.parse(
        'https://your-server-url/user/$_userId'); // Replace with your server URL
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

  // Mock Logout Function
  void _logout() {
    print("User logged out");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor:
              const Color(backgroundColor), // Set dialog background color
          title: const Text(
            'Logout',
            style: TextStyle(
              color: Colors.white, // Set title text color
              fontSize: 22,
            ),
          ),
          content: const Text(
            'You have been logged out.',
            style: TextStyle(
              color: Colors.white70, // Set content text color
              fontSize: 18,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Colors.redAccent, // Customize button text color
                  fontWeight: FontWeight.bold,
                ),
              ),
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
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      decoration: const BoxDecoration(
                        color: Color(backgroundColor),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(200),
                          bottomRight: Radius.circular(200),
                        ),
                      ),
                    ),
                    // Profile Avatar
                    GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Color(itemColorHighlighted),
                        backgroundImage: _uploadedImageUrl != null
                            ? NetworkImage(_uploadedImageUrl!)
                            : (_image != null ? FileImage(_image!) : null),
                        child: _uploadedImageUrl == null && _image == null
                            ? const Icon(Icons.person,
                                size: 60, color: Colors.black)
                            : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Logout button with the logout functionality
                OutlinedButton(
                  onPressed: _logout, // Triggers the logout function
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.red),
                  ),
                  child: const Text(
                    "Logout",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: AutoSizeText(
                    "  Details",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      UserShower(int.parse(_userId)),
                      CustomElevatedButton(
                          width: 400,
                          height: 50,
                          minHeight: 50,
                          onPressed: () {},
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
