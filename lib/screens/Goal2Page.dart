import 'package:flutter/material.dart';
import 'package:group28/database/entities/sedentary.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:group28/repositories/databaseRepository.dart';
import 'package:group28/widgets/formTiles.dart';
import 'package:group28/widgets/formSeparator.dart';
import 'package:group28/utils/formats.dart';
import 'package:provider/provider.dart';

//This is the class that implement the page to be used to add new goals.
//This is a StatefulWidget since it needs to rebuild when the form fields change.
class Goal2Page extends StatefulWidget {
  //We are passing the Goal to be edited. If it is null, the business logic will know that we are adding a new
  //Goal instead.
  final Sed? sed;

  //MealPage constructor
  Goal2Page({Key? key, this.sed}) : super(key: key);

  static const route = '/goal2';
  static const routeDisplayName = 'Minutes';

  @override
  State<Goal2Page> createState() => _Goal2PageState();
} //GoalPage

//Class that manages the state of GoalPage
class _Goal2PageState extends State<Goal2Page> {
  //Form globalkey: this is required to validate the form fields.
  final formKey = GlobalKey<FormState>();

  //Variables that maintain the current form fields values in memory.
  TextEditingController _choController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  DateTime _selectedDate2 = DateTime.now();

  //Here, we are using initState() to initialize the form fields values.
  //Rationale: Goal content and time are not known is the goal is new (sed == null).
  // In this case, initilize them to empty and now(), respectively, otherwise set them to the respective values.
  @override
  void initState() {
    _choController.text =
        widget.sed == null ? '' : widget.sed!.minsed.toString();
    _selectedDate = widget.sed == null ? DateTime.now() : widget.sed!.dateTime;
    _selectedDate2 = widget.sed == null ? DateTime.now() : widget.sed!.dateTime;
    super.initState();
  } // initState

  //Remember that form controllers need to be manually disposed. So, here we need also to override the dispose() method.
  @override
  void dispose() {
    _choController.dispose();
    super.dispose();
  } // dispose

  @override
  Widget build(BuildContext context) {
    //Print the route display name for debugging
    print('${Goal2Page.routeDisplayName} built');

    //The page is composed of a form. An action in the AppBar is used to validate and save the information provided by the user.
    //A FAB is showed to provide the "delete" functinality. 
    return Scaffold(
      appBar: AppBar(
        title: Text(Goal2Page.routeDisplayName),
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            onPressed: () => _validateAndSave(context),
            icon: Icon(Icons.done),
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
              labelText: 'Minutes',
              controller: _choController,
              icon: MdiIcons.seatPassenger,
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

  //Utility method that validate the form and, if it is valid, save the new meal information.
  void _validateAndSave(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      //If the original Meal passed to the GoalPage was null, then add a new Goal...
      if (widget.sed == null) {
        Sed newSed =
            Sed(null, double.parse(_choController.text), _selectedDate);
        await Provider.of<DatabaseRepository>(context, listen: false)
            .insertSed(newSed);
      } //if
      //...otherwise, edit it.
      else {
        Sed updatedSed = Sed(
            widget.sed!.id, double.parse(_choController.text), _selectedDate);
        await Provider.of<DatabaseRepository>(context, listen: false)
            .updateSed(updatedSed);
      } //else
      Navigator.pop(context);
    } //if
  } // _validateAndSave
} 