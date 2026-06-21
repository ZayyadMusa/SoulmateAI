import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../controllers/auth_controller.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> with TickerProviderStateMixin {
  bool _isLoading = false;
  late AnimationController _blobController;
  late Animation<double> _blobAnimation;
  final _emailController = TextEditingController();

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
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleSendLink() async {
    setState(() {
      _isLoading = true;
    });
    
    try {
      await ref.read(authControllerProvider.notifier).resetPassword(_emailController.text);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Recovery link sent! Check your inbox.'),
            backgroundColor: AppTheme.tertiaryContainer,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: AppTheme.errorContainer,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      body: Stack(
        children: [
          // Atmospheric Background Decor
          Positioned(
            top: -100,
            right: -100,
            child: ScaleTransition(
              scale: _blobAnimation,
              child: Container(
                width: 384,
                height: 384,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.primaryFixed.withOpacity(0.3),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryFixed.withOpacity(0.3),
                      blurRadius: 40,
                      spreadRadius: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -128,
            left: -128,
            child: ScaleTransition(
              scale: _blobAnimation,
              child: Container(
                width: 500,
                height: 500,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.secondaryFixed.withOpacity(0.2),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.secondaryFixed.withOpacity(0.2),
                      blurRadius: 40,
                      spreadRadius: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          SafeArea(
            child: Column(
              children: [
                // Top Navigation Anchor
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Soulmate',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: AppTheme.primary,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                ),
                
                // Main Content
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 448),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Reassuring Illustration/Icon
                            Container(
                              width: 96,
                              height: 96,
                              margin: const EdgeInsets.only(bottom: 16),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryFixed.withOpacity(0.5),
                                shape: BoxShape.circle,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromRGBO(7, 95, 171, 0.08),
                                    blurRadius: 60,
                                    spreadRadius: 0,
                                  ),
                                ],
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  const Icon(
                                    Icons.vpn_key,
                                    color: AppTheme.primary,
                                    size: 48,
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: AppTheme.tertiaryContainer,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: AppTheme.surface,
                                          width: 4,
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.favorite,
                                        color: AppTheme.onTertiary,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            const SizedBox(height: 8),
                            Text(
                              'Reset Password',
                              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                fontSize: 32,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                "Don't worry, friend. We'll help you get back in.",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: AppTheme.onSurfaceVariant,
                                ),
                              ),
                            ),
                            
                            const SizedBox(height: 40),
                            
                            // Form
                            _ForgotPasswordInput(controller: _emailController),
                            
                            const SizedBox(height: 24),
                            
                            // Send Link Button
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              height: 56,
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _isLoading ? null : _handleSendLink,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.primary,
                                  foregroundColor: AppTheme.onPrimary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(9999),
                                  ),
                                  elevation: 8,
                                  shadowColor: AppTheme.primary.withOpacity(0.2),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (_isLoading) ...[
                                      const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Sending...',
                                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                          color: AppTheme.onPrimary,
                                        ),
                                      ),
                                    ] else ...[
                                      Text(
                                        'Send Recovery Link',
                                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                          color: AppTheme.onPrimary,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      const Icon(Icons.arrow_forward, size: 20),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                            
                            const SizedBox(height: 40),
                            
                            // Secondary Actions
                            TextButton.icon(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.arrow_back, size: 18),
                              label: const Text('Back to Login'),
                              style: TextButton.styleFrom(
                                foregroundColor: AppTheme.primary,
                                textStyle: Theme.of(context).textTheme.labelMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Supportive Visual Component (Quick Tip)
          Positioned(
            bottom: 48,
            right: 48,
            child: _buildQuickTipWidget(context),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickTipWidget(BuildContext context) {
    // We only show this on larger screens logically, but we'll include it here
    // as it's part of the design.
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: AppTheme.primaryFixed,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.lightbulb,
              color: AppTheme.primary,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Quick Tip',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppTheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Check your spam folder just in case!',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ForgotPasswordInput extends StatefulWidget {
  final TextEditingController? controller;

  const _ForgotPasswordInput({this.controller});

  @override
  State<_ForgotPasswordInput> createState() => _ForgotPasswordInputState();
}

class _ForgotPasswordInputState extends State<_ForgotPasswordInput> {
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
            'Registered Email Address',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: AppTheme.onSurfaceVariant,
            ),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: _isFocused ? AppTheme.surface : AppTheme.surfaceContainer,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _isFocused ? AppTheme.primary : Colors.transparent,
              width: 2,
            ),
          ),
          child: TextField(
            controller: widget.controller,
            focusNode: _focusNode,
            keyboardType: TextInputType.emailAddress,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.onSurface,
            ),
            decoration: InputDecoration(
              hintText: 'name@example.com',
              hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.outline,
              ),
              prefixIcon: Icon(
                Icons.mail_outline,
                color: AppTheme.outline,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
          ),
        ),
      ],
    );
  }
}
