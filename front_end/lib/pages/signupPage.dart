import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:front_end/widgets/constants.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String confirmPassword = '';
  String phoneNumber = '';
  bool isLoading = false;
  String error = '';
  String captchaText = '';
  String userCaptchaInput = '';

  @override
  void initState() {
    super.initState();
    _generateCaptcha();
  }

  void _generateCaptcha() {
    final random = Random();
    captchaText =
        List.generate(5, (_) => String.fromCharCode(random.nextInt(26) + 65))
            .join();
  }

  Future<void> _showCaptchaDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('CAPTCHA Verification'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(16.0),
                color: Colors.white,
                child: Center(
                  child: Stack(
                    children: [
                      CustomPaint(
                        size: const Size(double.infinity, 40),
                        painter: CaptchaPainter(captchaText),
                      ),
                      Center(
                        child: Text(
                          captchaText,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Enter CAPTCHA',
                  labelStyle: const TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.green, width: 2.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    userCaptchaInput = value;
                  });
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter CAPTCHA';
                  }
                  return null;
                },
              )
            ],
          ),
          actions: <Widget>[
            TextButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.green,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                if (userCaptchaInput.toUpperCase() == captchaText) {
                  Navigator.of(context).pop();
                  _signUpUser();
                } else {
                  setState(() {
                    error = 'CAPTCHA verification failed. Please try again.';
                  });
                }
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _signUpUser() async {
    const url = 'http://localhost:8080/register';
    setState(() {
      isLoading = true;
      error = '';
    });
    Map<String, dynamic> dataToSend = {
      'email': email,
      'password': password,
      'phone': phoneNumber
    };

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(dataToSend),
    );
    print(dataToSend);
    if (response.statusCode == 200) {
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      setState(() {
        error = 'Sign-up failed. Please try again.';
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final logoSize = MediaQuery.of(context).size.width * 0.3;
    return Scaffold(
      backgroundColor: const Color(backgroundLogColor),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 50),
                  SvgPicture.asset(
                    'lib/assets/icons/logoV2.svg',
                    height: logoSize,
                    width: logoSize,
                  ),
                  const Text(
                    'WELCOME!',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Email Input Field
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'E-mail',
                      labelStyle: const TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      }
                      // Email format validation
                      if (!RegExp(
                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                          .hasMatch(value)) {
                        return 'Please enter a valid email (e.g., example@domain.com)';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  // Phone Number Input Field
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      labelStyle: const TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    keyboardType: TextInputType.phone,
                    onChanged: (value) {
                      setState(() {
                        phoneNumber = value;
                      });
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      // Phone number format validation
                      if (!RegExp(r'^07\d{8}$').hasMatch(value)) {
                        return 'Phone number must be 10 digits and start with 07';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  // Password Input Field
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: const TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    obscureText: true,
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      }
                      // Password length validation
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  // Confirmation Password Input Field
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      labelStyle: const TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    obscureText: true,
                    onChanged: (value) {
                      setState(() {
                        confirmPassword = value;
                      });
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please confirm your password';
                      }
                      // Confirm password match validation
                      if (value != password) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  if (error.isNotEmpty)
                    Text(
                      error,
                      style: const TextStyle(color: Colors.red),
                    ),
                  const SizedBox(height: 10),
                  isLoading
                      ? SizedBox(
                          width: double.infinity,
                          child: LinearProgressIndicator(
                            color: Colors.green,
                            backgroundColor: Colors.white54,
                          ),
                        )
                      : SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _showCaptchaDialog();
                              }
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: const Text(
                      "Already have an account? Log In",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('or', style: TextStyle(color: Colors.white)),
                  const SizedBox(height: 20),
                  // Social Media Buttons
                  _buildSocialButton(
                      'Sign Up with Gmail', 'lib/assets/icons/google.svg'),
                  const SizedBox(height: 2),
                  _buildSocialButton(
                      'Sign Up with an Apple ID', 'lib/assets/icons/apple.svg'),
                  const SizedBox(height: 2),
                  _buildSocialButton(
                      'Sign Up with Facebook', 'lib/assets/icons/facebook.svg'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton(String text, String iconPath) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onPressed: () {
          // Handle social sign-up logic here
        },
        icon: SvgPicture.asset(
          iconPath,
          height: 24.0,
          width: 24.0,
        ),
        label: Text(text),
      ),
    );
  }
}

class CaptchaPainter extends CustomPainter {
  final String captchaText;
  CaptchaPainter(this.captchaText);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final random = Random();

    // Calculate the center point of the canvas
    double centerX = size.width / 2;
    double centerY = size.height / 2;

    // Draw two diagonal lines from the center
    for (int i = 0; i < 2; i++) {
      // Random length
      double length = random.nextDouble() * 60 + 10;

      // Random angle in radians
      double angle = random.nextDouble() * 2 * pi;

      // Calculate the end position based on the angle and length
      double endX = centerX + length * cos(angle);
      double endY = centerY + length * sin(angle);

      // Draw the line
      canvas.drawLine(Offset(centerX, centerY), Offset(endX, endY), paint);
    }

    // Draw three random diagonal lines
    for (int i = 0; i < 3; i++) {
      // Random length
      double length = random.nextDouble() * 60 + 10;

      // Random angle in radians
      double angle = random.nextDouble() * 2 * pi;

      // Calculate the end position based on the angle and length
      double endX = centerX + length * cos(angle);
      double endY = centerY + length * sin(angle);

      // Draw the line
      canvas.drawLine(Offset(centerX, centerY), Offset(endX, endY), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
