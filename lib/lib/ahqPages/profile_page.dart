import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user_data.dart';

// Global Profile Data Manager - This persists across page navigation
class ProfileDataManager {
  static final ProfileDataManager _instance = ProfileDataManager._internal();
  factory ProfileDataManager() => _instance;
  ProfileDataManager._internal();

  // //   // This data persists across the entire app session
  //   Map<String, String> savedData = {
  //     'name': 'Rafid Kabir',
  //     'phone': '+880 1769 XXXXX',
  //     'email': 'rafid.kabir@army.mil.bd',
  //     'location': 'Rangpur Cantonment',
  //     'rank': 'Lieutenant',
  //     'unit': '1 Signal Battalion',
  //     'serviceNumber': 'BA-12039',
  //     'emergencyContact': '+880 1700 XXXXX',
  //   };

  // Map<String, bool> starStatus = {
  //     'name': false,
  //     'phone': true,
  //     'email': false,
  //     'location': false,
  //     'rank': true,
  //     'unit': false,
  //     'serviceNumber': false,
  //     'emergencyContact': true,
  //   };

  Map<String, String> savedData = {
    'name': '',
    'phone': '',
    'email': '',
    'location': '',
    'rank': '',
    'unit': '',
    'serviceNumber': '',
    'emergencyContact': '',
  };

  Map<String, bool> starStatus = {
    'name': false,
    'phone': false,
    'email': false,
    'location': false,
    'rank': false,
    'unit': false,
    'serviceNumber': false,
    'emergencyContact': false,
  };

  void updateData(String key, String value) {
    savedData[key] = value;
  }

  void updateStarStatus(String key, bool status) {
    starStatus[key] = status;
    print(key);
    print(status);
  }

  void deleteField(String key) {
    savedData[key] = '';
    starStatus[key] = false;
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  bool isEditing = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  // Get the global profile data manager
  final ProfileDataManager _profileManager = ProfileDataManager();
  // Controllers for editable fields
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController locationController;
  late TextEditingController rankController;
  late TextEditingController unitController;
  late TextEditingController serviceNumberController;
  late TextEditingController emergencyContactController;

  Future<void> updateStarStatus(String field) async {
    try {
      await FirebaseFirestore.instance.collection('user').doc(UserData.uid).set(
        {
          'stars': {field: _profileManager.starStatus[field]},
        },
        SetOptions(merge: true),
      );

      print('Profile updated successfully in Firebase.');
    } catch (e) {
      print('Error updating profile in Firebase: $e');
    }
  }

  Future<void> fetchProfileInfo(String userId) async {
    try {
      // Fetch the user's profile document from Firestore
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('user')
          .doc(UserData.uid)
          .get();

      if (userDoc.exists) {
        final data = userDoc.data() as Map<String, dynamic>?;
        _profileManager.savedData = {
          'name': data?['name'] ?? '',
          'phone': data?['contact'] ?? '',
          'email': data?['email'] ?? '',
          'location': data?['location'] ?? '',
          'rank': data?['rank'] ?? '',
          'unit': data?['unitName'] ?? '',
          'serviceNumber': data?['idNumber'] ?? '',
          'emergencyContact': data?['contact'] ?? '',
        };

        final starStatusList = (data?['stars'] as Map?)
            ?.cast<String, dynamic>();
        print(starStatusList);

        setState(() {
          if (starStatusList != null && starStatusList.isNotEmpty) {
            starStatusList.forEach((key, value) {
              _profileManager.updateStarStatus(key, value);
            });
          }

          _initializeControllers();
        });
      } else {
        print('No profile found for userId: $userId');
      }
    } catch (e) {
      print('Error fetching profile info: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchProfileInfo(UserData.uid);
    });
    // Initialize controllers with saved data
    _initializeControllers();
  }

  void _initializeControllers() {
    // Load data from global profile manager
    nameController = TextEditingController(
      text: _profileManager.savedData['name']!,
    );
    phoneController = TextEditingController(
      text: _profileManager.savedData['phone']!,
    );
    emailController = TextEditingController(
      text: _profileManager.savedData['email']!,
    );
    locationController = TextEditingController(
      text: _profileManager.savedData['location']!,
    );
    rankController = TextEditingController(
      text: _profileManager.savedData['rank']!,
    );
    unitController = TextEditingController(
      text: _profileManager.savedData['unit']!,
    );
    serviceNumberController = TextEditingController(
      text: _profileManager.savedData['serviceNumber']!,
    );
    emergencyContactController = TextEditingController(
      text: _profileManager.savedData['emergencyContact']!,
    );
  }

  Future<void> updateProfile() async {
    try {
      await FirebaseFirestore.instance
          .collection('user')
          .doc(UserData.uid)
          .update({
            'name': nameController.text,
            'phone': phoneController.text,
            'email': emailController.text,
            'location': locationController.text,
            'rank': rankController.text,
            'unitName': unitController.text,
            'serviceNumber': serviceNumberController.text,
            'emergencyContact': emergencyContactController.text,
          });

      print('Profile updated successfully in Firebase.');
    } catch (e) {
      print('Error updating profile in Firebase: $e');
    }
  }

  void _saveChanges() async {
    _profileManager.updateData('name', nameController.text);
    _profileManager.updateData('phone', phoneController.text);
    _profileManager.updateData('email', emailController.text);
    _profileManager.updateData('location', locationController.text);
    _profileManager.updateData('rank', rankController.text);
    _profileManager.updateData('unit', unitController.text);
    _profileManager.updateData('serviceNumber', serviceNumberController.text);
    _profileManager.updateData(
      'emergencyContact',
      emergencyContactController.text,
    );

    await updateProfile();
  }

  void _discardChanges() {
    // Restore controllers to saved values from global manager
    nameController.text = _profileManager.savedData['name']!;
    phoneController.text = _profileManager.savedData['phone']!;
    emailController.text = _profileManager.savedData['email']!;
    locationController.text = _profileManager.savedData['location']!;
    rankController.text = _profileManager.savedData['rank']!;
    unitController.text = _profileManager.savedData['unit']!;
    serviceNumberController.text = _profileManager.savedData['serviceNumber']!;
    emergencyContactController.text =
        _profileManager.savedData['emergencyContact']!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _profileManager.savedData['unit']!,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFA8D5A2),
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: IconButton(
              key: ValueKey(isEditing),
              icon: Icon(isEditing ? Icons.save : Icons.edit),
              onPressed: () {
                if (isEditing) {
                  // Save changes when switching from edit to view mode
                  _saveChanges();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Row(
                        children: [
                          Icon(Icons.check_circle, color: Colors.white),
                          SizedBox(width: 8),
                          Text('Profile updated and saved successfully!'),
                        ],
                      ),
                      backgroundColor: Colors.green[600],
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                }
                setState(() {
                  isEditing = !isEditing;
                });
              },
            ),
          ),
          if (isEditing)
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                // Discard changes and switch back to view mode
                _discardChanges();
                setState(() {
                  isEditing = false;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Row(
                      children: [
                        Icon(Icons.cancel, color: Colors.white),
                        SizedBox(width: 8),
                        Text('Changes discarded'),
                      ],
                    ),
                    backgroundColor: Colors.orange[600],
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              },
            ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => _showMoreOptions(),
          ),
        ],
      ),
      backgroundColor: const Color(0xFFA8D5A2),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              // Modern Header Section
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.green[700], // Using your original green theme
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    // Profile Picture with Status
                    Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                          ),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor:
                                Colors.green, // Your original green avatar
                            // child: Icon(
                            //   Icons.security,
                            //   size: 50,
                            //   color: Colors.white, // Your original white icon
                            // ),
                            child: Image.network(
                              'https://cdn-icons-png.flaticon.com/512/5436/5436245.png',
                              height: 80,
                              width: 80,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _profileManager
                          .savedData['name']!, // Display saved name from global manager
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      _profileManager
                          .savedData['rank']!, // Display saved rank from global manager
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Quick Stats Row
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _StatItem(
                            icon: Icons.star,
                            label: 'Starred',
                            value: '3',
                          ),
                          _StatItem(
                            icon: Icons.security,
                            label: 'Active',
                            value: '24/7',
                          ),
                          _StatItem(
                            icon: Icons.verified,
                            label: 'Verified',
                            value: '✓',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),

              // Profile Information Cards
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader('Personal Information'),
                    _buildModernProfileCard(
                      icon: Icons.person,
                      label: 'Full Name',
                      controller: nameController,
                      fieldKey: 'name',
                      color: Colors.blue,
                    ),
                    _buildModernProfileCard(
                      icon: Icons.military_tech,
                      label: 'Rank',
                      controller: rankController,
                      fieldKey: 'rank',
                      color: Colors.orange,
                    ),
                    _buildModernProfileCard(
                      icon: Icons.badge,
                      label: 'Service Number',
                      controller: serviceNumberController,
                      fieldKey: 'serviceNumber',
                      color: Colors.purple,
                    ),

                    const SizedBox(height: 20),
                    _buildSectionHeader('Contact Information'),
                    _buildModernProfileCard(
                      icon: Icons.phone,
                      label: 'Phone Number',
                      controller: phoneController,
                      fieldKey: 'phone',
                      color: Colors.green,
                    ),
                    _buildModernProfileCard(
                      icon: Icons.email,
                      label: 'Email Address',
                      controller: emailController,
                      fieldKey: 'email',
                      color: Colors.red,
                    ),
                    _buildModernProfileCard(
                      icon: Icons.emergency,
                      label: 'Emergency Contact',
                      controller: emergencyContactController,
                      fieldKey: 'emergencyContact',
                      color: Colors.deepOrange,
                    ),

                    const SizedBox(height: 20),
                    _buildSectionHeader('Unit Information'),
                    _buildModernProfileCard(
                      icon: Icons.group,
                      label: 'Unit',
                      controller: unitController,
                      fieldKey: 'unit',
                      color: Colors.indigo,
                    ),
                    _buildModernProfileCard(
                      icon: Icons.location_on,
                      label: 'Location',
                      controller: locationController,
                      fieldKey: 'location',
                      color: Colors.teal,
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.grey[700],
        ),
      ),
    );
  }

  Widget _buildModernProfileCard({
    required IconData icon,
    required String label,
    required TextEditingController controller,
    required String fieldKey,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        title: isEditing
            ? TextField(
                controller: controller,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  labelText: label,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: color),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: color, width: 2),
                  ),
                  isDense: true,
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    controller.text.isEmpty ? 'Not provided' : controller.text,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: controller.text.isEmpty
                          ? Colors.grey[400]
                          : Colors.black87,
                    ),
                  ),
                ],
              ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Star button with animation
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              child: IconButton(
                icon: Icon(
                  _profileManager.starStatus[fieldKey] == true
                      ? Icons.star
                      : Icons.star_border,
                  color: _profileManager.starStatus[fieldKey] == true
                      ? Colors.amber
                      : Colors.grey[400],
                  size: 22,
                ),
                onPressed: () async {
                  setState(() {
                    _profileManager.updateStarStatus(
                      fieldKey,
                      !_profileManager.starStatus[fieldKey]!,
                    );
                  });
                  await updateStarStatus(fieldKey);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Row(
                        children: [
                          Icon(
                            _profileManager.starStatus[fieldKey] == true
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _profileManager.starStatus[fieldKey] == true
                                ? '$label marked as favorite'
                                : '$label removed from favorites',
                          ),
                        ],
                      ),
                      backgroundColor:
                          _profileManager.starStatus[fieldKey] == true
                          ? Colors.amber[700]
                          : Colors.grey[600],
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
              ),
            ),
            // Delete button
            IconButton(
              icon: Icon(
                Icons.delete_outline,
                color: Colors.red[400],
                size: 22,
              ),
              onPressed: () => _showDeleteDialog(label, fieldKey, controller),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(
    String label,
    String fieldKey,
    TextEditingController controller,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.orange[600]),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Delete $label',
                  overflow: TextOverflow.ellipsis, // Prevent title overflow
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Text(
              'Are you sure you want to delete this $label information? This action cannot be undone.',
            ),
          ),
          actions: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal, // Prevent actions overflow
              child: Row(
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        controller.clear();
                        _profileManager.deleteField(fieldKey);
                      });
                      await updateProfile();
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            children: [
                              const Icon(Icons.delete, color: Colors.white),
                              const SizedBox(width: 8),
                              Text('$label deleted and saved permanently'),
                            ],
                          ),
                          backgroundColor: Colors.red[600],
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text(
                      'Delete',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _showMoreOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.backup, color: Colors.blue),
              title: const Text('Backup Profile'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Profile backed up successfully!'),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.share, color: Colors.green),
              title: const Text('Share Profile'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Profile shared!')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.security, color: Colors.orange),
              title: const Text('Security Settings'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Sign Out'),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                UserData.reset();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/welcome',
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    locationController.dispose();
    rankController.dispose();
    unitController.dispose();
    serviceNumberController.dispose();
    emergencyContactController.dispose();
    super.dispose();
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          label,
          style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12),
        ),
      ],
    );
  }
}
