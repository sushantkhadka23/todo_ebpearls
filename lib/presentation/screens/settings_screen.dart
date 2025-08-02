import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// You'll need to create these BLoCs for theme management
// import 'package:todo_ebpearls/presentation/bloc/theme_bloc.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with TickerProviderStateMixin {
  late AnimationController _fadeAnimationController;
  late AnimationController _slideAnimationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // Theme mode options
  ThemeMode _selectedThemeMode = ThemeMode.system;

  // Available app colors
  final List<AppColor> _appColors = [
    AppColor('Blue', Colors.blue, Colors.blue.shade700),
    AppColor('Purple', Colors.purple, Colors.purple.shade700),
    AppColor('Green', Colors.green, Colors.green.shade700),
    AppColor('Orange', Colors.orange, Colors.orange.shade700),
    AppColor('Red', Colors.red, Colors.red.shade700),
    AppColor('Teal', Colors.teal, Colors.teal.shade700),
    AppColor('Indigo', Colors.indigo, Colors.indigo.shade700),
    AppColor('Pink', Colors.pink, Colors.pink.shade700),
    AppColor('Cyan', Colors.cyan, Colors.cyan.shade700),
    AppColor('Amber', Colors.amber, Colors.amber.shade700),
  ];

  int _selectedColorIndex = 0;

  @override
  void initState() {
    super.initState();

    _fadeAnimationController = AnimationController(duration: const Duration(milliseconds: 400), vsync: this);

    _slideAnimationController = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeAnimationController, curve: Curves.easeOut));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideAnimationController, curve: Curves.easeOutQuart));

    // Start animations
    _fadeAnimationController.forward();
    _slideAnimationController.forward();

    // Load saved preferences
    _loadSavedPreferences();
  }

  @override
  void dispose() {
    _fadeAnimationController.dispose();
    _slideAnimationController.dispose();
    super.dispose();
  }

  void _loadSavedPreferences() {
    // TODO: Load saved theme mode and color from SharedPreferences
    // For now, using default values
    setState(() {
      _selectedThemeMode = ThemeMode.system;
      _selectedColorIndex = 0;
    });
  }

  void _saveThemeMode(ThemeMode themeMode) {
    setState(() {
      _selectedThemeMode = themeMode;
    });
    // TODO: Save to SharedPreferences and update theme via BLoC
    // context.read<ThemeBloc>().add(ChangeThemeMode(themeMode));

    _showSuccessMessage('Theme updated successfully!');
  }

  void _saveAppColor(int colorIndex) {
    setState(() {
      _selectedColorIndex = colorIndex;
    });
    // TODO: Save to SharedPreferences and update color via BLoC
    // context.read<ThemeBloc>().add(ChangeAppColor(_appColors[colorIndex]));

    _showSuccessMessage('App color updated successfully!');
  }

  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const FaIcon(FontAwesomeIcons.check, color: Colors.white, size: 16),
            const SizedBox(width: 12),
            Text(message),
          ],
        ),
        backgroundColor: Colors.green.shade400,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: _buildAppBar(),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeaderSection(),
                const SizedBox(height: 24),
                _buildThemeSection(),
                const SizedBox(height: 24),
                _buildColorSection(),
                const SizedBox(height: 24),
                _buildAppInfoSection(),
                const SizedBox(height: 24),
                _buildAboutSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: Theme.of(context).colorScheme.onSurface,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const FaIcon(FontAwesomeIcons.arrowLeft, size: 16),
        ),
      ),
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.purple.shade100, borderRadius: BorderRadius.circular(12)),
            child: FaIcon(FontAwesomeIcons.gear, color: Colors.purple, size: 20),
          ),
          const SizedBox(width: 12),
          Text('Settings', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple.shade50, Colors.purple.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.purple.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.purple.shade100, borderRadius: BorderRadius.circular(12)),
            child: FaIcon(FontAwesomeIcons.palette, color: Colors.purple, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Customize Your Experience',
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.purple.shade700),
                ),
                const SizedBox(height: 4),
                Text(
                  'Personalize the app theme and appearance to your liking',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeSection() {
    return _buildSection(
      title: 'Theme Mode',
      icon: FontAwesomeIcons.moon,
      child: Column(
        children: [
          _buildThemeOption(
            title: 'Light Mode',
            subtitle: 'Clean and bright interface',
            icon: FontAwesomeIcons.sun,
            themeMode: ThemeMode.light,
            color: Colors.amber,
          ),
          const SizedBox(height: 12),
          _buildThemeOption(
            title: 'Dark Mode',
            subtitle: 'Easy on the eyes in low light',
            icon: FontAwesomeIcons.moon,
            themeMode: ThemeMode.dark,
            color: Colors.indigo,
          ),
          const SizedBox(height: 12),
          _buildThemeOption(
            title: 'System Default',
            subtitle: 'Follow device system settings',
            icon: FontAwesomeIcons.mobile,
            themeMode: ThemeMode.system,
            color: Colors.green,
          ),
        ],
      ),
    );
  }

  Widget _buildThemeOption({
    required String title,
    required String subtitle,
    required IconData icon,
    required ThemeMode themeMode,
    required Color color,
  }) {
    final isSelected = _selectedThemeMode == themeMode;

    return GestureDetector(
      onTap: () => _saveThemeMode(themeMode),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
              : Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.outline.withOpacity(0.2),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(10)),
              child: FaIcon(icon, color: color, size: 18),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Theme.of(context).colorScheme.primary : null,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary, shape: BoxShape.circle),
                child: const FaIcon(FontAwesomeIcons.check, color: Colors.white, size: 12),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorSection() {
    return _buildSection(
      title: 'App Color',
      icon: FontAwesomeIcons.palette,
      child: Column(
        children: [
          Text(
            'Choose your preferred color theme for the app interface',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1,
            ),
            itemCount: _appColors.length,
            itemBuilder: (context, index) {
              final appColor = _appColors[index];
              final isSelected = _selectedColorIndex == index;

              return GestureDetector(
                onTap: () => _saveAppColor(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: appColor.lightColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: isSelected ? appColor.darkColor : Colors.transparent, width: 3),
                    boxShadow: isSelected
                        ? [BoxShadow(color: appColor.lightColor.withOpacity(0.4), blurRadius: 8, spreadRadius: 2)]
                        : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (isSelected)
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 4)],
                          ),
                          child: FaIcon(FontAwesomeIcons.check, color: appColor.darkColor, size: 12),
                        )
                      else
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(color: appColor.darkColor, shape: BoxShape.circle),
                        ),
                      const SizedBox(height: 4),
                      Text(
                        appColor.name,
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 10),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAppInfoSection() {
    return _buildSection(
      title: 'App Information',
      icon: FontAwesomeIcons.circleInfo,
      child: Column(
        children: [
          _buildInfoTile(title: 'Version', subtitle: '1.0.0', icon: FontAwesomeIcons.tag, color: Colors.blue),
          const SizedBox(height: 12),
          _buildInfoTile(title: 'Developer', subtitle: 'Your Name', icon: FontAwesomeIcons.user, color: Colors.green),
          const SizedBox(height: 12),
          _buildInfoTile(
            title: 'Storage Used',
            subtitle: '2.5 MB',
            icon: FontAwesomeIcons.database,
            color: Colors.orange,
            onTap: () => _showStorageInfo(),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Theme.of(context).colorScheme.outline.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(8)),
              child: FaIcon(icon, color: color, size: 16),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
                  ),
                ],
              ),
            ),
            if (onTap != null)
              FaIcon(
                FontAwesomeIcons.chevronRight,
                size: 14,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutSection() {
    return _buildSection(
      title: 'About',
      icon: FontAwesomeIcons.heart,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.red.shade200),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: Colors.red.shade100, borderRadius: BorderRadius.circular(8)),
                      child: FaIcon(FontAwesomeIcons.heart, color: Colors.red, size: 16),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Made with ❤️ for productivity',
                        style: Theme.of(
                          context,
                        ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600, color: Colors.red.shade700),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'This app was created to help you manage your tasks efficiently and boost your productivity. Thank you for using our app!',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.red, height: 1.4),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  title: 'Rate App',
                  icon: FontAwesomeIcons.star,
                  color: Colors.amber,
                  onTap: () => _showRateDialog(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildActionButton(
                  title: 'Share App',
                  icon: FontAwesomeIcons.share,
                  color: Colors.blue,
                  onTap: () => _shareApp(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(icon, color: color, size: 16),
            const SizedBox(width: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600, color: color),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required IconData icon, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            FaIcon(icon, size: 18, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 12),
            Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 16),
        child,
      ],
    );
  }

  void _showStorageInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.database, color: Colors.orange.shade400, size: 20),
            const SizedBox(width: 12),
            const Text('Storage Information'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStorageItem('Tasks Database', '1.8 MB'),
            _buildStorageItem('App Cache', '512 KB'),
            _buildStorageItem('User Preferences', '128 KB'),
            const Divider(),
            _buildStorageItem('Total Used', '2.5 MB', isTotal: true),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showClearCacheDialog();
            },
            child: const Text('Clear Cache'),
          ),
        ],
      ),
    );
  }

  Widget _buildStorageItem(String label, String size, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: isTotal ? FontWeight.bold : FontWeight.normal),
          ),
          Text(
            size,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  void _showClearCacheDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.broom, color: Colors.orange.shade400, size: 20),
            const SizedBox(width: 12),
            const Text('Clear Cache'),
          ],
        ),
        content: const Text('This will clear temporary files and cached data. Your tasks and settings will remain intact.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSuccessMessage('Cache cleared successfully!');
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange.shade400, foregroundColor: Colors.white),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  void _showRateDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.star, color: Colors.amber.shade400, size: 20),
            const SizedBox(width: 12),
            const Text('Rate Our App'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('We hope you\'re enjoying the app! Would you mind taking a moment to rate it?'),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    _showSuccessMessage('Thank you for your rating!');
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: FaIcon(FontAwesomeIcons.solidStar, color: Colors.amber.shade400, size: 24),
                  ),
                );
              }),
            ),
          ],
        ),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Maybe Later'))],
      ),
    );
  }

  void _shareApp() {
    _showSuccessMessage('Share functionality would open here!');
    // TODO: Implement share functionality
    // Share.share('Check out this amazing TODO app!');
  }
}

class AppColor {
  final String name;
  final Color lightColor;
  final Color darkColor;

  AppColor(this.name, this.lightColor, this.darkColor);
}
