import "package:flutter/material.dart";

import "../role.dart";

//PROVIDER
class MyItem with ChangeNotifier {
  List<String> myItems = [];
  // var imeRole = [];
  int get length => myItems.length;
  List<String> get selectedList => myItems;
//dodaj u niz rolu
  void add(Role role) {
    myItems.add(role.id);
    notifyListeners();
  }

//izbrisi iz niza rolu
  void remove(Role role) {
    myItems.remove(role.id);
    notifyListeners();
  }

  bool hasRole(Role role) {
    return myItems.where((element) => element == role.id).isNotEmpty;
  }
}
