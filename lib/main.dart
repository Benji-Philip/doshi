import 'dart:io';

import 'package:doshi/isar/app_settings_database.dart';
import 'package:doshi/isar/category_database.dart';
import 'package:doshi/isar/entries_database.dart';
import 'package:doshi/pages/home_page.dart';
import 'package:doshi/riverpod/states.dart';
import 'package:doshi/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await AppSettingsDatabaseNotifier.initialise();
  await EntryDatabaseNotifier.initialise();
  await CategoryDatabaseNotifier.initialise();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    setOptimalDisplayMode();
    readEntries();
    setDefaultValues(ref);
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      if (ref.read(appOpenedTime) != DateFormat('d').format(DateTime.now())) {
        ref.read(entryDatabaseProvider.notifier).fetchEntries();
        ref
            .read(appOpenedTime.notifier)
            .update((state) => DateFormat('d').format(DateTime.now()));
      }
      ref.read(currentPage.notifier).update((state) => "Home");
    }
  }

  void readEntries() {
    ref.read(appSettingsDatabaseProvider.notifier).fetchEntries();
    ref.read(entryDatabaseProvider.notifier).fetchEntries();
    ref.read(categoryDatabaseProvider.notifier).fetchEntries();
  }

  Future<void> setOptimalDisplayMode() async {
    if (Platform.isAndroid) {
      final List<DisplayMode> supported = await FlutterDisplayMode.supported;
      final DisplayMode active = await FlutterDisplayMode.active;

      final List<DisplayMode> sameResolution = supported
          .where((DisplayMode m) =>
              m.width == active.width && m.height == active.height)
          .toList()
        ..sort((DisplayMode a, DisplayMode b) =>
            b.refreshRate.compareTo(a.refreshRate));

      final DisplayMode mostOptimalMode =
          sameResolution.isNotEmpty ? sameResolution.first : active;

      /// This setting is per session.
      /// Please ensure this was placed with `initState` of your root widget.
      await FlutterDisplayMode.setPreferredMode(mostOptimalMode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: darkMode,
      darkTheme: darkMode,
    );
  }
}
