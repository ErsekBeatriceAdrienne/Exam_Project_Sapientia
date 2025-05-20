import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'frontend/language_supports/provider_local.dart';
import 'frontend/pages/splashscreen/staring_the_app.dart';
import 'package:window_size/window_size.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /*if (Platform.isWindows) {
    setWindowTitle('Learn DSA');
    const size = Size(600, 1100);
    setWindowMinSize(size);
    setWindowMaxSize(size);

    final screen = await getCurrentScreen();
    if (screen != null) {
      final frame = Rect.fromLTWH(
        screen.frame.left + (screen.frame.width - size.width) / 2,
        screen.frame.top + (screen.frame.height - size.height) / 2,
        size.width,
        size.height,
      );
      setWindowFrame(frame);
    }
  }*/

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    ChangeNotifierProvider(
      // Provider for languages across app
      create: (_) => LocaleProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget
{
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State <MyApp>
{
  ThemeMode _themeMode = ThemeMode.light;
  bool _isLoading = true;
  Widget? _initialScreen;

  @override
  void initState()
  {
    super.initState();
    _checkLoginStatus();
  }

  void _toggleTheme()
  {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  void _onInitializationComplete(Widget screen) {
    setState(() {
      _initialScreen = screen;
    });
  }

  Future<void> _checkLoginStatus() async {
    setState(() {
      _initialScreen = InitialSplash(
          toggleTheme: _toggleTheme,
          onInitializationComplete: _onInitializationComplete);
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context)
  {
    // language supports
    final provider = Provider.of<LocaleProvider>(context);

    if (_isLoading)
    {
      return MaterialApp(
        home: Scaffold(
          body: Center(
            child: InitialSplash(
                toggleTheme: _toggleTheme,
                onInitializationComplete: _onInitializationComplete),
          ),
        ),
      );
    }

    return MaterialApp(
      title: 'Learn DSA',
      locale: provider.locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first; // fallback
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
          },
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: _themeMode,
      home: _initialScreen,
    );
  }
}