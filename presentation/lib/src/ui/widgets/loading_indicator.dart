import 'package:flutter/material.dart';
import 'package:presentation/presentation.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    Key? key,
    this.message,
  }) : super(key: key);

  final String? message;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: Spacing.xlarge),
          Text(
            message ??
                appLocalizations!.translate(
                  TranslationEntries.loading_indicator_message,
                ),
          ),
        ],
      ),
    );
  }
}
