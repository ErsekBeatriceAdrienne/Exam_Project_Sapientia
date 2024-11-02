import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'customClasses/custom_scaffold.dart';

class HomePage extends StatelessWidget
{
  final VoidCallback toggleTheme;
  final String? userId;

  const HomePage({Key? key, required this.toggleTheme, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return CustomScaffold (
      toggleTheme: toggleTheme,
      userId: userId,
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance.collection('users').doc(userId).get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return const Text('Error fetching user data.');
            }
            if (!snapshot.hasData || !snapshot.data!.exists) {
              return const Text('User does not exist.');
            }

            // Get user data
            var userData = snapshot.data!.data() as Map<String, dynamic>;
            String firstName = userData['firstName'] ?? 'FirstName';
            String lastName = userData['lastName'] ?? 'LastName';

            String fullName = '$firstName $lastName'; // Concatenate first and last name

            return Text('Welcome, $fullName!', style: const TextStyle(fontSize: 24));
          },
        ),
      ),
    );
  }
}
