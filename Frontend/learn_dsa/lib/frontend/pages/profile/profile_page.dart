import 'dart:io';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learn_dsa/backend/database/firestore_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../backend/database/cloudinary_service.dart';
import '../../language_supports/language_picker.dart';
import '../../strings/cloudinary/cloudinary_apis.dart';
import '../../strings/firestore/firestore_docs.dart';
import '../customClasses/custom_ring_chart.dart';

class ProfilePage extends StatefulWidget
{
  final VoidCallback toggleTheme;
  final String? userId;

  const ProfilePage({super.key, required this.toggleTheme, required this.userId});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  DateTime? selectedDate;

  final gradient = const LinearGradient(
    colors: [Color(0xFF255f38), Color(0xFF27391c)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>?>(
        future: FirestoreService().fetchUserData2(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
                child: Text(AppLocalizations.of(context)!.user_not_found));
          }

          final userData = snapshot.data;
          if (userData == null) {
            return Center(
                child: Text(AppLocalizations.of(context)!.user_not_found));
          }

          final profileImageUrl = userData[FirestoreDocs.userProfilePic];
          final String firstName = userData[FirestoreDocs.userFirstName];
          final String lastName = userData[FirestoreDocs.userLastName];
          final String email = FirebaseAuth.instance.currentUser?.email ??
              AppLocalizations.of(context)!.error_email;

          return CustomScrollView(
            slivers: [
              // App bar
              SliverAppBar(
                backgroundColor: Colors.transparent,
                pinned: true,
                floating: false,
                expandedHeight: 70,
                flexibleSpace: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: Container(
                      color: Theme
                          .of(context)
                          .scaffoldBackgroundColor
                          .withOpacity(0.2),
                      child: FlexibleSpaceBar(
                        titlePadding: EdgeInsets.only(left: 16, bottom: 16),
                        title: Text(
                          userData[FirestoreDocs.userUsername],
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF255f38), //Color(0xFFDFAEE8),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                actions: [
                  // Pick a language
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: LanguagePicker(),
                  ),
                ],
              ),

              // Profile Content
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Theme
                              .of(context)
                              .scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 6,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
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

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          // Edit icon button
                                          IconButton(
                                            onPressed: () =>
                                                showEditProfileSheet(
                                                    context, widget.userId!,
                                                    profileImageUrl),
                                            icon: const Icon(
                                                Icons.edit, color: Color(0xFF255f38)),
                                            tooltip: AppLocalizations.of(context)!
                                                .edit_profile_text,
                                          ),
                                          // Sign out icon button
                                          IconButton(
                                            onPressed: () async {
                                              if (widget.userId != null) {
                                                await FirestoreService().signOut(
                                                    context, widget.toggleTheme,
                                                    widget.userId!);
                                              }
                                              toggleTheme:
                                              widget.toggleTheme;
                                            },
                                            icon: const Icon(
                                                Icons.logout, color: Color(0xFF255f38)),
                                            tooltip: AppLocalizations.of(context)!
                                                .sign_out_text,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppLocalizations.of(context)!
                              .answered_questions_text_title,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      // Tests
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme
                              .of(context)
                              .scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 6,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 15),

                            Center(
                              child: RingChartTestsWidget(userId: widget.userId),
                            ),

                            const SizedBox(height: 15),

                            Text(
                              AppLocalizations.of(context)!
                                  .answered_questions_description,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),


                      const SizedBox(height: 65),
                    ],
                  ),
                ),
              ),

            ],
          );
        },
      ),
    );
  }

  Widget _buildMemoryInputSheet(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) => SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.reminder_title,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: descriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.reminder_description,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ).copyWith(
                      backgroundColor: WidgetStateProperty.all(Colors.transparent),
                      elevation: WidgetStateProperty.all(0),
                    ),
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        final pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );

                        if (pickedTime != null) {
                          final combinedDateTime = DateTime(
                            picked.year,
                            picked.month,
                            picked.day,
                            pickedTime.hour,
                            pickedTime.minute,
                          );
                          setState(() => selectedDate = combinedDateTime);
                        }
                      }
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF255f38), Color(0xFF27391c)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        height: 48,
                        child: Text(
                          AppLocalizations.of(context)!.select_date,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }

  void showEditProfileSheet(BuildContext context, String userId, String? profileImageUrl) {
    final controller = ProfileEditController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        String? passwordErrorText;
        String? confirmPasswordErrorText;

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery
                  .of(context)
                  .viewInsets
                  .bottom,
              top: 16,
              left: 16,
              right: 16,
            ),
            child: StatefulBuilder(
              builder: (c, setState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(AppLocalizations.of(context)!.edit_profile_text,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),

                    GestureDetector(
                      onTap: () =>
                          controller.pickImage((file) {
                            setState(() => controller.profileImage = file);
                          }),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: controller.profileImage != null
                            ? FileImage(controller.profileImage!) as ImageProvider
                            : (profileImageUrl != null && profileImageUrl.isNotEmpty
                            ? NetworkImage(profileImageUrl)
                            : const AssetImage('assets/default_profile_picture.jpg')),
                        child: Icon(Icons.edit, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 16),

                    _buildRoundedField(controller.firstNameController,
                        AppLocalizations.of(context)!.firstname, context),
                    const SizedBox(height: 8),
                    _buildRoundedField(controller.lastNameController,
                        AppLocalizations.of(context)!.lastname, context),
                    const SizedBox(height: 8),

                    TextField(
                      controller: controller.oldPasswordController,
                      obscureText: controller.obscurePassword,
                      decoration: _decoration(AppLocalizations.of(context)!.curr_password, context,
                          errorText: passwordErrorText),
                    ),
                    const SizedBox(height: 8),

                    TextField(
                      controller: controller.newPasswordController,
                      obscureText: controller.obscurePassword,
                      decoration: _decoration(AppLocalizations.of(context)!.password, context),
                    ),
                    const SizedBox(height: 8),

                    TextField(
                      controller: controller.confirmPasswordController,
                      obscureText: controller.obscurePassword,
                      decoration: _decoration(AppLocalizations.of(context)!.confirm_password, context,
                          errorText: confirmPasswordErrorText),
                    ),
                    const SizedBox(height: 16),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 24),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ).copyWith(
                        backgroundColor: MaterialStateProperty.resolveWith((
                            _) => null),
                        elevation: MaterialStateProperty.resolveWith((_) => 0),
                      ),
                        onPressed: () async {
                          setState(() {
                            passwordErrorText = null;
                            confirmPasswordErrorText = null;
                          });

                          final oldPwd = controller.oldPasswordController.text.trim();
                          final newPwd = controller.newPasswordController.text.trim();
                          final confirmPwd = controller.confirmPasswordController.text.trim();
                          final newFirstName = controller.firstNameController.text.trim();
                          final newLastName = controller.lastNameController.text.trim();

                          bool shouldUpdatePassword = newPwd.isNotEmpty || confirmPwd.isNotEmpty || oldPwd.isNotEmpty;

                          if (shouldUpdatePassword) {
                            if (newPwd.length < 8) {
                              setState(() {
                                passwordErrorText = AppLocalizations.of(context)!.password_length;
                              });
                              return;
                            }

                            if (confirmPwd.length < 8) {
                              setState(() {
                                confirmPasswordErrorText = AppLocalizations.of(context)!.password_length;
                              });
                              return;
                            }

                            if (newPwd != confirmPwd) {
                              setState(() {
                                confirmPasswordErrorText = AppLocalizations.of(context)!.error_confirm_password;
                              });
                              return;
                            }

                            try {
                              final user = FirebaseAuth.instance.currentUser;
                              final cred = EmailAuthProvider.credential(
                                  email: user!.email!, password: oldPwd);
                              await user.reauthenticateWithCredential(cred);
                              await user.updatePassword(newPwd);
                            } catch (e) {
                              setState(() {
                                passwordErrorText = AppLocalizations.of(context)!.error_password;
                              });
                              return;
                            }
                          }

                          try {
                            await FirestoreService().updateUserProfile(
                              userId: userId,
                              firstName: newFirstName,
                              lastName: newLastName,
                              profileImageFile: controller.profileImage,
                            );

                            if (mounted) {
                              Navigator.pop(context);
                            }
                          } catch (e) {
                            setState(() {
                              passwordErrorText = AppLocalizations.of(context)!.error_password;
                            });
                            debugPrint('Re-authentication error: $e');
                            return;
                          }
                        },
                        child: Ink(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF255f38), Color(0xFF27391c)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          height: 48,
                          child: Text(AppLocalizations.of(context)!.save_text,
                              style: const TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> changePassword(String newPassword) async {
    if (newPassword.length < 8) return;

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) await user.updatePassword(newPassword);
  }

  InputDecoration _decoration(String label, BuildContext context,
      {String? errorText}) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        color: Colors.black,
      ),
      errorText: errorText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }

  Widget _buildRoundedField(TextEditingController controller, String label,
      BuildContext context) {
    return TextField(
      controller: controller,
      decoration: _decoration(label, context),
    );
  }

}

class ProfileEditController {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  File? profileImage;
  bool obscurePassword = true;

  final ImagePicker picker = ImagePicker();
  final CloudinaryService cloudinaryService = CloudinaryService();

  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
  }

  Future<void> pickImage(Function(File) onImagePicked) async {
    final XFile? xfile = await picker.pickImage(source: ImageSource.gallery);
    if (xfile != null) {
      onImagePicked(File(xfile.path));
    }
  }

  Future<String?> uploadImage() async {
    if (profileImage == null) return null;
    return cloudinaryService.uploadImageUnsigned(
      profileImage!,
      CloudinaryData.presetName,
    );
  }
}

/*
// Reminder Section
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppLocalizations.of(context)!.reminder_section_title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      FutureBuilder<List<Map<String, dynamic>>>(
                        future: FirestoreService().fetchReminders(widget.userId!),
                        builder: (context, snapshot) {
                          final reminders = snapshot.data ?? [];

                          return Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 6,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (snapshot.connectionState == ConnectionState.waiting)
                                  const Center(child: CircularProgressIndicator())
                                else if (reminders.isEmpty)
                                  Text(AppLocalizations.of(context)!.no_reminders_yet)
                                else
                                  Column(
                                    children: reminders.map((reminder) {
                                      final date = DateTime.tryParse(reminder['date'] ?? '');
                                      final formattedDate = date != null
                                          ? DateFormat('yyyy.MM.dd HH:mm').format(date)
                                          : 'N/A';

                                      if (!reminder['done']) {
                                        return ListTile(
                                          contentPadding: EdgeInsets.zero,
                                          leading: Checkbox(
                                            value: reminder['done'] ?? false,
                                            onChanged: (value) async {
                                              if (value == true) {
                                                await FirestoreService().updateReminderDoneStatus(
                                                  widget.userId!,
                                                  reminder['id'],
                                                  true,
                                                );
                                                setState(() {});
                                              }
                                            },
                                          ),
                                          title: Text(
                                            reminder['title'] ?? '',
                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(reminder['description'] ?? ''),
                                            ],
                                          ),
                                          trailing: Text(formattedDate),
                                          isThreeLine: true,
                                        );
                                      }

                                      return null;
                                    }).whereType<Widget>().toList(),
                                  ),

                                // Button, save reminder
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: gradient,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: const Offset(2, 2),
                                      ),
                                    ],
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(20),
                                          ),
                                        ),
                                        builder: (context) => Padding(
                                          padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context).viewInsets.bottom,
                                            left: 16,
                                            right: 16,
                                            top: 20,
                                          ),
                                          child: _buildMemoryInputSheet(context),
                                        ),
                                      ).then((_) => setState(() {}));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Text(
                                      AppLocalizations.of(context)!.create_reminder,
                                      style: const TextStyle(fontSize: 13, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
 */
