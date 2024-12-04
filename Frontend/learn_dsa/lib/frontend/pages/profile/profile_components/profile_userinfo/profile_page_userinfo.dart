import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget
{
  final String? profileImageUrl;
  final String firstName;
  final String lastName;
  final String email;

  const ProfileHeader({
    Key? key,
    required this.profileImageUrl,
    required this.firstName,
    required this.lastName,
    required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 60,
          backgroundImage: profileImageUrl != null && profileImageUrl!.isNotEmpty
              ? NetworkImage(profileImageUrl!)
              : const AssetImage('assets/default_profile_picture.png') as ImageProvider,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$firstName $lastName',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '$email',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
