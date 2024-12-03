import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/constants/colors.dart';
import '../../../core/helpers/helper.dart';
import '../../../view-model/user_prefrences.dart';
import '../../authentication/login/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImagePicker _picker = ImagePicker();
  String? profileImageUrl;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      profileImageUrl = userDoc['profileImage'] ?? '';
    });
  }

  Future<void> _chooseProfileImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      await _uploadImageToStorage(imageFile);
    }
  }

  Future<void> _uploadImageToStorage(File imageFile) async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final ref = FirebaseStorage.instance
          .ref()
          .child('profileImages')
          .child('$userId.jpg');

      await ref.putFile(imageFile);
      final imageUrl = await ref.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({'profileImage': imageUrl});

      setState(() {
        profileImageUrl = imageUrl;
      });
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: dark ? AppColors.dark : AppColors.light,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context, dark),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildProfileHeader(context, dark),
                  const SizedBox(height: 24),
                  _buildAboutMe(dark),
                  const SizedBox(height: 24),
                  _buildTripHistory(dark),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, bool isDarkMode) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          var userData = snapshot.data!.data() as Map<String, dynamic>;
          String userName = userData['name'];
          return Column(
            children: [
              GestureDetector(
                onTap: _chooseProfileImage,
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: profileImageUrl != null && profileImageUrl!.isNotEmpty
                      ? NetworkImage(profileImageUrl!)
                      : const AssetImage('assets/images/default_avatar.png') as ImageProvider,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                userName,
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Traveler',
                style: TextStyle(
                  color: isDarkMode ? Colors.white70 : Colors.black54,
                  fontSize: 16,
                ),
              ),
            ],
          );
        }
      },
    );
  }

  // _buildAppBar, _buildAboutMe, _buildTripHistory, and _showDrawer functions remain the same


  Widget _buildAppBar(BuildContext context, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.menu, color: isDarkMode ? Colors.white : Colors.black),
            onPressed: () => _showDrawer(context, isDarkMode),
          ),
          Text(
            'Profile',
            style: TextStyle(
              color: isDarkMode ? Colors.white : Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 40), // For balance
        ],
      ),
    );
  }

  Widget _buildAboutMe(bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[800]!.withOpacity(0.5) : Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About Me',
            style: TextStyle(
              color: isDarkMode ? Colors.white : Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'I love to explore new places and always seeking beauty of this World',
            style: TextStyle(
              color: isDarkMode ? Colors.white70 : Colors.black54,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTripHistory(bool isDarkMode) {
    return GestureDetector(
      onTap: () {
        // Navigate to Trip History screen
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey[800]!.withOpacity(0.5) : Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'View Trip History',
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  void _showDrawer(BuildContext context, bool isDarkMode) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.grey[900] : Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: ListView(
            children: [
              ListTile(
                leading: Icon(Icons.person, color: isDarkMode ? Colors.white : Colors.black87),
                title: Text('My Profile', style: TextStyle(color: isDarkMode ? Colors.white : Colors.black87)),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.earthAmericas, color: isDarkMode ? Colors.white : Colors.black87),
                title: Text('Saved Trip', style: TextStyle(color: isDarkMode ? Colors.white : Colors.black87)),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: Icon(Icons.workspace_premium, color: isDarkMode ? Colors.white : Colors.black87),
                title: Text('Go Premium', style: TextStyle(color: isDarkMode ? Colors.white : Colors.black87)),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.shieldHalved, color: isDarkMode ? Colors.white : Colors.black87),
                title: Text('Privacy Policies', style: TextStyle(color: isDarkMode ? Colors.white : Colors.black87)),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.arrowRightFromBracket, color: isDarkMode ? Colors.white : Colors.black87),
                title: Text('LogOut', style: TextStyle(color: isDarkMode ? Colors.white : Colors.black87)),
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  await UserPreferences.clearLoginStatus();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
