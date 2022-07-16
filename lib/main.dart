import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stopwatch_app/theme.dart';
import 'package:stopwatch_app/theme_provider.dart';

import './home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => Mytheme(),
        child: Consumer<Mytheme>(
          builder: (context, theme, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'StopWatch_app',
            theme: themeData(context),
            darkTheme: darkThemeData(context),
            themeMode: theme.islightTheme ? ThemeMode.light : ThemeMode.dark,
            home: const HomePage(),
          ),
        ));
  }
}

