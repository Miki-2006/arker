import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:kancha/styles/text/styled_text.dart';
import 'package:kancha/widgets/loader_widget.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StyledText(content: 'История', color: 0xFF000000, size: 24),
        centerTitle: true,
        leading: SizedBox(),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedSquareArrowRight01,
              color: Colors.black,
              size: 34,
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.grey[200]),
        child: LoaderWidget(),
      ),
    );
  }
}
