import 'package:flutter/material.dart';
import 'package:kancha/providers/notification_provider.dart';
import 'package:kancha/styles/text/styled_text.dart';
import 'package:provider/provider.dart';

class NotificationDetail extends StatefulWidget {
  final String notificationId;
  final bool isRead;

  const NotificationDetail({
    super.key,
    required this.notificationId,
    required this.isRead,
  });

  @override
  State<NotificationDetail> createState() => _NotificationDetailState();
}

class _NotificationDetailState extends State<NotificationDetail> {
  bool _showDetails = false;

  void onShowDetails() {
    setState(() {
      _showDetails = !_showDetails;
    });
    if (!widget.isRead) {
      context.read<NotificationProvider>().changeReadStatus(
        widget.notificationId,
        '0906e2b5-4f7c-49c9-93c4-b83626af023f',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
          child: Text(
            'Кечке чейин 200 шт мальчиковый желетка ljhkdgspoirje rlehioruwe rlkeghoirewhurw оарвылофары лопаулнпунк оаыврпилныгвпгнкеу лоаврышдгргеиди бовраиорлы ловаршдгыргш влоарилвыавгш лорвашдгрышгдр лдворапшгдрыег лоавриплорывгрпге ',
            softWrap: true,
            overflow: _showDetails ? null : TextOverflow.ellipsis,
            maxLines: _showDetails ? null : 1,
            style: TextStyle(
              color: Colors.black
            ),
          ),
        ),

        TextButton(
          onPressed: onShowDetails,
          child: StyledText(
            content: _showDetails ? 'Скрыть' : 'Подробнее',
            color: 0x66000000,
          ),
        ),
      ],
    );
  }
}
