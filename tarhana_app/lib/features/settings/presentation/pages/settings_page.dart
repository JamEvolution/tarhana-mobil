import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tarhana_app/core/router/app_router.dart';
import 'package:tarhana_app/core/theme/app_theme.dart';

@RoutePage()
class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  bool _isDarkMode = false;
  bool _isNotificationsEnabled = true;
  String _selectedLanguage = 'Türkçe';

  @override
  void initState() {
    super.initState();
    // TODO: Load settings from preferences
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayarlar'),
      ),
      body: ListView(
        children: [
          // Tema Ayarları
          _buildSectionHeader(context, 'Görünüm'),
          SwitchListTile(
            title: const Text('Karanlık Tema'),
            subtitle: const Text('Uygulamayı karanlık temada görüntüle'),
            value: _isDarkMode,
            onChanged: (value) {
              setState(() {
                _isDarkMode = value;
              });
              // TODO: Save theme preference
            },
            secondary: const Icon(Icons.dark_mode),
          ),
          const Divider(),

          // Bildirim Ayarları
          _buildSectionHeader(context, 'Bildirimler'),
          SwitchListTile(
            title: const Text('Bildirimler'),
            subtitle: const Text('Uygulama bildirimlerini al'),
            value: _isNotificationsEnabled,
            onChanged: (value) {
              setState(() {
                _isNotificationsEnabled = value;
              });
              // TODO: Save notification preference
            },
            secondary: const Icon(Icons.notifications),
          ),
          const Divider(),

          // Dil Ayarları
          _buildSectionHeader(context, 'Dil'),
          ListTile(
            title: const Text('Uygulama Dili'),
            subtitle: Text(_selectedLanguage),
            leading: const Icon(Icons.language),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: _showLanguageDialog,
          ),
          const Divider(),

          // Hesap Ayarları
          _buildSectionHeader(context, 'Hesap'),
          ListTile(
            title: const Text('Şifre Değiştir'),
            leading: const Icon(Icons.lock),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // TODO: Navigate to change password page
            },
          ),
          ListTile(
            title: const Text('Hesabı Sil'),
            leading: const Icon(Icons.delete_forever),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: _showDeleteAccountDialog,
          ),
          const Divider(),

          // Uygulama Bilgileri
          _buildSectionHeader(context, 'Uygulama Hakkında'),
          ListTile(
            title: const Text('Gizlilik Politikası'),
            leading: const Icon(Icons.privacy_tip),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // TODO: Navigate to privacy policy page
            },
          ),
          ListTile(
            title: const Text('Kullanım Koşulları'),
            leading: const Icon(Icons.description),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // TODO: Navigate to terms of service page
            },
          ),
          ListTile(
            title: const Text('Sürüm'),
            subtitle: const Text('1.0.0'),
            leading: const Icon(Icons.info),
          ),
          const SizedBox(height: 24),

          // Çıkış Yap
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton.icon(
              onPressed: _showLogoutDialog,
              icon: const Icon(Icons.logout),
              label: const Text('Çıkış Yap'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.errorColor,
                foregroundColor: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Dil Seçin'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildLanguageOption('Türkçe'),
              _buildLanguageOption('English'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('İptal'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildLanguageOption(String language) {
    return RadioListTile<String>(
      title: Text(language),
      value: language,
      groupValue: _selectedLanguage,
      onChanged: (value) {
        if (value != null) {
          setState(() {
            _selectedLanguage = value;
          });
          // TODO: Save language preference
          Navigator.of(context).pop();
        }
      },
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Hesabı Sil'),
          content: const Text(
            'Hesabınızı silmek istediğinizden emin misiniz? Bu işlem geri alınamaz.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('İptal'),
            ),
            TextButton(
              onPressed: () {
                // TODO: Implement delete account logic
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: AppTheme.errorColor,
              ),
              child: const Text('Hesabı Sil'),
            ),
          ],
        );
      },
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Çıkış Yap'),
          content: const Text('Çıkış yapmak istediğinizden emin misiniz?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('İptal'),
            ),
            TextButton(
              onPressed: () {
                // TODO: Implement logout logic
                Navigator.of(context).pop();
                context.router.replace(const LoginRoute());
              },
              child: const Text('Çıkış Yap'),
            ),
          ],
        );
      },
    );
  }
} 