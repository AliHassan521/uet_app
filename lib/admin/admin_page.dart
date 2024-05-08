import 'package:flutter/material.dart';
import 'package:uet_app/admin/announcements/admin_announcement.dart';

import 'package:uet_app/admin/departments.dart';
import 'package:uet_app/admin/announcements/event_announcement.dart'; // Import your EventAnnouncement page file
import 'package:uet_app/login.dart'; // Import your main login screen file

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
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

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    startAnimation();
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

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Page'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Admin Actions',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Event Announcement'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventAnnouncement(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Admin Announcement'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminAnnouncement(),
                  ),
                ); // Close the drawer
                // Navigate to admin announcement screen
              },
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Login(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: AnimatedContainer(
              duration: Duration(seconds: 1),
              alignment: Alignment.center,
              child: SizedBox(
                height: screenHeight * 0.5, // Reduce some height
                child: PageView.builder(
                  itemCount: carouselImagePaths.length,
                  controller: _pageController,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      carouselImagePaths[index],
                      fit: BoxFit.contain,
                    );
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Departments(),
                ),
              );
            },
            child: Text('Tour'),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
