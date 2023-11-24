import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controller/city_list_provider.dart';
import 'controller/hourly_forcast_provider.dart';
import 'controller/realtime_provider.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/search_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => RealtimeProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => HourlyForcastProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => CityListProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SearchPage(),
        HomePage.routeName : (context) =>const HomePage(),
        SearchPage.routeName : (context) =>const SearchPage(),

      },
    );
  }
}
