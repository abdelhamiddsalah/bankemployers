import 'package:bankemployers/core/styling/colors.dart';
import 'package:bankemployers/features/splash/user_role.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _progressController;
  
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoOpacityAnimation;
  late Animation<double> _textOpacityAnimation;
  late Animation<double> _progressAnimation;
  
  double _progress = 0.0;
  String _loadingText = "Loading system...";
  
  @override
  void initState() {
    super.initState();
    _initAnimations();
    _startLoadingSequence();
  }
  
  void _initAnimations() {
    // أنيميشن الشعار
    _logoController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );
    
    // أنيميشن النصوص
    _textController = AnimationController(
      duration: Duration(milliseconds: 1200),
      vsync: this,
    );
    
    // أنيميشن شريط التقدم
    _progressController = AnimationController(
      duration: Duration(milliseconds: 3000),
      vsync: this,
    );
    
    _logoScaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.elasticOut,
    ));
    
    _logoOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeIn,
    ));
    
    _textOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeInOut,
    ));
    
    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeInOut,
    ));
  }
  
  void _startLoadingSequence() async {
    // بدء أنيميشن الشعار
    _logoController.forward();
    
    // انتظار ثم بدء أنيميشن النص
    await Future.delayed(Duration(milliseconds: 800));
    _textController.forward();
    
    // بدء شريط التقدم
    await Future.delayed(Duration(milliseconds: 500));
    _progressController.forward();
    
    // محاكاة عملية التحميل
    _simulateLoading();
  }
  
  void _simulateLoading() async {
    List<String> loadingSteps = [
      "Connecting to server...",
      "Loading data...",
      "Verifying permissions...",
      "Setting up interface...",
      "Welcome to Bank System"
    ];
    
    for (int i = 0; i < loadingSteps.length; i++) {
      await Future.delayed(Duration(milliseconds: 600));
      setState(() {
        _loadingText = loadingSteps[i];
        _progress = (i + 1) / loadingSteps.length;
      });
    }
    
    // الانتقال إلى الشاشة الرئيسية
    await Future.delayed(Duration(milliseconds: 800));
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => UserRoleSelectionScreen(),
        transitionDuration: Duration(milliseconds: 800),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF4338CA), // Dark purple
              maincolor, // Main color
              Color(0xFF8B5CF6), // Light purple
            ],
          ),
        ),
        child: Stack(
          children: [
            // خلفية بتأثير الدوائر
            _buildBackgroundPattern(),
            
            // المحتوى الرئيسي
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // الشعار
                  AnimatedBuilder(
                    animation: _logoController,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _logoScaleAnimation.value,
                        child: Opacity(
                          opacity: _logoOpacityAnimation.value,
                          child: _buildLogo(),
                        ),
                      );
                    },
                  ),
                  
                  SizedBox(height: 40),
                  
                  // اسم التطبيق
                  AnimatedBuilder(
                    animation: _textController,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _textOpacityAnimation.value,
                        child: Column(
                          children: [
                            Text(
                              'Digital Bank System',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 2,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Employee Platform',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white70,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  
                  SizedBox(height: 80),
                  
                  // شريط التقدم والنص
                  AnimatedBuilder(
                    animation: _progressController,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _progressAnimation.value,
                        child: Column(
                          children: [
                            Container(
                              width: 300,
                              height: 4,
                              decoration: BoxDecoration(
                                color: Colors.white24,
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: Stack(
                                children: [
                                  Container(
                                    width: 300 * _progress,
                                    height: 4,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(2),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.white.withOpacity(0.5),
                                          blurRadius: 8,
                                          spreadRadius: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              _loadingText,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            
            // معلومات الإصدار في الأسفل
            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'Version 1.0.0 | All rights reserved',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white60,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildLogo() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 15,
            spreadRadius: 2,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Icon(
        Icons.account_balance,
        size: 60,
        color: maincolor,
      ),
    );
  }
  
  Widget _buildBackgroundPattern() {
    return Positioned.fill(
      child: CustomPaint(
        painter: CirclePatternPainter(),
      ),
    );
  }
  
  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _progressController.dispose();
    super.dispose();
  }
}

// رسام الخلفية المزخرفة
class CirclePatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..style = PaintingStyle.fill;
    
    // رسم دوائر في خلفية الشاشة
    for (int i = 0; i < 10; i++) {
      canvas.drawCircle(
        Offset(
          (size.width * 0.1) + (i * size.width * 0.15),
          size.height * 0.2,
        ),
        30 + (i * 5),
        paint,
      );
    }
    
    for (int i = 0; i < 8; i++) {
      canvas.drawCircle(
        Offset(
          (size.width * 0.2) + (i * size.width * 0.12),
          size.height * 0.8,
        ),
        20 + (i * 3),
        paint,
      );
    }
  }
  
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}