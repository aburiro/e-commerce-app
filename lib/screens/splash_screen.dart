import 'package:flutter/material.dart';
import '../navigation/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _bagController;
  late AnimationController _fadeController;
  late Animation<double> _bagScale;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Bag animation
    _bagController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _bagScale = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _bagController, curve: Curves.elasticOut),
    );

    // Fade animation
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeIn));

    // Start animations
    _bagController.forward();
    Future.delayed(const Duration(milliseconds: 300), () {
      _fadeController.forward();
    });
  }

  @override
  void dispose() {
    _bagController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.08),
            Expanded(
              flex: 2,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Background wave/curve
                  CustomPaint(
                    painter: WaveBackgroundPainter(),
                    size: Size(
                      double.infinity,
                      MediaQuery.of(context).size.height * 0.35,
                    ),
                  ),

                  // Floating icons with animation
                  _buildFloatingIconAnimated(20, 30),
                  _buildFloatingIconAnimated(40, null),
                  _buildFloatingIconAnimated(60, 20),
                  _buildFloatingIconAnimated(80, 30),

                  // Main shopping bag icon with animation
                  ScaleTransition(
                    scale: _bagScale,
                    child: Center(
                      child: Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          color: const Color(0xFF7C3AED),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF7C3AED).withOpacity(0.3),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.shopping_bag_rounded,
                          color: Colors.white,
                          size: 60,
                        ),
                      ),
                    ),
                  ),

                  // Smiley face on the bag
                  Positioned(
                    bottom: 30,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Content section with fade animation
            Expanded(
              flex: 1,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        'YourApp',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Shopping made easy',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF9CA3AF),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              AppRoutes.login,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Get Started Tapped!'),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF7C3AED),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 5,
                          ),
                          child: const Text(
                            'Get Started',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: const Color(0xFF7C3AED),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingIconAnimated(int delay, int? rightPosition) {
    return Positioned(
      top: 20.0 + (delay * 5),
      left: rightPosition == null ? 30.0 : null,
      right: rightPosition?.toDouble(),
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: 1),
        duration: Duration(milliseconds: 800 + delay * 100),
        curve: Curves.easeInOut,
        builder: (context, value, child) {
          return Opacity(
            opacity: value,
            child: Transform.translate(
              offset: Offset(0, -20 * value),
              child: child,
            ),
          );
        },
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFFE9D5FF),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.shopping_bag_rounded,
            color: Color(0xFF7C3AED),
            size: 20,
          ),
        ),
      ),
    );
  }
}

class WaveBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFF3E8FF)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height * 0.3);
    path.quadraticBezierTo(
      size.width * 0.25,
      0,
      size.width * 0.5,
      size.height * 0.2,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.4,
      size.width,
      size.height * 0.15,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(WaveBackgroundPainter oldDelegate) => false;
}
