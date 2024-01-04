import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mindfullearn_dashboard/controllers/posts_provider.dart';
import 'package:mindfullearn_dashboard/controllers/reels_provider.dart';
import 'package:mindfullearn_dashboard/views/common/side_bar.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => PostsNotifier()),
    ChangeNotifierProvider(create: (context) => ReelsNotifier()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mindfullearn Dashboard',
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: SidebarPage());
  }
}
