import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:kancha/models/balanc_model.dart';
import 'package:kancha/pages/history/history_page.dart';
import 'package:kancha/styles/text/styled_text.dart';
import 'package:page_transition/page_transition.dart';

class BalancWidget extends StatefulWidget {
  final BalancModel? balanc;
  const BalancWidget({super.key, this.balanc});

  @override
  State<BalancWidget> createState() => _BalancWidgetState();
}

class _BalancWidgetState extends State<BalancWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(vertical: 18, horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StyledText(
                content: 'Баланс',
                family: 'Anonymous Pro',
                color: 0xB3FFFFFF,
                style: 'italic',
              ),
              StyledText(
                content: widget.balanc?.amount.toString() ?? 'загрузка...',
                family: 'Noto Sans Math',
                size: 22,
                weight: 900,
              ),
              SizedBox(height: 5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Material(
                    color: Colors.red, // фон контейнера
                    borderRadius: BorderRadius.circular(8),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {
                        Navigator.of(context).push(
                          PageTransition(
                            type: PageTransitionType.leftToRight,
                            child: HistoryPage(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 2,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            HugeIcon(
                              icon: HugeIcons.strokeRoundedTradeDown,
                              color: Colors.white, // иконка на красном фоне
                              size: 24,
                            ),
                            SizedBox(width: 6),
                            Text(
                              '2%',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  StyledText(
                    content: ' этот месяц',
                    color: 0xB3FFFFFF,
                    style: 'italic',
                    family: 'Anonymous Pro',
                    size: 18,
                  ),
                ],
              ),
            ],
          ),
          HugeIcon(
            icon: HugeIcons.strokeRoundedMoneyBag02,
            color: Colors.white,
            size: 60,
          ),
        ],
      ),
    );
  }
}
