import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../strings/firestore/firestore_docs.dart';
import '../profile/login/login_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget
{
  final VoidCallback toggleTheme;
  final String? userId;

  const HomePage({Key? key, required this.toggleTheme, required this.userId}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
{
  late String userId;

  @override
  void initState()
  {
    super.initState();
    userId = widget.userId ?? '';
    if (userId.isEmpty) _navigateToLogin();
  }

  void _navigateToLogin()
  {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(toggleTheme: widget.toggleTheme),
      ),
    );
  }

  @override
  Widget build(BuildContext context)
  {
    if (userId.isEmpty)
    {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        //title: Text(AppLocalizations.of(context)!.app_title),
      ),

      body: Center(
        child: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance.collection(FirestoreDocs.user_doc).doc(userId).get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Text(AppLocalizations.of(context)!.error_fetching_data);
            }
            if (!snapshot.hasData || !snapshot.data!.exists) {
              return Text(AppLocalizations.of(context)!.user_not_found);
            }

            var userData = snapshot.data!.data() as Map<String, dynamic>;
            String firstName = userData[FirestoreDocs.userFirstName];
            String lastName = userData[FirestoreDocs.userLastName];
            String fullName = '$firstName $lastName';

            return Text(
              '${AppLocalizations.of(context)!.welcome}, $fullName!',
              style: const TextStyle(fontSize: 24),
            );
          },
        ),
      ),
    );
  }
}
