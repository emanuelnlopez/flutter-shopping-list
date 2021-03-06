import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:presentation/presentation.dart';

class ShoppingListCard extends StatelessWidget {
  const ShoppingListCard({Key? key, required this.shoppingList})
      : super(key: key);

  final ShoppingList shoppingList;

  @override
  Widget build(BuildContext context) => ListTile(
        onTap: () => Navigator.pushNamed(
          context,
          NamedRoute.shoppingList,
          arguments: shoppingList,
        ),
        subtitle: Text(shoppingList.creationDate.toString()),
        title: Text(shoppingList.name),
      );
}
