import 'package:elearning_app/pages/login_page.dart';
import 'package:flutter/material.dart';
class OnboardingNext extends StatelessWidget {
  const OnboardingNext({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             
              Image.asset(
                'assets/icons/onboard/nextpage.png', 
                height: 200, 
              ),
              
              SizedBox(height: 20),

              const Text(
                'Enjoy games, activities, and more to help you learn',
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              
              SizedBox(height: 30),

             
              ElevatedButton(
                
                child: const Text('Next'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ), onPressed: () { 
                   Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()), 
                  );
                 },
              ),
            ],
          ),
        ),
      ),
    );
  }
}