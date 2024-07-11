import 'package:citizen_femme/view/profile/contact.dart';
import 'package:citizen_femme/view/travel.dart';
import 'package:flutter/material.dart';

class DrawerProvider extends ChangeNotifier {
  List drawerMenuList = [
    {
      "name": "Travel",
      "class": TravelScreen(
        categoryId: 0,
        categoryName: '',
      ),
    },
    {"name": "Style", "class": null},
    {
      "name": "Beauty",
      "class": null,
    },
    {"name": "Culture", "class": null},
    {"name": "Citizen Enfants", "class": null},
    {"name": "Watch", "class": null},
    {"name": "Listen", "class": null},
    {"name": "Support", "class": SupportScreen()},
  ];
}
