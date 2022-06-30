import 'package:flutter/material.dart';

class Cart extends ChangeNotifier {
  List<double?> stepsvalue2 = [null,null,null,null,null,null,null]; //All'inizio il nostro carrello è vuoto (è lo state dell'app)
  List<DateTime?> datevalue2 = [null, null, null, null, null, null, null];
  void addProduct(List<double?> steps, List<DateTime?> date) {
    for (var i = 0; i < 7; i++) {
      stepsvalue2[i] = steps[i];
      datevalue2[i] = date[i];
    }
    notifyListeners();
  } //
}
