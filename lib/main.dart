import 'package:flutter/material.dart';

import 'ui/styles/theme.dart';
import 'ui/views/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Order NTC', theme: appLightTheme, home: HomeView());
  }
}
