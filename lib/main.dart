import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'package:busy_bee/config/app_theme.dart';
import 'package:busy_bee/firebase_options.dart';
import 'package:busy_bee/presentation/router/router.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  tz.initializeTimeZones();

  runApp(const ProviderScope(child: BusyBee()));
}

class BusyBee extends StatefulWidget {
  const BusyBee({super.key});

  @override
  State<BusyBee> createState() => _BusyBeeState();
}

class _BusyBeeState extends State<BusyBee> {
  @override
  void initState() {
    super.initState();

    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      routerConfig: router,
      title: 'Busy Bee',
    );
  }
}
