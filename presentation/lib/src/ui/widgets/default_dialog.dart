import 'package:flutter/material.dart';

class DefaultDialog {
  static Future<T?> prompt<T>(
    BuildContext context, {
    bool autoFocus = true,
    String? cancelLabel,
    String? hintText,
    String? initialValue,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    required String message,
    required String okLabel,
    required String titleLabel,
  }) {
    assert(okLabel.isNotEmpty == true);
    assert(titleLabel.isNotEmpty == true);

    final controller = TextEditingController(text: initialValue);
    var input = initialValue;
    var keyCtr = 0;

    return showDialog<T>(
      context: context,
      useRootNavigator: false,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          actions: [
            if (cancelLabel?.isNotEmpty == true)
              ElevatedButton(
                onPressed: () => Navigator.pop(context, null),
                child: Text(cancelLabel!),
              ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, input),
              child: Text(okLabel),
            ),
          ],
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(message),
              TextFormField(
                autofocus: autoFocus,
                controller: controller,
                decoration: InputDecoration(
                  hintText: hintText,
                ),
                key: Key('1_${keyCtr.toString()}'),
                keyboardType: keyboardType,
                onChanged: (value) => input = value,
                onEditingComplete: () => Navigator.pop(context, input),
                textInputAction: textInputAction,
              ),
            ],
          ),
          title: Text(titleLabel),
        ),
      ),
    );
  }

  static Future<T?> show<T>(
    BuildContext context, {
    VoidCallback? cancelCallback,
    String? cancelLabel,
    Widget? content,
    String? message,
    required VoidCallback okCallback,
    required String okLabel,
    required String titleLabel,
  }) {
    assert(content != null || message?.isNotEmpty == true);
    assert(content == null || message?.isNotEmpty != true);
    assert(okLabel.isNotEmpty == true);
    assert(titleLabel.isNotEmpty == true);

    if (content == null && message?.isNotEmpty == true) {
      content = Text(message!);
    }

    return showDialog<T>(
      context: context,
      useRootNavigator: false,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          actions: [
            if (cancelLabel?.isNotEmpty == true)
              ElevatedButton(
                onPressed: cancelCallback,
                child: Text(cancelLabel!),
              ),
            ElevatedButton(
              onPressed: okCallback,
              child: Text(okLabel),
            ),
          ],
          content: content,
          title: Text(titleLabel),
        ),
      ),
    );
  }
}
