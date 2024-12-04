import 'package:flutter/material.dart';

class ProfileActions extends StatelessWidget
{
  final VoidCallback onPickImage;
  final VoidCallback onNotes;

  const ProfileActions({
    Key? key,
    required this.onPickImage,
    required this.onNotes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Edit Profile Picture Button
        Expanded(
          child: ElevatedButton(
            onPressed: onPickImage,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Edit Profile Picture',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ),
        const SizedBox(width: 16),
        // Notes Button
        Expanded(
          child: ElevatedButton(
            onPressed: onNotes,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Notes',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ),
      ],
    );
  }
}
