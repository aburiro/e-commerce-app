import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF2D1B69)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Contact Us',
          style: TextStyle(
            color: Color(0xFF2D1B69),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 24),
              // Header Icon with Animation
              FadeTransition(
                opacity: _fadeController,
                child: ScaleTransition(
                  scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                    CurvedAnimation(
                      parent: _fadeController,
                      curve: Curves.easeOut,
                    ),
                  ),
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF6366F1).withOpacity(0.2),
                          const Color(0xFF8B5CF6).withOpacity(0.2),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(60),
                      border: Border.all(
                        color: const Color(0xFF6366F1).withOpacity(0.3),
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.headset_mic_outlined,
                      size: 60,
                      color: Color(0xFF6366F1),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Main Title
              FadeTransition(
                opacity: _fadeController,
                child: Column(
                  children: const [
                    Text(
                      "We're here to help you 24/7",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2D1B69),
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              // Contact Options List
              SlideTransition(
                position:
                    Tween<Offset>(
                      begin: const Offset(0, 0.3),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: _slideController,
                        curve: Curves.easeOut,
                      ),
                    ),
                child: FadeTransition(
                  opacity: _slideController,
                  child: Column(
                    children: [
                      _buildContactCard(
                        icon: Icons.chat_bubble_outline,
                        title: 'Live Chat',
                        subtitle: 'Chat with our support team',
                        duration: 'any time here',
                        color: const Color(0xFF6366F1),
                        onTap: () => _showSnackBar('Opening Live Chat...'),
                      ),
                      const SizedBox(height: 16),
                      _buildContactCard(
                        icon: Icons.email_outlined,
                        title: 'Email Us',
                        subtitle: 'support@ecommerce.com',
                        duration: null,
                        color: const Color(0xFF8B5CF6),
                        onTap: () => _showSnackBar('Opening Email...'),
                      ),
                      const SizedBox(height: 16),
                      _buildContactCard(
                        icon: Icons.phone_in_talk_outlined,
                        title: 'Call Support',
                        subtitle: '+1 (555) 123-4567',
                        duration: null,
                        color: const Color(0xFF7C3AED),
                        onTap: () => _showSnackBar('Opening Phone Dialer...'),
                      ),
                      const SizedBox(height: 16),
                      _buildContactCard(
                        icon: Icons.feedback_outlined,
                        title: 'Send Feedback',
                        subtitle: 'Quick form',
                        duration: null,
                        color: const Color(0xFF06B6D4),
                        onTap: () => _showSnackBar('Opening Feedback Form...'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Common Questions Link
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => _showSnackBar('Opening FAQ...'),
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 8.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Common questions',
                            style: TextStyle(
                              color: Color(0xFF6366F1),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(
                            Icons.arrow_forward,
                            size: 16,
                            color: Color(0xFF6366F1),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String? duration,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        splashColor: color.withOpacity(0.1),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withOpacity(0.15), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color, color.withOpacity(0.7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2D1B69),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: const Color(0xFF5B6B7F).withOpacity(0.8),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    if (duration != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          duration,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF9CA3AF),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: color.withOpacity(0.6),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: const Color(0xFF2D1B69).withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // _buildNavItem(Icons.home_outlined, false),
              // _buildNavItem(Icons.message_outlined, false),
              // _buildNavItem(Icons.apps_outlined, false),
              // _buildNavItem(Icons.notifications_none, true, badge: '1'),
              // _buildNavItem(Icons.person_outline, false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, bool isActive, {String? badge}) {
    return Stack(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: isActive
                ? const Color(0xFF6366F1).withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: isActive ? const Color(0xFF6366F1) : const Color(0xFF5B6B7F),
            size: 24,
          ),
        ),
        if (badge != null)
          Positioned(
            top: 6,
            right: 6,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: const Color(0xFFFF4757),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  badge,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF6366F1),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
