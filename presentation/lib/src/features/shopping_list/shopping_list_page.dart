import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:presentation/presentation.dart';

class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({Key? key}) : super(key: key);

  @override
  _ShoppingListPageState createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  static final Logger _logger = Logger('ShoppingListPage');

  late ShoppingList _shoppingList;
  late ShoppingListBloc _shoppingListBloc;

  @override
  void initState() {
    super.initState();
    _shoppingListBloc = DependencyInjector().injector.get<ShoppingListBloc>();

    WidgetsBinding.instance!.addPostFrameCallback(
      (_) => _shoppingListBloc.loadItems(shoppingListId: _shoppingList.id),
    );
  }

  void _scanBarCode(BuildContext context) async {
    final result =
        await Navigator.of(context).pushNamed(NamedRoute.barCode) as String;
    _shoppingListBloc.search(barCode: result);

    _shoppingListBloc.itemNameStream.listen((results) {
      results.forEach((result) => _logger.finest(result));
      _showSelectionDialog(results);
    });
  }

  @override
  Widget build(BuildContext context) {
    _shoppingList = ModalRoute.of(context)!.settings.arguments as ShoppingList;
    return Scaffold(
      appBar: AppBar(
        title: Text(_shoppingList.name),
      ),
      body: StreamBuilder<List<Item>>(
        stream: _shoppingListBloc.itemsStream,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => _scanBarCode(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _showSelectionDialog(List<String> results) async {
    await showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('choose'),
        children: results
            .map(
              (result) => SimpleDialogOption(
                onPressed: () => _logger.finest(result),
                child: Text(result),
              ),
            )
            .toList(),
      ),
    );
  }
}
