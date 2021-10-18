import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:presentation/presentation.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AppLocalizations? _appLocalizations;
  late HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  void _initialize() async {
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) => _homeBloc.loadShoppingLists(),
    );
  }

  void _showNewShoppingListDialog(BuildContext context) async {
    final name = await DefaultDialog.prompt<String>(
      context,
      autoFocus: true,
      cancelLabel: _appLocalizations!.translate(
        TranslationEntries.general_cancel,
      ),
      hintText: _appLocalizations!.translate(
        TranslationEntries.new_shopping_list_dialog_hint,
      ),
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      message: _appLocalizations!.translate(
        TranslationEntries.new_shopping_list_dialog_message,
      ),
      okLabel: _appLocalizations!.translate(
        TranslationEntries.general_accept,
      ),
      titleLabel: _appLocalizations!.translate(
        TranslationEntries.new_shopping_list_dialog_title,
      ),
    );
    if (name?.isNotEmpty == true) {
      _homeBloc.saveShoppingList(
        ShoppingList(name: name!),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _appLocalizations = AppLocalizations.of(context);
    _homeBloc = DependencyInjector().injector.get<HomeBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _appLocalizations!.translate(TranslationEntries.home_page_title),
        ),
      ),
      body: StreamBuilder<List<ShoppingList>>(
        stream: _homeBloc.shoppingListStream,
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
        onPressed: () => _showNewShoppingListDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
