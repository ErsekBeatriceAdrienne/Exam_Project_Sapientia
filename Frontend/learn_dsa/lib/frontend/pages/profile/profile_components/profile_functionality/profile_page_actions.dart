import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileActions extends StatelessWidget
{
  final VoidCallback onEditProfile;
  final VoidCallback onLogout;
  final VoidCallback toggleTheme;
  final String? userId;

  const ProfileActions({
    super.key,
    required this.onEditProfile,
    required this.onLogout,
    required this.toggleTheme, this.userId,
  });

  @override
  Widget build(BuildContext context)
  {
    final gradient = const LinearGradient(
      colors: [Color(0xFF255f38), Color(0xFF27391c)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Edit Profile Button
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: onEditProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                AppLocalizations.of(context)!.edit_profile_text,
                style: const TextStyle(fontSize: 13, color: Colors.white),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: onLogout,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                AppLocalizations.of(context)!.sign_out_text,
                style: const TextStyle(fontSize: 13, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
