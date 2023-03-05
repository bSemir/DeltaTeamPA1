// class Role {
//   final String id;
//   final String image;
//   Role(this.id, this.image);
// }

// List<Role> listaRola = [
//   Role('qa', 'assets/images/qa_icon.svg'),
//   Role('productManager', 'assets/images/manager_icon.svg'),
//   Role('backend', 'assets/images/backend_icon.svg'),
//   Role('uiux', 'assets/images/designer_icon.svg'),
//   Role('fullstack', 'assets/images/fullstack_developer.svg'),
// ];

import 'package:flutter/material.dart';

//KLASA ZA ROLE MODEL
class Role {
  final String id;
  final String image;

  Role(this.id, this.image);
}

List<Role> listaRola = [
  Role('qa', 'assets/images/qa_icon.svg'),
  Role('productManager', 'assets/images/manager_icon.svg'),
  Role('backend', 'assets/images/backend_icon.svg'),
  Role('uiux', 'assets/images/designer_icon.svg'),
  Role('fullstack', 'assets/images/fullstack_developer.svg'),
];
