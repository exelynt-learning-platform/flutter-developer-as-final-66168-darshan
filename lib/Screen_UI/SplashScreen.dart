import 'package:employeeapp/Screen_UI/EmployeeDashboardScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login_screen.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _animation;
  Timer? _timer;


  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();

    checkUser();
  }


  void checkUser() {

    _timer = Timer(
      const Duration(seconds: 2),
          () {

        if (!mounted) return;

        final user = FirebaseAuth.instance.currentUser;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => user != null
                ? const EmployeeDashboardScreen()
                : const LoginScreen(),
          ),
        );

      },
    );

  }


  @override
  void dispose() {

    _timer?.cancel();

    _controller.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff2563EB),
              Color(0xff1E40AF),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: FadeTransition(
          opacity: _animation,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              Container(
                height: 110,
                width: 110,

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 20,
                      offset: const Offset(0,10),
                    )
                  ],
                ),

                child: const Icon(
                  Icons.groups_rounded,
                  size: 60,
                  color: Color(0xff2563EB),
                ),
              ),


              const SizedBox(height: 35),


              const Text(
                "Employee Manager",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),


              const SizedBox(height: 10),


              Text(
                "Manage employees smarter",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.85),
                  fontSize: 15,
                ),
              ),


              const SizedBox(height: 45),


              const SizedBox(
                height: 28,
                width: 28,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.white,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}