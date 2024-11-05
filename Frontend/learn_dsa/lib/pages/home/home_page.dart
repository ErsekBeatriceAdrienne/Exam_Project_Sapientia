import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learn_dsa/pages/profile/login/login_page.dart';

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
      body: Center(
        child: FutureBuilder <DocumentSnapshot> (
          future: FirebaseFirestore.instance.collection('users').doc(userId).get(),
          builder: (context, snapshot)
          {
            if (snapshot.connectionState == ConnectionState.waiting) return const CircularProgressIndicator();
            if (snapshot.hasError) return const Text('Error fetching user data.');
            if (!snapshot.hasData || !snapshot.data!.exists) return const Text('User does not exist.');

            var userData = snapshot.data!.data() as Map<String, dynamic>;
            String firstName = userData['firstName'] ?? 'FirstName';
            String lastName = userData['lastName'] ?? 'LastName';

            String fullName = '$firstName $lastName';

            return Text('Welcome, $fullName!', style: const TextStyle(fontSize: 24));
          },
        ),
      ),
    );
  }
}
