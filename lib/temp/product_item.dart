import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/temp/provider_countbloc.dart';
import 'package:provider/provider.dart';

typedef void CartChangedCallback(String product, bool inCart);

class ShoppingListItem extends StatelessWidget {
  ShoppingListItem({String product, this.inCart, this.onCartChanged})
      : product = product,
        super(key: new ObjectKey(product));

  final String product;
  final bool inCart;
  final CartChangedCallback onCartChanged;

  Color _getColor(BuildContext context) {
    // The theme depends on the BuildContext because different parts of the tree
    // can have different themes.  The BuildContext indicates where the build is
    // taking place and therefore which theme to use.

    return inCart ? Colors.black54 : Theme.of(context).primaryColor;
  }

  TextStyle _getTextStyle(BuildContext context) {
    if (!inCart) return null;

    return new TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Provider<CountBloc>(
      dispose: (context, value) => value.dispose(),
      child: new ListTile(
      onTap: () {
        onCartChanged(product, !inCart);
      },
      leading: new CircleAvatar(
        backgroundColor: _getColor(context),
        child: new Text(product),
      ),
      title: new Text(product, style: _getTextStyle(context)),
    )
    );
  }
}
