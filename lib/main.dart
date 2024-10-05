import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_gallery/app.dart';
import 'package:web_gallery/providers/image_provider.dart';
import 'package:web_gallery/providers/page_notifier.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<PageNotifier>(create: (context) => PageNotifier()),
      ChangeNotifierProvider<ImagesProvider>(create: (_) => ImagesProvider()),
    ], child: const App());
  }
}
