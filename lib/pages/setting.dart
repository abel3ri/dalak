import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  var value, value2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SettingsList(
              sections: [
                SettingsSection(
                  title: Text(
                    'General Setting',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  tiles: [
                    SettingsTile.switchTile(
                      title: Text('Get Notification'),
                      leading: Icon(Icons.fingerprint),
                      initialValue: value2,
                      onToggle: (bool v) {
                        setState(() {
                          value2 = v;
                          print(value2);
                        });
                      },
                    ),
                    SettingsTile.switchTile(
                      title: Text('Dark Mode'),
                      leading: Icon(Icons.fingerprint),
                      initialValue: value,
                      onToggle: (bool v) {
                        setState(() {
                          value = v;
                          print(value);
                        });
                      },
                    ),
                  ],
                ),
                SettingsSection(
                  title: Text(
                    'About App',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  tiles: [
                    SettingsTile(
                      title: Text('Privacy Policy'),
                      leading: Icon(Icons.fingerprint),
                      trailing: Icon(Icons.keyboard_arrow_right_outlined),
                    ),
                    SettingsTile(
                      title: Text('Rate this app'),
                      leading: Icon(Icons.fingerprint),
                      trailing: Icon(Icons.keyboard_arrow_right_outlined),
                    ),
                  ],
                ),
                SettingsSection(
                  title: Text(
                    'Social Settings',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  tiles: [
                    SettingsTile(
                      title: Text('Contact Us'),
                      leading: Icon(Icons.fingerprint),
                      trailing: Icon(Icons.keyboard_arrow_right_outlined),
                    ),
                    SettingsTile(
                      title: Text('Our Website'),
                      leading: Icon(Icons.fingerprint),
                      trailing: Icon(Icons.keyboard_arrow_right_outlined),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
