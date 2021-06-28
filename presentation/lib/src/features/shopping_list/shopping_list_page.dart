import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:presentation/presentation.dart';

class ShoppingListPage extends StatelessWidget {
  const ShoppingListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final shoppingListBloc =
        DependencyInjector().injector.get<ShoppingListBloc>();
    final shoppingList =
        ModalRoute.of(context)!.settings.arguments as ShoppingList;

    WidgetsBinding.instance!.addPostFrameCallback(
      (_) => shoppingListBloc.loadItems(shoppingListId: shoppingList.id),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(shoppingList.name),
      ),
      body: StreamBuilder<List<Item>>(
        stream: shoppingListBloc.itemsStream,
        builder: (context, snapshot) {
          if (snapshot.hasData == true) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (_, index) => ItemCard(
                item: snapshot.data![index],
              ),
            );
          } else {
            return LoadingIndicator();
          }
        },
      ),
    );
  }
}
