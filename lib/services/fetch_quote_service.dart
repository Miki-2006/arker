import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kancha/models/quote_model.dart';

Future<QuoteModel> fetchQuote() async {
  final response = await http.get(
    Uri.parse(
      'http://api.forismatic.com/api/1.0/?method=getQuote&format=json&lang=ru',
    ),
  );

  if (response.statusCode == 200) {
    final json = jsonDecode(response.body);
    return QuoteModel(text: json['quoteText'], author: json['quoteAuthor']);
  } else {
    throw Exception('Не удалось загрузить цитату');
  }
}
