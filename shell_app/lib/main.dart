import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mf_posts/mf_posts.dart';
import 'package:mf_auth/mf_auth.dart';
import 'package:mf_profile/mf_profile.dart';
import 'package:mf_settings/mf_settings.dart';
import 'package:shell_app/routes/app_router.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _setPreferredOrientations();
  
  // Inicializar módulos
  await AuthModule.init();
  await PostsModule.init();
  await ProfileModule.init();
  await SettingsModule.init();
  
  runApp(const MyApp());
}

Future<void> _setPreferredOrientations() {
  return SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeStore _themeStore = GetIt.instance<ThemeStore>();
  final LanguageStore _languageStore = GetIt.instance<LanguageStore>();
  
  @override
  void initState() {
    super.initState();
    // Subscribe to events
    GlobalEventBus.instance.on<ThemeChangedEvent>().listen((event) {
      setState(() {});
    });
    
    GlobalEventBus.instance.on<LanguageChangedEvent>().listen((event) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MaterialApp.router(
        title: 'Boilerplate App',
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
        theme: _themeStore.isDarkMode 
            ? SharedThemeProvider.darkThemeData
            : SharedThemeProvider.lightThemeData,
        locale: Locale(_languageStore.languageCode),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('es', 'ES'),
        ],
      ),
    );
  }
}
