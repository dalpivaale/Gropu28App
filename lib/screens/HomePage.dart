import 'package:flutter/material.dart';
import 'package:group28/database/entities/sedentary.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:group28/database/entities/pace.dart';
import 'package:group28/repositories/databaseRepository.dart';
import 'package:group28/utils/formats.dart';
import 'package:provider/provider.dart';
import 'package:group28/screens/GoalPage.dart';
import 'package:group28/screens/Goal2Page.dart';
import 'package:group28/screens/LoginPage.dart';
import 'package:group28/screens/FetchPage.dart';
import 'package:group28/screens/FetchPage2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'GoalPage.dart';

//Homepage screen. It will show the list of goals setted.
class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  static const route = '/home/';
  static const routeDisplayName = 'Homepage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedScreenIndex = 0;
  final List _screens = [
    {"screen": GoalPage(), "title": "Screen A Title"},
    {"screen": Goal2Page(), "title": "Screen B Title"}
  ];

  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }
DateTime date = DateTime.parse('1969-07-20 20:18:04Z');
double? goal;
DateTime date2 = DateTime.parse('1969-07-20 20:18:04Z');
double? goal2;
  @override
  Widget build(BuildContext context) {
    //Print the route display name for debugging
    print('${HomePage.routeDisplayName} built');

    return Scaffold(
      appBar: AppBar(
        title: Text(HomePage.routeDisplayName),
         backgroundColor: Colors.purple,
      ),
         floatingActionButton: Wrap(
        //will break to another line on overflow
        direction: Axis.horizontal, //use vertical to show  on vertical axis
        children: <Widget>[
          Container(
              margin: EdgeInsets.all(10),
              child: FloatingActionButton(
                onPressed: () => _toGoalPage(context, null),
                backgroundColor: Colors.purpleAccent,
                child: Icon(MdiIcons.hiking),
                heroTag: "btn1",
              )), //button first
          Container(
              margin: EdgeInsets.all(10),
              child: FloatingActionButton(
                onPressed: () =>
                    _toGoal2Page(context, null), //action code for button 2,
                backgroundColor: Colors.purpleAccent,
                child: Icon(MdiIcons.seatPassenger),
                 heroTag: "btn2",
              )),
        ],
      ), 
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.purple,
              ),
              child: Text('User Profile'),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              iconColor: Colors.purpleAccent,
              title: Text('Logout'),
              onTap: () => _toLoginPage(context),
            ),
          ],
        ),
      ),
      body: Column(children: [
         const SizedBox(height: 30.0),   
        Center(
          //We will show the Pace table with a ListView.
          //To do so, we use a Consumer of DatabaseRepository in order to rebuild the widget tree when
          //entries are deleted, created or updated.
          child: Consumer<DatabaseRepository>(builder: (context, dbr, child) {
            //The logic is to query the DB for the entire list of Paces using dbr.findAllPaces()
            //and then populate the ListView accordingly.
            //We need to use a FutureBuilder since the result of dbr.findAllPaces() is a Future.
            return FutureBuilder(
              initialData: null,
              future: dbr.findAllPaces(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data1 = snapshot.data as List<Pace>;
                  //If the Goal table is empty, show a simple Text, otherwise show the list of meals using a ListView.
                  return data1.length == 0
                      ? Text('You have not set a step goal yet')
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: data1.length,
                          itemBuilder: (context, stepIndex) {
                           date = data1[stepIndex].dateTime;
                           goal = data1[stepIndex].steptodo;
                            //Here, we are using a Card to show a Goal
                            return Card(
                                elevation: 5,
                                child: Dismissible(
                                  key: UniqueKey(),
                                  background: Container(color: Colors.red),
                                  child: ListTile(
                                    leading: Icon(MdiIcons.hiking),                                  
                                    title: Text(
                                        'GOAL : ${data1[stepIndex].steptodo}'),
                                    subtitle: Text(
                                        ' From ${Formats.onlyDayDateFormat.format(data1[stepIndex].dateTime)}'),
                                    //When a ListTile is tapped, the user is redirected to the Graphic Page, where the data will be fetched and it's shown a graphic.
                                    onTap: () => _tofetchPage(context, date, goal),
                                  ),
                                  onDismissed: (direction) async {
                                    await Provider.of<DatabaseRepository>(
                                            context,
                                            listen: false)
                                        .removePace(data1[stepIndex]);
                                  },
                                ));
                          });
                } else {
                  return CircularProgressIndicator();
                } //else
              }, //FutureBuilder builder
            );
          } //Consumer-builder
              ),
        ),
        Center(
          child: Consumer<DatabaseRepository>(builder: (context, dbr, child) {
            //The logic is to query the DB for the entire list of Sedentary minutes using dbr.findAllSeds()
            //and then populate the ListView accordingly.
            //We need to use a FutureBuilder since the result of dbr.findAllSeds() is a Future.
            return FutureBuilder(
              initialData: null,
              future: dbr.findAllSeds(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data2 = snapshot.data as List<Sed>;
                  //If the Sed table is empty, show a simple Text, otherwise show the list of seds using a ListView.
                  return data2.length == 0
                      ? Text('You have not set a sedentary goal yet')
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: data2.length,
                          itemBuilder: (context, sedIndex) {
                          date2 = data2[sedIndex].dateTime;
                           goal2 = data2[sedIndex].minsed;
                            //Here, we are using a Card to show a Goal
                            return Card(
                              elevation: 5,
                              child: Dismissible(
                                key: UniqueKey(),
                                background: Container(color: Colors.red),
                                child: ListTile(
                                    leading: Icon(MdiIcons.seatPassenger),                                    
                                    title:
                                        Text('GOAL : ${data2[sedIndex].minsed}'),
                                    subtitle: Text(
                                        'From ${Formats.onlyDayDateFormat.format(data2[sedIndex].dateTime)}'),
                                    //When a ListTile is tapped, the user is redirected to the Graphic Page, where the data will be fetched and it's shown a graphic.
                                    onTap: () => _tofetchPage2(context,date2,goal2)),
                                onDismissed: (direction) async {
                                  await Provider.of<DatabaseRepository>(context,
                                          listen: false)
                                      .removeSed(data2[sedIndex]);
                                },
                              ),
                            );
                          });
                } else {
                  return CircularProgressIndicator();
                } //else
              }, //FutureBuilder builder
            );
          } //Consumer-builder,
              ),
        ),
      ]),
      //Here, we're using a FloatingActionButton to let the user add new goals.
      //Rationale: I'm using null as goal to let GoalPage know that we want to add a new goal
    );
  } //build

  //Utility method to navigate to GoalPage
  void _toGoalPage(BuildContext context, Pace? pace) {
    Navigator.pushNamed(context, GoalPage.route, arguments: {'pace': pace});
  } //_toGoalPage

  //Utility method to navigate to GoalPage
  void _toGoal2Page(BuildContext context, Sed? sed) {    
    Navigator.pushNamed(context, Goal2Page.route, arguments: {'Sed': sed});
  } //_toGoalPage

  //Utility method to navigate to GraphicPage
  void _tofetchPage(BuildContext context, DateTime? date, double? goal) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => FetchPage(selectedDatePace: date as DateTime, obbiettivo: goal )));        
    //Navigator.pushNamed(context, FetchPage.route, arguments: {'date': date});
  } 
  void _tofetchPage2(BuildContext context, DateTime? date, double? goal) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => FetchPage2(selectedDatePace: date2 as DateTime, obbiettivo: goal2 )));//_toGraphicPage
  }
  void _toLoginPage(BuildContext context) async {
  //Unset the 'username' filed in SharedPreference
  final sp = await SharedPreferences.getInstance();
  sp.remove('username');

  //Pop the drawer first
  Navigator.pop(context);
  //Then pop the HomePage
  Navigator.of(context).pushReplacementNamed(LoginPage.route);
  //} //_toLoginPage

   }
 } 
