import 'package:flutter/material.dart';
import 'package:kancha/models/quote_model.dart';
import 'package:kancha/services/fetch_quote_service.dart';
import 'package:kancha/styles/text/styled_text.dart';
import 'package:kancha/widgets/loader_widget.dart';

class QuoteWidget extends StatefulWidget {
  const QuoteWidget({super.key});

  @override
  State<QuoteWidget> createState() => _QuoteWidgetState();
}

class _QuoteWidgetState extends State<QuoteWidget> {
  QuoteModel? _quote;
  bool _loading = false;

  void _loadQuote() async {
    setState(() => _loading = true);
    try {
      final quote = await fetchQuote();
      setState(() {
        _quote = quote;
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
      throw FormatException("Error fetching quote $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _loadQuote();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return LoaderWidget();
    }

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),

      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Жёлтая линия слева
            Container(
              width: 2,
              margin: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
              decoration: BoxDecoration(
                color: Colors.yellow[700],
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 10, top: 14, bottom: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    StyledText(content: '"${_quote!.text}"'),
                    const SizedBox(height: 12),
                    StyledText(content: '- ${_quote!.author}'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
