import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:kancha/styles/text/styled_text.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IntlPhoneField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'номер',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none, // Убираем линию границы
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 16,
                ),
                // Стиль текста метки, когда поле в фокусе
                floatingLabelStyle: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                // Стиль текста метки (label), когда поле не в фокусе
                labelStyle: TextStyle(color: Colors.blueGrey, fontSize: 20),
              ),
              initialCountryCode: 'KG',
              onChanged: (value) {
                // hjkj
              },
              disableLengthCheck: true,
              dropdownIcon: Icon(Icons.arrow_drop_down),
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'пароль',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none, // Убираем линию границы
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 16,
                ),
                // Стиль текста метки, когда поле в фокусе
                floatingLabelStyle: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                // Стиль текста метки (label), когда поле не в фокусе
                labelStyle: TextStyle(color: Colors.blueGrey, fontSize: 20),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle signup logic here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF5F33E1),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(14),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ), // Отступы
                elevation: 5, // Тень
              ),
              child: StyledText(content: 'Войти')
            ),
          ],
        ),
      ),
    );
  }
}
