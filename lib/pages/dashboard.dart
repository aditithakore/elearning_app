// ignore_for_file: prefer_const_constructors

import 'package:elearning_app/pages/literacy.dart';
import 'package:elearning_app/pages/numeracy.dart';
import 'package:elearning_app/pages/socialskills.dart';
import 'package:elearning_app/pages/stimulus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard',
        style: TextStyle(
                      fontSize: 32,
                      fontFamily: 'Baloo 2',
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        toolbarHeight: width * 0.08,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            gradient: LinearGradient(
              colors: [
                Colors.blue.shade100,
                Colors.blue.shade200,
                Colors.blue.shade300
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
              tileMode: TileMode.mirror,
            ),
          ),
        ),
        // leading: Positioned(
        //   left:30,  // Use margin to move the icon away from the border
        //   child: CircleAvatar(
        //     backgroundImage: AssetImage('assets/icons/set.png'),
        //     radius: 20, // Adjust the size as needed
        //     backgroundColor: Colors.transparent,
        //   ),
        // ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 40),
            child: IconButton(
              icon: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.black, // Border color
                    width: 1.0, // Border width
                  ),
                ),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/icons/P1.png'),
                  radius: 30, // Adjust the size as needed
                  backgroundColor: Colors.transparent,
                ),
              ),
              onPressed: () {
                // Add navigation to profile screen here
              },
            ),
          ),
        ],
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            color: Colors.blue.shade50,
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: SizedBox(
              height: height * 0.8,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(width: 16.0),
                  _buildModule(
                    context: context,
                    title: 'Literacy Module',
                    icon: AssetImage('assets/icons/literacy.png'),
                    color: Colors.blue,
                    onTap: (){
                      Get.to(() => Literacy());
                    },
                  ),
                  SizedBox(width: 16.0),
                  _buildModule(
                    context: context,
                    title: 'Numeracy Module',
                    icon: AssetImage('assets/icons/numeracy.png'),
                    color: Colors.green,
                    onTap: (){
                      Get.to(() => Numeracy());
                    },
                  ),
                  SizedBox(width: 16.0),
                  _buildModule(
                    context: context,
                    title: 'Social Skill Module',
                    icon: AssetImage('assets/icons/social.png'),
                    color: Colors.orange,
                    onTap: (){
                      Get.to(() => SocialSkills());
                    },
                  ),
                  SizedBox(width: 16.0),
                  _buildModule(
                    context: context,
                    title: 'Stimuli Training',
                    icon: AssetImage('assets/icons/stimuli.png'),
                    color: Colors.orange,
                    onTap: (){
                      Get.to(() => Stimulus());
                    },
                  ),
                  // Add more modules here if needed
                ],
              ),
            ).marginOnly(left: 0.0, top: width * 0.03, right: 0.0, bottom: 0.0),
          ),
          Positioned(
            bottom: width * 0.01,
            left: height * 0.02,
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/icons/set.png'),
              radius: 30, // Adjust the size as needed
              backgroundColor: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModule({
    required BuildContext context,
    required String title,
    required AssetImage icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    final boxSize = MediaQuery.of(context).size.width * 0.21; // Container width
    final imageSize = boxSize * 0.95; // Image size larger than the box

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: boxSize,
                height: boxSize,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8.0,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: -imageSize * 0.01, // Adjust to move the image to the left
                top: -imageSize * 0.02, // Adjust to move the image upwards
                child: Image(
                  image: icon,
                  width: imageSize,
                  height: imageSize,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Text(
            title,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }
}
