import 'package:flutter/material.dart';
import 'package:group28/database/database.dart';
import 'package:group28/repositories/databaseRepository.dart';
import 'package:group28/screens/FetchPage.dart';
import 'package:provider/provider.dart';
import 'package:group28/screens/GoalPage.dart';
import 'package:group28/screens/HomePage.dart';
import 'package:group28/screens/Goal2Page.dart';
import 'package:group28/utils/cart.dart';
import 'package:group28/screens/LoginPage.dart';
Future<void> main() async {
  //This is a special method that use WidgetFlutterBinding to interact with the Flutter engine.
  //This is needed when you need to interact with the native core of the app.
  //Here, we need it since when need to initialize the DB before running the app.
  WidgetsFlutterBinding.ensureInitialized();

  //This opens the database.
  final AppDatabase database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  //This creates a new DatabaseRepository from the AppDatabase instance just initialized
  final databaseRepository = DatabaseRepository(database: database);

  //Here, we run the app and we provide to the whole widget tree the instance of the DatabaseRepository.
  //That instance will be then shared through the platform and will be unique.
  runApp(ChangeNotifierProvider<DatabaseRepository>(
    create: (context) => databaseRepository,
    child: MyApp(),
  ));
} //main

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Cart>(
      create: (context) => Cart(),
      child: MaterialApp(
        //This specifies the entrypoint
        initialRoute: LoginPage.route,
        //Manage Navigation. This approach can be handy when you need to
        //pass data to a route directly to its constructor and you want to continue to use pushNamed().
        onGenerateRoute: (settings) {   
          if (settings.name == LoginPage.route) {
            return MaterialPageRoute(builder: (context) {
              return LoginPage();
            });
          }          
          if (settings.name == HomePage.route) {
            return MaterialPageRoute(builder: (context) {
              return HomePage();
            });
          } else if (settings.name == GoalPage.route) {
            final args = settings.arguments as Map;
            return MaterialPageRoute(builder: (context) {
              //We will get access to the DB via the provided DatabaseRepository and we will get the id of the goal.
              return GoalPage(pace: args['pace']);
            });
          }
          if (settings.name == Goal2Page.route) {
            final args = settings.arguments as Map;
            return MaterialPageRoute(builder: (context) {
              //We will get access to the DB via the provided DatabaseRepository and we will get the id of the goal.
              return Goal2Page(sed: args['sed']);
            });
          }
          else {
            return null;
          } //if-else
        }, //onGenerateRoute
      ),
    );
  } //build
} //MyApp