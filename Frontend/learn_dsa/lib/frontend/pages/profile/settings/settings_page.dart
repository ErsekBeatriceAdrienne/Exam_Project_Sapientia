import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:learn_dsa/backend/database/firestore_service.dart';
import 'package:learn_dsa/frontend/pages/profile/profile_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../helpers/essentials.dart';
import '../../../language_supports/language_picker.dart';

class SettingsPage extends StatefulWidget {
  final VoidCallback toggleTheme;
  final String? userId;

  const SettingsPage({super.key, required this.toggleTheme, required this.userId});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> with SingleTickerProviderStateMixin {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    FirestoreService().fetchUserData(widget.userId!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            pinned: true,
            floating: false,
            expandedHeight: 70,
            leadingWidth: 90,
            automaticallyImplyLeading: false,
            leading: TextButton.icon(
              style: TextButton.styleFrom(
                foregroundColor: Colors.green,
                padding: const EdgeInsets.only(left: 8.0),
              ),
              onPressed: () {
                Navigator.pop(
                  context,
                  Essentials().createSlideRoute(ProfilePage(
                      toggleTheme: widget.toggleTheme, userId: widget.userId),
                  ),
                );
              },

              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 20,
              ),
              label: Text(
                AppLocalizations.of(context)!.back_button_text,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 17,
                ),
              ),
            ),
            centerTitle: true,
            title: Text(
              AppLocalizations.of(context)!.settings_text,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xFF255f38),
              ),
            ),
            flexibleSpace: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  color: Theme
                      .of(context)
                      .scaffoldBackgroundColor
                      .withOpacity(0.2),
                ),
              ),
            ),
          ),


          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}