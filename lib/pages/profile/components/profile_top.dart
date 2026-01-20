import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:kancha/styles/text/styled_text.dart';

class ProfileTop extends StatefulWidget {
  final String userFirstName;
  final String userLastName;

  const ProfileTop({
    super.key,
    required this.userFirstName,
    required this.userLastName,
  });

  @override
  State<ProfileTop> createState() => _ProfileTopState();
}

class _ProfileTopState extends State<ProfileTop> {
  bool _showActions = false;

  void _toggleActions() {
    setState(() {
      _showActions = !_showActions;
    });
  }

  void _logOut() {}

  void _editProfile() {}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _toggleActions,
          child: Column(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.blue,
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/avatar4.png'),
                ),
              ),
              const SizedBox(height: 16),
              StyledText(
                content: '${widget.userFirstName} ${widget.userLastName}',
                color: 0xFF000000,
                size: 20,
                family: 'Martian Mono',
                weight: 600,
              ),
            ],
          ),
        ),

        if (_showActions) ...[
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                onPressed: _editProfile,
                backgroundColor: Colors.white,
                elevation: 5,
                shape: Border.all(color: Colors.black, width: 1),
                
                child: HugeIcon(
                  icon: HugeIcons.strokeRoundedUserEdit01,
                  color: Colors.black,
                  size: 28,
                ),
              ),
              SizedBox(width: 12),
              FloatingActionButton(
                onPressed: _logOut,
                backgroundColor: Colors.white,
                elevation: 5,
                shape: Border.all(color: Colors.black, width: 1),
                
                child: HugeIcon(
                  icon: HugeIcons.strokeRoundedLogout02,
                  color: Colors.black,
                  size: 28,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
