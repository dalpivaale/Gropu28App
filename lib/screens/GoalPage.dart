import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:group28/database/entities/pace.dart';
import 'package:group28/repositories/databaseRepository.dart';
import 'package:group28/widgets/formTiles.dart';
import 'package:group28/widgets/formSeparator.dart';
import 'package:group28/utils/formats.dart';
import 'package:provider/provider.dart';

//This is the class that implement the page to be used to edit existing goals and add new goals.
//This is a StatefulWidget since it needs to rebuild when the form fields change.
class GoalPage extends StatefulWidget {
  //We are passing the Goal to be edited. If it is null, the business logic will know that we are adding a new
  //Goal instead.
  final Pace? pace;

  //GoalPage constructor

  GoalPage({Key? key, this.pace}) : super(key: key);

  static const route = '/goal';
  static const routeDisplayName = 'Steps';

  @override
  State<GoalPage> createState() => _GoalPageState();
} //GoalPage

//Class that manages the state of GoalPage
class _GoalPageState extends State<GoalPage> {
  //Form globalkey: this is required to validate the form fields.
  final formKey = GlobalKey<FormState>();

  //Variables that maintain the current form fields values in memory.
  TextEditingController _choController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  DateTime _selectedDate2 = DateTime.now();

  //Here, we are using initState() to initialize the form fields values.
  //Rationale: Goal content and dates are not known since the goal is new (goal == null).
  // In this case, initilize them to empty and now(), respectively, otherwise set them to the respective values.
  @override
  void initState() {
    _choController.text =
        widget.pace == null ? '' : widget.pace!.steptodo.toString();
    _selectedDate =
        widget.pace == null ? DateTime.now() : widget.pace!.dateTime;
    _selectedDate2 =
        widget.pace == null ? DateTime.now() : widget.pace!.dateTime;
    super.initState();
  } // initState for paces

  //Remember that form controllers need to be manually disposed. So, here we need also to override the dispose() method.
  @override
  void dispose() {
    _choController.dispose();
    super.dispose();
  } // dispose for paces

  @override
  Widget build(BuildContext context) {
    //Print the route display name for debugging
    print('${GoalPage.routeDisplayName} built');

    //The page is composed of a form. An action in the AppBar is used to validate and save the information provided by the user.
    //A FloatingActionButton is showed to provide the "delete" functionality. It is showed only if the goal already exists.
    return Scaffold(
      appBar: AppBar(
        title: Text(GoalPage.routeDisplayName),
         backgroundColor: Colors.purple,
        actions: [
          IconButton(
            onPressed: () => _validateAndSave(context),
            icon: Icon(Icons.done)
          )
        ],
      ),
      body: Center(
        child: _buildForm(context),
      ),
    );
  } //build

  //Utility method used to build the form.
  Widget _buildForm(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 8, left: 20, right: 20),
        child: ListView(
          children: <Widget>[
            FormSeparator(label: 'Goal content'),
            FormNumberTile(
              labelText: 'Steps',
              controller: _choController,
              icon:  MdiIcons.hiking,
            ),
            FormSeparator(label: 'Goal week'),
            FormDateTile(
              labelText: 'From',
              date: _selectedDate,
              icon: MdiIcons.clockTimeFourOutline,
              onPressed: () {
                _selectDate(context);
              },
              dateFormat: Formats.onlyDayDateFormat,
            ),
            FormDateTile(
              labelText: 'To',
              date: _selectedDate2,
              icon: MdiIcons.clockTimeFourOutline,
              onPressed: () {
                _selectDate2(context);
              },
              dateFormat: Formats.onlyDayDateFormat,
            ),
          ],
        ),
      ),
    );
  } // _buildForm

  //Utility method that implements a Date picker.
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2010),
        lastDate: DateTime(2101));
    if (picked != null && picked != _selectedDate)
      //Here, I'm using setState to update the _selectedDate field and rebuild the UI.
      setState(() {
        _selectedDate = picked;
      });
  } //_selectDate From

  //Utility method that implements a Date picker.
  Future<void> _selectDate2(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate2,
        firstDate: DateTime(2010),
        lastDate: DateTime(2101));
    if (picked != null && picked != _selectedDate2)
      //Here, I'm using setState to update the _selectedDate field and rebuild the UI.
      setState(() {
        _selectedDate2 = picked;
      });
  } //_selectDate To

  //Utility method that validate the form and, if it is valid, save the new goal information.
  void _validateAndSave(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      //If the original Goal passed to the GoalPage was null, then add a new Goal...
      if (widget.pace == null) {
        Pace newPace =
            Pace(null, double.parse(_choController.text), _selectedDate);
        await Provider.of<DatabaseRepository>(context, listen: false)
            .insertPace(newPace);
      } //if
    } else {
      Pace updatedPace = Pace(
          widget.pace!.id, double.parse(_choController.text), _selectedDate);
      await Provider.of<DatabaseRepository>(context, listen: false)
          .updatePace(updatedPace);
    } //else
    Navigator.pop(context);
  } //if
  // _validateAndSave
  } 