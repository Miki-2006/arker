import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:kancha/pages/home/balanc/balanc_widget.dart';
import 'package:kancha/pages/home/balanc/components/history_card.dart';
import 'package:kancha/providers/balanc_provider.dart';
import 'package:kancha/styles/text/styled_text.dart';
import 'package:kancha/widgets/loader_widget.dart';
import 'package:provider/provider.dart';

class BalancHistoryScreen extends StatefulWidget {
  const BalancHistoryScreen({super.key});

  @override
  State<BalancHistoryScreen> createState() => _BalancHistoryScreenState();
}

class _BalancHistoryScreenState extends State<BalancHistoryScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      // ignore: use_build_context_synchronously
      context.read<BalancProvider>().fetchBalanc(
        '0906e2b5-4f7c-49c9-93c4-b83626af023f',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final balancProvider = context.watch<BalancProvider>();

    return Scaffold(
      appBar: AppBar(
        title: StyledText(content: 'История', color: 0xFF000000, size: 24),
        centerTitle: true,
        automaticallyImplyLeading: false,
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
        child:
            balancProvider.error != null
                ? Center(child: Text('Ошибка: ${balancProvider.error}'))
                : !balancProvider.isLoaded
                ? LoaderWidget()
                : Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF1372F0), Color(0xFF6FADFF)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 148, 194, 253),
                            spreadRadius: 20,
                            blurRadius: 20,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: BalancWidget(balanc: balancProvider.balancOfUser),
                    ),
                    _buildHistoryCards(),
                  ],
                ),
      ),
    );
  }

  Widget _buildHistoryCards() {
    return Expanded(child: 
    ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (_, i) => HistoryCard(),
      itemCount: 3,
      padding: EdgeInsets.only(top: 10),
    ));
  }
}
