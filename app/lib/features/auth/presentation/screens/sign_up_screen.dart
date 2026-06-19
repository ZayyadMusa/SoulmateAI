import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with SingleTickerProviderStateMixin {
  late AnimationController _blobController;
  late Animation<double> _blobAnimation;

  @override
  void initState() {
    super.initState();
    _blobController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat(reverse: true);
    
    _blobAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _blobController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _blobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      body: Stack(
        children: [
          // Atmospheric Background Decoration
          Positioned(
            top: -50,
            right: -50,
            child: ScaleTransition(
              scale: _blobAnimation,
              child: _buildBlob(),
            ),
          ),
          Positioned(
            bottom: -50,
            left: -50,
            child: ScaleTransition(
              scale: _blobAnimation,
              child: Opacity(
                opacity: 0.7, // Slightly less visible
                child: _buildBlob(),
              ),
            ),
          ),
          
          SafeArea(
            child: Column(
              children: [
                // Top Navigation / Progress Shell
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.favorite, color: AppTheme.primary, size: 28),
                          const SizedBox(width: 8),
                          Text(
                            'Soulmate AI',
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              color: AppTheme.primary,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      // Onboarding Progress Indicator
                      SizedBox(
                        width: 200,
                        child: Row(
                          children: [
                            Expanded(child: _buildProgressSegment(isActive: true)),
                            const SizedBox(width: 12),
                            Expanded(child: _buildProgressSegment(isActive: false)),
                            const SizedBox(width: 12),
                            Expanded(child: _buildProgressSegment(isActive: false)),
                            const SizedBox(width: 12),
                            Expanded(child: _buildProgressSegment(isActive: false)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Main Signup Canvas
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Create your account',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                            fontSize: 32,
                            height: 40 / 32,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Start your journey toward emotional wellness with a companion that truly listens.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 40),
                        
                        // Form
                        const _SignUpInput(
                          label: 'Your Name',
                          hintText: 'How should I call you?',
                          icon: Icons.person_outline,
                        ),
                        const SizedBox(height: 24),
                        const _SignUpInput(
                          label: 'Email Address',
                          hintText: 'hello@example.com',
                          icon: Icons.mail_outline,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 24),
                        const _SignUpInput(
                          label: 'Create Password',
                          hintText: 'Min. 8 characters',
                          icon: Icons.lock_outline,
                          isPassword: true,
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Terms Context
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: AppTheme.outline,
                              ),
                              children: const [
                                TextSpan(text: 'By continuing, you agree to our '),
                                TextSpan(
                                  text: 'Privacy Policy',
                                  style: TextStyle(color: AppTheme.primary),
                                ),
                                TextSpan(text: ' and '),
                                TextSpan(
                                  text: 'Terms of Service',
                                  style: TextStyle(color: AppTheme.primary),
                                ),
                                TextSpan(text: '.'),
                              ],
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: 48),
                        
                        // Footer Action
                        Container(
                          height: 64,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9999),
                            gradient: const LinearGradient(
                              colors: [AppTheme.primary, AppTheme.primaryContainer],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.primary.withOpacity(0.2),
                                blurRadius: 10,
                                spreadRadius: 0,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(9999),
                              onTap: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Continue',
                                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                      color: AppTheme.onPrimary,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(
                                    Icons.arrow_forward,
                                    color: AppTheme.onPrimary,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: 32),
                        
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account? ',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppTheme.onSurfaceVariant,
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                foregroundColor: AppTheme.primary,
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                'Log In',
                                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: AppTheme.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBlob() {
    return Container(
      width: 400,
      height: 400,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(240),
          topRight: Radius.circular(160),
          bottomLeft: Radius.circular(120),
          bottomRight: Radius.circular(280),
        ),
        gradient: const LinearGradient(
          colors: [Color(0xFFA4C9FF), Color(0xFF5D9CEC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF5D9CEC).withOpacity(0.15),
            blurRadius: 40,
            spreadRadius: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildProgressSegment({required bool isActive}) {
    return Container(
      height: 6,
      decoration: BoxDecoration(
        color: isActive ? AppTheme.primary : AppTheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(9999),
      ),
    );
  }
}

class _SignUpInput extends StatefulWidget {
  final String label;
  final String hintText;
  final IconData icon;
  final bool isPassword;
  final TextInputType keyboardType;

  const _SignUpInput({
    required this.label,
    required this.hintText,
    required this.icon,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<_SignUpInput> createState() => _SignUpInputState();
}

class _SignUpInputState extends State<_SignUpInput> {
  bool _isFocused = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4.0, bottom: 8.0),
          child: Text(
            widget.label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: AppTheme.onSurfaceVariant,
            ),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: AppTheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(12), // rounded-xl
            border: Border.all(
              color: _isFocused ? AppTheme.primaryContainer : Colors.transparent,
              width: 2,
            ),
            boxShadow: _isFocused
                ? [
                    BoxShadow(
                      color: AppTheme.primary.withOpacity(0.1),
                      blurRadius: 0,
                      spreadRadius: 4,
                    )
                  ]
                : null,
          ),
          child: TextField(
            focusNode: _focusNode,
            obscureText: widget.isPassword,
            keyboardType: widget.keyboardType,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.onSurface,
            ),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.outlineVariant,
              ),
              suffixIcon: Icon(
                widget.icon,
                color: _isFocused ? AppTheme.primary : AppTheme.outlineVariant,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20), // py-4 px-6
            ),
          ),
        ),
      ],
    );
  }
}
