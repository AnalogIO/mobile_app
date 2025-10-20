import 'package:cafe_analog_app/core/widgets/analog_app_bar.dart';
import 'package:cafe_analog_app/core/widgets/components/section_title.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AnalogAppBar(title: 'Settings'),
      body: ListView(
        children: const <Widget>[
          SectionTitle('Account'),
          ListTile(
            leading: Icon(Icons.email_outlined),
            title: Text('Email'),
            subtitle: Text('omma@itu.dk'),
          ),
          ListTile(
            leading: Icon(Icons.password),
            title: Text('Passcode'),
            subtitle: Text('Tap to change'),
          ),
          ListTile(
            leading: Icon(Icons.person),
            iconColor: Colors.grey,
            title: Text('User ID'),
            textColor: Colors.grey,
            subtitle: Text('1234'),
          ),
          ListTile(
            leading: Icon(Icons.card_giftcard),
            title: Text('Redeem voucher'),
          ),
          ListTile(
            leading: Icon(Icons.logout_outlined),
            title: Text('Log out'),
          ),
          SectionTitle('About'),
          ListTile(
            leading: Icon(Icons.storefront_outlined),
            title: Text('Opening hours'),
            subtitle: Text('Mondays: 08:00-16:00'),
          ),
          ListTile(
            leading: Icon(Icons.question_mark_outlined),
            title: Text('Frequently Asked Questions'),
          ),
          ListTile(
            leading: Icon(Icons.chat_outlined),
            title: Text('Contact us'),
            subtitle: Text('Report a bug or give us feedback'),
          ),
          SectionTitle('Legal'),
          ListTile(
            leading: Icon(Icons.privacy_tip_outlined),
            title: Text('Privacy policy'),
          ),
          ListTile(
            leading: Icon(Icons.code),
            title: Text('Credits and licenses'),
          ),
          SectionTitle('Danger zone'),
          ListTile(
            leading: Icon(Icons.delete_outline),
            iconColor: Colors.red,
            title: Text('Delete my account'),
            textColor: Colors.red,
          ),
        ],
      ),
    );
  }
}
