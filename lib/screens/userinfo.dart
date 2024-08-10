import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Childtestpage.dart';

class UserInfoPage extends StatefulWidget {
  final String email;
  final String password;

  const UserInfoPage({super.key, required this.email, required this.password});

  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  String _disability = 'None';

  Future<void> _submitDetails() async {
    final String name = _nameController.text;
    final String age = _ageController.text;
    final String disability = _disability;
    
    print('Submitting: Email: ${widget.email}, Password: ${widget.password}, Name: $name, Age: $age, Disability: $disability');
    // Send request to the backend
    final response = await http.post(
      Uri.parse('http://10.0.2.2:3001/user'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'email': widget.email,
        'password': widget.password,
        'childage': age,
        'childname': name,
        'childdisability': disability,
      }),
    );

    if (response.statusCode == 201) {
      // Handle success
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChildTestPage()),
      );
    } else {
      // Show error if submission fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Submission failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://img.rawpixel.com/s3fs-private/rawpixel_images/website_content/v1015-111c-kstoqf1a.jpg?w=800&dpr=1&fit=default&crop=default&q=65&vib=3&con=3&usm=15&bg=F4F4F3&ixlib=js-2.2.1&s=f016449eaa797aebe6ad6b921eaaf502',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const SizedBox(height: 60.0),
                    const Text(
                      "Enter Your Child Details",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: "Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Colors.blue.withOpacity(0.1),
                        filled: true,
                        prefixIcon: const Icon(Icons.person),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _ageController,
                      decoration: InputDecoration(
                        hintText: "Age",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Colors.blue.withOpacity(0.1),
                        filled: true,
                        prefixIcon: const Icon(Icons.calendar_today),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      value: _disability,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Colors.blue.withOpacity(0.1),
                        filled: true,
                        prefixIcon: const Icon(Icons.accessibility),
                      ),
                      items: const [
                        DropdownMenuItem(value: 'None', child: Text('None')),
                        DropdownMenuItem(value: 'Visual', child: Text('Visual')),
                        DropdownMenuItem(value: 'Hearing', child: Text('Hearing')),
                        DropdownMenuItem(value: 'Motor', child: Text('Motor')),
                        DropdownMenuItem(value: 'Other', child: Text('Other')),
                      ],
                      onChanged: (String? newValue) {
                        setState(() {
                          _disability = newValue!;
                        });
                      },
                      hint: const Text('Select Disability'),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _submitDetails,
                      child: const Text(
                        "Submit",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
