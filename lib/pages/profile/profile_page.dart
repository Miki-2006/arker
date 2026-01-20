import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:kancha/models/user_model.dart';
import 'package:kancha/pages/profile/components/profile_top.dart';
import 'package:kancha/pages/profile/components/profile_row.dart';
import 'package:kancha/pages/profile/workers_list.dart';
import 'package:kancha/providers/user_provider.dart';
import 'package:kancha/styles/text/styled_text.dart';
import 'package:kancha/widgets/loader_widget.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static const _userId = '0906e2b5-4f7c-49c9-93c4-b83626af023f';

  @override
  void initState() {
    super.initState();
    // Загружать данные после первого кадра, чтобы контекст был готов
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserProvider>().fetchUser(_userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    // return AuthPage();
    return Scaffold(
      body: Consumer<UserProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return LoaderWidget();
          }
          if (provider.error != null) {
            return Center(child: Text('Ошибка: ${provider.error}'));
          }
          final user = provider.user;
          if (user == null) {
            return const Center(
              child: StyledText(
                content: 'Нет данных о пользователе',
                color: 0xFF5F33E1,
                size: 20,
              ),
            );
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 60),
                _buildCurrentUserCard(user),
                const SizedBox(height: 24),
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      StyledText(
                        content: 'Сотрудники компании:',
                        color: 0xFF000000,
                        family: 'Ysabeau Office',
                        size: 20,
                        weight: 800,
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height:
                            400, // или MediaQuery.of(context).size.height * 0.5
                        child: WorkersList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCurrentUserCard(UserModel user) {
    return Column(
      children: [
        ProfileTop(userFirstName: user.firstName, userLastName: user.lastName),
        const SizedBox(height: 24),
        Card(
          elevation: 4,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 36, vertical: 8),
            child: Column(
              children: [
                ProfileRow(
                  icon: HugeIcons.strokeRoundedCall,
                  label: 'Телефон',
                  value: user.phone,
                ),
                ProfileRow(
                  icon: HugeIcons.strokeRoundedMail01,
                  label: 'Email',
                  value: user.email,
                ),
                ProfileRow(
                  icon: HugeIcons.strokeRoundedWork,
                  label: 'Роль',
                  value: user.workerRole,
                ),
                ProfileRow(
                  icon: HugeIcons.strokeRoundedCorporate,
                  label: 'Компания',
                  value: user.company?.name ?? '',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
