import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:uet_app/admin/departments.dart';

class StudentPage extends StatefulWidget {
  const StudentPage({Key? key}) : super(key: key);

  @override
  _StudentPageState createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  final List<String> carouselImagePaths = [
    'assets/images/img1.jpg',
    'assets/images/img2.jpg',
    'assets/images/img3.jpg',
    'assets/images/img4.jpg',
    'assets/images/img5.jpg',
    'assets/images/img6.jpg',
    'assets/images/img8.jpg',
  ];

  int currentIndex = 0;
  late PageController _pageController;
  late User _user; // Declare User object to store logged-in user data
  late String _userName = ''; // Initialize user name to empty string

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    startAnimation();
    _user =
        FirebaseAuth.instance.currentUser!; // Get the current logged-in user
    _loadUserData(); // Load user data from Firestore
  }

  void startAnimation() {
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        currentIndex = (currentIndex + 1) % carouselImagePaths.length;
        _pageController.animateToPage(
          currentIndex,
          duration: Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
        startAnimation();
      });
    });
  }

  void _loadUserData() async {
    // Retrieve user data from Firestore
    DocumentSnapshot userData = await FirebaseFirestore.instance
        .collection('students')
        .doc(_user.uid)
        .get();

    setState(() {
      _userName = userData['name']; // Update user name
    });
  }

  void navigateToTourScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Departments(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title:
            Text('Welcome, $_userName'), // Display personalized welcome message
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: AnimatedContainer(
              duration: Duration(seconds: 1),
              alignment: Alignment.center,
              child: PageView.builder(
                itemCount: carouselImagePaths.length,
                controller: _pageController,
                itemBuilder: (context, index) {
                  return Image.asset(
                    carouselImagePaths[index],
                    fit: BoxFit.contain,
                    width: screenWidth,
                    height: 200,
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: navigateToTourScreen,
            child: Text('Tour'),
          ),
        ],
      ),
    );
  }
}
