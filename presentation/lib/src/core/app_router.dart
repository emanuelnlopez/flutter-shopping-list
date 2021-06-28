import 'package:flutter/material.dart';
import 'package:presentation/presentation.dart';

class AppRouter {
  static final Map<String, WidgetBuilder> all = {
    NamedRoute.home: (_) => HomePage(),
    NamedRoute.shoppingList: (_) => ShoppingListPage(),
  };
}
