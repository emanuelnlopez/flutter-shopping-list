import 'dart:io';

import 'package:dart_utils/dart_utils.dart';
import 'package:domain/domain.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'package:logging/logging.dart';

class ItemNameGoogleRepository implements ItemNameRepository {
  static final Logger _logger = Logger('ItemNameGoogleRepository');
  final googleSearchUrl = 'https://www.google.com/search?q=';

  @override
  Future<List<String>> search(String query) async {
    var results = <String>[];
    final uri = Uri.parse('$googleSearchUrl$query');
    final response = await Client().get(uri);

    if (response.statusCode == HttpStatus.ok) {
      final document = parse(response.body);
      document.getElementsByClassName('g').forEach(
            (value) => _logger.finest(value.innerHtml),
          );
      final elements = document.getElementsByTagName('h3');
      elements.forEach(
        (element) => results.add(
          StringUtils.capitalize(
            element.text,
            allWords: true,
          ),
        ),
      );
    }

    return results;
  }
}
