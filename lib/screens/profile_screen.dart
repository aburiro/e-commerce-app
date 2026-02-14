import 'package:flutter/material.dart';
import '../navigation/app_routes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedNavIndex = 3;
  String selectedLanguage = 'English';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(),
            _buildProfileMenuOptions(),
            _buildSignOutButton(),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildProfileHeader() {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        16,
        MediaQuery.of(context).padding.top + 20,
        16,
        24,
      ),
      child: Column(
        children: [
          // Profile Picture
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[300],
              image: const DecorationImage(
                image: AssetImage('assets/home_screen_image/user_profile.png'),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // User Name
          const Text(
            'Jameel Ahmed',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          // Email
          Text(
            'jameelahmed@gmail.com',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileMenuOptions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _buildMenuOption(
            icon: Icons.language,
            title: 'Language',
            subtitle: selectedLanguage,
            onTap: () => _showLanguageDialog(),
          ),
          const SizedBox(height: 10),

          _buildMenuOption(
            icon: Icons.receipt_long_outlined,
            title: 'Orders',
            onTap: () => Navigator.pushNamed(context, AppRoutes.orderHistory),
          ),
          const SizedBox(height: 10),
          _buildMenuOption(
            icon: Icons.mail_outline,
            title: 'Contact',
            onTap: () =>
                Navigator.pushNamed(context, AppRoutes.contactpage_screen),
          ),
          const SizedBox(height: 10),
          _buildMenuOption(
            icon: Icons.share_outlined,
            title: 'Share App',
            onTap: () => Navigator.pushNamed(context, AppRoutes.shareapp),
          ),
          const SizedBox(height: 10),
          _buildMenuOption(
            icon: Icons.help_outline,
            title: 'Help',
            onTap: () =>
                Navigator.pushNamed(context, AppRoutes.helpcenter_advancedapp),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuOption({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    if (subtitle != null)
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[500],
                        ),
                      ),
                  ],
                ),
              ],
            ),
            Icon(Icons.chevron_right, color: Colors.grey[600], size: 22),
          ],
        ),
      ),
    );
  }

  Widget _buildSignOutButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      child: GestureDetector(
        onTap: () => _showSignOutDialog(),
        child: const Text(
          'Sign Out',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF6C63FF),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return BottomNavigationBar(
      currentIndex: _selectedNavIndex,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: const Color(0xFF6C63FF),
      unselectedItemColor: Colors.grey[400],
      elevation: 8,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_filled, color: Colors.grey[400]),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search, color: Colors.grey[400]),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_bag_outlined, color: Colors.grey[400]),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person_outline, color: Color(0xFF6C63FF)),
          label: '',
        ),
      ],
      onTap: (index) {
        setState(() {
          _selectedNavIndex = index;
        });
        AppRoutes.goToMainTab(context, index);
      },
    );
  }

  void _navigateToSettings() {}

  void _showMessage(String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Navigate to $title'),
        duration: const Duration(milliseconds: 800),
        backgroundColor: const Color(0xFF6C63FF),
      ),
    );
  }

  void _showSignOutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Sign Out',
          style: TextStyle(color: Color(0xFF6C63FF)),
        ),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Signed out successfully'),
                  duration: Duration(milliseconds: 800),
                  backgroundColor: Color(0xFF6C63FF),
                ),
              );
            },
            child: const Text(
              'Sign Out',
              style: TextStyle(color: Color(0xFF6C63FF)),
            ),
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Language'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: ['English', 'Spanish', 'French', 'German', 'Chinese'].map(
              (lang) {
                return RadioListTile<String>(
                  title: Text(lang),
                  value: lang,
                  groupValue: selectedLanguage,
                  onChanged: (value) {
                    setState(() {
                      selectedLanguage = value!;
                    });
                    Navigator.pop(context);
                  },
                );
              },
            ).toList(),
          ),
        ),
      ),
    );
  }
}
