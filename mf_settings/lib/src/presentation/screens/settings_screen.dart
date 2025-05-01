import 'package:flutter/material.dart';
import 'package:mf_settings/src/presentation/store/language_store.dart';
import 'package:mf_settings/src/presentation/store/theme_store.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final ThemeStore _themeStore = GetIt.instance<ThemeStore>();
  final LanguageStore _languageStore = GetIt.instance<LanguageStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context).translate("settings_title"),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 32),
              _buildThemeSection(),
              const Divider(height: 32),
              _buildLanguageSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThemeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).translate("theme_title"),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Observer(
          builder: (_) => SwitchListTile(
            title: Text(AppLocalizations.of(context).translate("dark_mode")),
            value: _themeStore.isDarkMode,
            onChanged: (value) {
              _themeStore.setDarkMode(value);
            },
            secondary: Icon(
              _themeStore.isDarkMode
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLanguageSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).translate("language_title"),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Observer(
          builder: (_) => Column(
            children: [
              RadioListTile<String>(
                title: const Text('English'),
                value: 'en',
                groupValue: _languageStore.languageCode,
                onChanged: (value) {
                  if (value != null) {
                    _languageStore.setLanguage(value);
                  }
                },
              ),
              RadioListTile<String>(
                title: const Text('Español'),
                value: 'es',
                groupValue: _languageStore.languageCode,
                onChanged: (value) {
                  if (value != null) {
                    _languageStore.setLanguage(value);
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
} 