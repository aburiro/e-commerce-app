import 'package:flutter/material.dart';

class HelpCategory {
  final String id;
  final String title;
  final IconData icon;
  final Color color;
  final List<HelpQuestion> questions;

  HelpCategory({
    required this.id,
    required this.title,
    required this.icon,
    required this.color,
    required this.questions,
  });
}

class HelpQuestion {
  final String id;
  final String question;
  final String answer;
  final String categoryId;
  bool isExpanded;

  HelpQuestion({
    required this.id,
    required this.question,
    required this.answer,
    required this.categoryId,
    this.isExpanded = false,
  });

  bool matchesQuery(String query) {
    return question.toLowerCase().contains(query) ||
        answer.toLowerCase().contains(query);
  }
}

class HelpCenterAdvancedPage extends StatefulWidget {
  const HelpCenterAdvancedPage({Key? key}) : super(key: key);

  @override
  State<HelpCenterAdvancedPage> createState() => _HelpCenterAdvancedPageState();
}

class _HelpCenterAdvancedPageState extends State<HelpCenterAdvancedPage>
    with TickerProviderStateMixin {
  late TextEditingController _searchController;
  late AnimationController _fadeController;
  late AnimationController _slideController;
  String _searchQuery = '';
  String? _selectedCategory;
  List<HelpQuestion> _searchResults = [];
  bool _isSearching = false;

  final List<HelpCategory> helpCategories = [
    HelpCategory(
      id: 'orders',
      title: 'Orders & Delivery',
      icon: Icons.local_shipping_outlined,
      color: const Color(0xFF6366F1),
      questions: [
        HelpQuestion(
          id: 'order1',
          question: 'How do I track my order?',
          answer:
              'You can track your order in real-time through the "Orders" section in your account. Simply click on any order to see its current location and estimated delivery date. You will also receive SMS and email notifications with tracking updates.',
          categoryId: 'orders',
        ),
        HelpQuestion(
          id: 'order2',
          question: 'What is the delivery time?',
          answer:
              'Standard delivery usually takes 3-5 business days. Express delivery is available for most locations and takes 1-2 business days. International orders may take 7-14 business days depending on the destination.',
          categoryId: 'orders',
        ),
        HelpQuestion(
          id: 'order3',
          question: 'Can I change my delivery address?',
          answer:
              'You can change your delivery address within 2 hours of placing the order. After that, please contact our support team immediately as the order may have already been dispatched.',
          categoryId: 'orders',
        ),
      ],
    ),
    HelpCategory(
      id: 'payments',
      title: 'Payments & Refunds',
      icon: Icons.payment_outlined,
      color: const Color(0xFF8B5CF6),
      questions: [
        HelpQuestion(
          id: 'pay1',
          question: 'What payment methods do you accept?',
          answer:
              'We accept all major credit cards (Visa, Mastercard, American Express), debit cards, digital wallets (Apple Pay, Google Pay), and bank transfers. All payments are secured with SSL encryption.',
          categoryId: 'payments',
        ),
        HelpQuestion(
          id: 'pay2',
          question: 'How do refunds work?',
          answer:
              'Refunds are processed within 5-7 business days after approval. The amount will be credited back to your original payment method. For rejected items, return shipping is free if initiated within 30 days.',
          categoryId: 'payments',
        ),
        HelpQuestion(
          id: 'pay3',
          question: 'Is my payment information secure?',
          answer:
              'Yes, we use industry-standard SSL encryption and PCI DSS compliance to protect your payment information. We never store your credit card details on our servers.',
          categoryId: 'payments',
        ),
      ],
    ),
    HelpCategory(
      id: 'account',
      title: 'Account & Security',
      icon: Icons.security_outlined,
      color: const Color(0xFF3B82F6),
      questions: [
        HelpQuestion(
          id: 'acc1',
          question: 'How do I reset my password?',
          answer:
              'Click "Forgot Password" on the login screen, enter your email, and we\'ll send you a reset link. Follow the instructions to create a new password. The link is valid for 24 hours.',
          categoryId: 'account',
        ),
        HelpQuestion(
          id: 'acc2',
          question: 'How can I secure my account?',
          answer:
              'Enable two-factor authentication in Settings > Security. This adds an extra layer of protection to your account. You can also add trusted devices to streamline future logins.',
          categoryId: 'account',
        ),
        HelpQuestion(
          id: 'acc3',
          question: 'How do I delete my account?',
          answer:
              'You can request account deletion in Settings > Privacy > Delete Account. Your data will be permanently deleted after 30 days, during which you can cancel the request.',
          categoryId: 'account',
        ),
      ],
    ),
    HelpCategory(
      id: 'returns',
      title: 'Returns & Cancellations',
      icon: Icons.assignment_return_outlined,
      color: const Color(0xFF10B981),
      questions: [
        HelpQuestion(
          id: 'ret1',
          question: 'How do I cancel an order?',
          answer:
              'Orders can be cancelled within 2 hours of purchase. Go to Orders > Your Order > Cancel. If the cancellation window has passed, contact our support team for options.',
          categoryId: 'returns',
        ),
        HelpQuestion(
          id: 'ret2',
          question: 'What is your return policy?',
          answer:
              'We offer 30-day returns on most items. Products must be unused and in original condition. Start a return in Orders > Return. Return shipping is free for most cases.',
          categoryId: 'returns',
        ),
        HelpQuestion(
          id: 'ret3',
          question: 'How do I initiate a return?',
          answer:
              'Go to Orders > Select Item > Return. Choose your reason, and we\'ll provide a prepaid return label. Once we receive and inspect the item, your refund will be processed.',
          categoryId: 'returns',
        ),
      ],
    ),
    HelpCategory(
      id: 'app',
      title: 'App Issues',
      icon: Icons.bug_report_outlined,
      color: const Color(0xFFEF4444),
      questions: [
        HelpQuestion(
          id: 'app1',
          question: 'The app keeps crashing, what should I do?',
          answer:
              'Try: 1) Restart your phone, 2) Update the app from your store, 3) Clear app cache in Settings > Apps > [App Name] > Clear Cache. If the issue persists, contact support.',
          categoryId: 'app',
        ),
        HelpQuestion(
          id: 'app2',
          question: 'How do I update the app?',
          answer:
              'Updates are available in your app store (Apple App Store or Google Play Store). Enable auto-updates for the latest version automatically. New features are released monthly.',
          categoryId: 'app',
        ),
        HelpQuestion(
          id: 'app3',
          question: 'The app is running slow, how can I fix it?',
          answer:
              'Try: 1) Close other apps running in background, 2) Restart your phone, 3) Clear app cache, 4) Update to the latest version. Contact support if slowness persists.',
          categoryId: 'app',
        ),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
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
    _searchController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  List<HelpQuestion> _getAllQuestions() {
    return helpCategories.expand((cat) => cat.questions).toList();
  }

  void _performSearch(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
      _isSearching = query.isNotEmpty;

      if (_isSearching) {
        _searchResults = _getAllQuestions()
            .where((q) => q.matchesQuery(_searchQuery))
            .toList();
      } else {
        _searchResults = [];
      }
    });
  }

  List<HelpQuestion> _getPopularQuestions() {
    return [
      _getAllQuestions().firstWhere((q) => q.id == 'order1'),
      _getAllQuestions().firstWhere((q) => q.id == 'ret1'),
      _getAllQuestions().firstWhere((q) => q.id == 'pay2'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7FC),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF2D1B69)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Help Center',
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
              const SizedBox(height: 16),
              // Search Bar
              FadeTransition(
                opacity: _fadeController,
                child: _buildSearchBar(),
              ),
              const SizedBox(height: 28),
              // Show search results if searching
              if (_isSearching)
                _buildSearchResults()
              else
                // Show categories and popular questions if not searching
                Column(
                  children: [
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
                        child: _buildCategories(),
                      ),
                    ),
                    const SizedBox(height: 32),
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
                        child: _buildPopularQuestions(),
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF6366F1).withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6366F1).withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        onChanged: _performSearch,
        decoration: InputDecoration(
          hintText: 'Search your issue...',
          hintStyle: TextStyle(
            color: const Color(0xFF5B6B7F).withOpacity(0.6),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: const Color(0xFF6366F1).withOpacity(0.6),
            size: 20,
          ),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: () {
                    _searchController.clear();
                    _performSearch('');
                  },
                )
              : Icon(
                  Icons.mic_none,
                  color: const Color(0xFF5B6B7F).withOpacity(0.4),
                  size: 20,
                ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 4,
          ),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 4.0, bottom: 16),
          child: Text(
            'Help Categories',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2D1B69),
            ),
          ),
        ),
        Column(
          children: helpCategories.asMap().entries.map((entry) {
            int index = entry.key;
            HelpCategory category = entry.value;
            return Padding(
              padding: EdgeInsets.only(
                bottom: index < helpCategories.length - 1 ? 12 : 0,
              ),
              child: _buildCategoryCard(category),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCategoryCard(HelpCategory category) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _showCategoryDetails(category),
        borderRadius: BorderRadius.circular(14),
        splashColor: category.color.withOpacity(0.1),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: category.color.withOpacity(0.15),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: category.color.withOpacity(0.08),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: category.color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(category.icon, color: category.color, size: 24),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  category.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D1B69),
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: category.color.withOpacity(0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPopularQuestions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 4.0, bottom: 16),
          child: Text(
            'Popular Questions',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2D1B69),
            ),
          ),
        ),
        Column(
          children: _getPopularQuestions().asMap().entries.map((entry) {
            int index = entry.key;
            HelpQuestion question = entry.value;
            return Padding(
              padding: EdgeInsets.only(
                bottom: index < _getPopularQuestions().length - 1 ? 8 : 12,
              ),
              child: _buildQuestionTile(question),
            );
          }).toList(),
        ),
        const SizedBox(height: 12),
        _buildContactSupportButton(),
      ],
    );
  }

  Widget _buildSearchResults() {
    if (_searchResults.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 48.0),
        child: Column(
          children: [
            Icon(
              Icons.search_off,
              size: 60,
              color: const Color(0xFF6366F1).withOpacity(0.3),
            ),
            const SizedBox(height: 16),
            Text(
              'No results found',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF2D1B69).withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try a different search term',
              style: TextStyle(
                fontSize: 13,
                color: const Color(0xFF5B6B7F).withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 32),
            _buildContactSupportButton(),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4.0, bottom: 16),
          child: Text(
            'Results (${_searchResults.length})',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2D1B69),
            ),
          ),
        ),
        Column(
          children: _searchResults.asMap().entries.map((entry) {
            int index = entry.key;
            HelpQuestion question = entry.value;
            return Padding(
              padding: EdgeInsets.only(
                bottom: index < _searchResults.length - 1 ? 8 : 12,
              ),
              child: _buildQuestionTile(question),
            );
          }).toList(),
        ),
        const SizedBox(height: 12),
        _buildContactSupportButton(),
      ],
    );
  }

  Widget _buildQuestionTile(HelpQuestion question) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF9CA3AF).withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            setState(() {
              question.isExpanded = !question.isExpanded;
            });
          },
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: const Color(0xFF9CA3AF).withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.help_outline,
                        size: 14,
                        color: Color(0xFF5B6B7F),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        question.question,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF2D1B69),
                        ),
                      ),
                    ),
                    Icon(
                      question.isExpanded
                          ? Icons.expand_less
                          : Icons.expand_more,
                      color: const Color(0xFF5B6B7F),
                      size: 20,
                    ),
                  ],
                ),
                if (question.isExpanded)
                  Padding(
                    padding: const EdgeInsets.only(top: 12, left: 36),
                    child: Text(
                      question.answer,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF5B6B7F).withOpacity(0.8),
                        height: 1.5,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactSupportButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _showSnackBar('Opening Contact Support...'),
        borderRadius: BorderRadius.circular(12),
        splashColor: const Color(0xFF6366F1).withOpacity(0.1),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFF6366F1).withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Contact Support',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF6366F1),
                ),
              ),
              SizedBox(width: 8),
              Icon(Icons.arrow_forward_ios, size: 14, color: Color(0xFF6366F1)),
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

  void _showCategoryDetails(HelpCategory category) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildCategoryDetailsSheet(category),
    );
  }

  Widget _buildCategoryDetailsSheet(HelpCategory category) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: category.color.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(category.icon, color: category.color, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    category.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2D1B69),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: category.questions.length,
              itemBuilder: (context, index) {
                final question = category.questions[index];
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: index < category.questions.length - 1 ? 12 : 20,
                  ),
                  child: _buildQuestionTile(question),
                );
              },
            ),
          ),
        ],
      ),
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
