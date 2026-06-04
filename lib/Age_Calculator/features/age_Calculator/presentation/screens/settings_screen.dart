import 'package:flutter/material.dart';
import 'package:flutter_w/Age_Calculator/core/theme/theme_provider.dart';
import 'package:provider/provider.dart';



class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final themeProvider =
        Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),

      body: Column(
        children: [

          SwitchListTile(
            title: const Text("Dark Mode"),

            value: themeProvider.isDark,

            onChanged: (value) {
              themeProvider.toggleTheme();
            },
          ),

          const ListTile(
            leading: Icon(Icons.info),
            title: Text("App Version"),
            subtitle: Text("1.0.0"),
          ),

          const ListTile(
            leading: Icon(Icons.star),
            title: Text("Rate App"),
          ),

          const ListTile(
            leading: Icon(Icons.share),
            title: Text("Share App"),
          ),
        ],
      ),
    );
  }
}