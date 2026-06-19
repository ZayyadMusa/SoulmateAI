import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class DataExportScreen extends StatefulWidget {
  const DataExportScreen({super.key});

  @override
  State<DataExportScreen> createState() => _DataExportScreenState();
}

class _DataExportScreenState extends State<DataExportScreen> with SingleTickerProviderStateMixin {
  late AnimationController _morphController;
  late Animation<double> _morphRadiusAnimation;

  bool _chatPdf = true;
  bool _chatJson = false;
  bool _voiceMp3 = true;
  bool _memoryCsv = true;

  @override
  void initState() {
    super.initState();
    _morphController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _morphRadiusAnimation = Tween<double>(begin: 0.4, end: 0.7).animate(
      CurvedAnimation(parent: _morphController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _morphController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        backgroundColor: AppTheme.surface.withOpacity(0.8),
        elevation: 0,
        scrolledUnderElevation: 4,
        shadowColor: AppTheme.primary.withOpacity(0.04),
        titleSpacing: 24,
        title: Row(
          children: [
            AnimatedBuilder(
              animation: _morphController,
              builder: (context, child) {
                return Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryContainer.withOpacity(0.2),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40 * _morphRadiusAnimation.value),
                      topRight: Radius.circular(40 * (1 - _morphRadiusAnimation.value)),
                      bottomLeft: Radius.circular(40 * 0.3),
                      bottomRight: Radius.circular(40 * 0.7),
                    ),
                  ),
                  child: const Icon(Icons.auto_awesome, color: AppTheme.primary, size: 20),
                );
              },
            ),
            const SizedBox(width: 12),
            Text(
              'Soulmate',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppTheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: AppTheme.onSurfaceVariant),
            onPressed: () {},
          ),
          Container(
            margin: const EdgeInsets.only(right: 16),
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: AppTheme.secondaryFixed,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person, color: AppTheme.onSecondaryFixed),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 120),
          children: [
            // Breadcrumb / Header
            Row(
              children: [
                const Icon(Icons.arrow_back, color: AppTheme.onSurfaceVariant, size: 18),
                const SizedBox(width: 8),
                Text(
                  'Privacy & Security',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppTheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Data & Conversation Export',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontSize: 28,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Your memories and shared moments belong to you. Choose which parts of your journey you would like to download.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppTheme.onSurfaceVariant,
              ),
            ),

            const SizedBox(height: 40),

            // Export Options List
            _buildExportCard(
              icon: Icons.chat,
              iconColor: AppTheme.primary,
              iconBgColor: AppTheme.primaryFixed.withOpacity(0.3),
              title: 'Chat History',
              description: 'A complete transcript of your text-based conversations with Soulmate.',
              options: [
                _buildCheckboxOption('PDF', 'Readable', _chatPdf, (val) => setState(() => _chatPdf = val!)),
                const SizedBox(width: 8),
                _buildCheckboxOption('JSON', 'Data format', _chatJson, (val) => setState(() => _chatJson = val!)),
              ],
            ),
            const SizedBox(height: 16),
            _buildExportCard(
              icon: Icons.mic,
              iconColor: AppTheme.tertiary,
              iconBgColor: AppTheme.tertiaryFixed.withOpacity(0.3),
              title: 'Voice Recordings',
              description: 'An archive of audio snippets and voice messages from your reflections.',
              options: [
                _buildCheckboxOption('MP3 Archive', null, _voiceMp3, (val) => setState(() => _voiceMp3 = val!)),
              ],
            ),
            const SizedBox(height: 16),
            _buildExportCard(
              icon: Icons.auto_awesome,
              iconColor: AppTheme.secondary,
              iconBgColor: AppTheme.secondaryFixed.withOpacity(0.3),
              title: 'Memory Jar Data',
              description: 'Structured insights, habit patterns, and emotional landmarks Soulmate has noted.',
              options: [
                _buildCheckboxOption('CSV Data', null, _memoryCsv, (val) => setState(() => _memoryCsv = val!)),
              ],
            ),

            const SizedBox(height: 40),

            // Summary & Action Box
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: AppTheme.surfaceContainer,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.verified_user, color: AppTheme.primary),
                      const SizedBox(width: 12),
                      Text(
                        'SECURE REQUEST',
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: AppTheme.primary,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Ready to prepare?',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Once you confirm, our systems will securely compile your requested archives. This process ensures all your data is encrypted and packed safely for transit.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildSummaryItem(Icons.schedule, 'Preparation takes ', '24-48 hours', ''),
                  const SizedBox(height: 16),
                  _buildSummaryItem(Icons.mail, 'Links will be sent to ', 'alex.doe@email.com', ''),
                  const SizedBox(height: 16),
                  _buildSummaryItem(Icons.lock_reset, 'Links expire in ', '7 days', ' for your security'),
                  const SizedBox(height: 32),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppTheme.primary, AppTheme.primaryContainer],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(9999),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primary.withOpacity(0.2),
                          blurRadius: 16,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.send, size: 20, color: Colors.white),
                      label: Text(
                        'Request Data Export',
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9999),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: Text.rich(
                      TextSpan(
                        text: 'By requesting, you agree to our ',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppTheme.onSurfaceVariant.withOpacity(0.6),
                        ),
                        children: const [
                          TextSpan(
                            text: 'Data Privacy Terms',
                            style: TextStyle(decoration: TextDecoration.underline),
                          ),
                          TextSpan(text: '.'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppTheme.surface.withOpacity(0.8),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primary.withOpacity(0.06),
              blurRadius: 32,
              offset: const Offset(0, -8),
            ),
          ],
        ),
        padding: const EdgeInsets.only(bottom: 24, top: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.auto_awesome_outlined, 'Reflect', false),
            _buildNavItem(Icons.self_improvement_outlined, 'Rituals', false),
            _buildNavItem(Icons.favorite_border, 'Soulmate', false),
            _buildNavItem(Icons.person, 'Settings', true),
          ],
        ),
      ),
    );
  }

  Widget _buildExportCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required String description,
    required List<Widget> options,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withOpacity(0.04),
            blurRadius: 32,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontSize: 18,
                      ),
                    ),
                    const Icon(Icons.info_outline, color: AppTheme.outline, size: 20),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 16),
                Row(children: options),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckboxOption(String label, String? subtext, bool value, ValueChanged<bool?> onChanged) {
    return InkWell(
      onTap: () => onChanged(!value),
      borderRadius: BorderRadius.circular(9999),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppTheme.surfaceContainer,
          borderRadius: BorderRadius.circular(9999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 16,
              height: 16,
              child: Checkbox(
                value: value,
                onChanged: onChanged,
                activeColor: AppTheme.primary,
                side: const BorderSide(color: AppTheme.outline),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppTheme.onSurface,
              ),
            ),
            if (subtext != null) ...[
              const SizedBox(width: 4),
              Text(
                subtext,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontSize: 10,
                  color: AppTheme.onSurfaceVariant.withOpacity(0.6),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(IconData icon, String text1, String boldText, String text2) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.primary, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text.rich(
            TextSpan(
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.onSurface,
              ),
              children: [
                TextSpan(text: text1),
                TextSpan(
                  text: boldText,
                  style: const TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                ),
                TextSpan(text: text2),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        decoration: isActive
            ? BoxDecoration(
                color: AppTheme.primaryFixed,
                borderRadius: BorderRadius.circular(9999),
              )
            : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive ? AppTheme.onPrimaryFixedVariant : AppTheme.onSurfaceVariant,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontSize: 10,
                color: isActive ? AppTheme.onPrimaryFixedVariant : AppTheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
