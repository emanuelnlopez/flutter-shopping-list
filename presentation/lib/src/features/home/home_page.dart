import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:presentation/presentation.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    final homeBloc = DependencyInjector().injector.get<HomeBloc>();

    WidgetsBinding.instance!.addPostFrameCallback(
      (_) => homeBloc.loadShoppingLists(),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          appLocalizations!.translate(TranslationEntries.home_page_title),
        ),
      ),
      body: StreamBuilder<List<ShoppingList>>(
        stream: homeBloc.shoppingListStream,
        builder: (context, snapshot) {
          if (snapshot.hasData == true) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (_, index) => ShoppingListCard(
                shoppingList: snapshot.data![index],
              ),
            );
          } else {
            return LoadingIndicator();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => debugPrint('Hello World!'),
        child: Icon(Icons.add),
      ),
    );
  }
}
