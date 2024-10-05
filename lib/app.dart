import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_gallery/providers/page_notifier.dart';
import 'package:web_gallery/routes/app_router_delegate.dart';
import 'routes/routeinfoparser.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationParser: AppRouteInformationParser(),
      routerDelegate:
          AppRouterDelegate(notifier: Provider.of<PageNotifier>(context)),
      title: 'Gallery',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
