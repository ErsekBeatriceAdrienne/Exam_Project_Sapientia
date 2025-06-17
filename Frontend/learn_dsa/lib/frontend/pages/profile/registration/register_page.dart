import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learn_dsa/frontend/pages/profile/login/login_page.dart';
import '../../../../backend/database/cloudinary_service.dart';
import '../../../helpers/essentials.dart';
import '../../../strings/cloudinary/cloudinary_apis.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterPage extends StatefulWidget
{
  final VoidCallback toggleTheme;

  const RegisterPage({super.key, required this.toggleTheme});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
{
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ImagePicker _picker = ImagePicker();
  final CloudinaryService _cloudinaryService = CloudinaryService();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  File? _profileImage;
  Map<String, String> _errors = {};
  int? selectedYear, selectedMonth, selectedDay;

  final List<int> years = List.generate(100, (index) => DateTime.now().year - index);
  final List<int> months = List.generate(12, (index) => index + 1);
  final List<int> days = List.generate(31, (index) => index + 1);

  @override
  void initState() {
    super.initState();
    _addListeners();
  }

  void _addListeners() {
    // Listener for clearing errors
    firstNameController.addListener(() => _clearError('firstName', firstNameController));
    lastNameController.addListener(() => _clearError('lastName', lastNameController));
    usernameController.addListener(() => _clearError('username', usernameController));
    emailController.addListener(() => _clearError('email', emailController));
    passwordController.addListener(() => _clearError('password', passwordController));
    confirmPasswordController.addListener(() => _clearError('confirmPassword', confirmPasswordController));
  }

  void _clearError(String key, TextEditingController controller) {
    if (controller.text.isNotEmpty) {
      setState(() {
        _errors.remove(key);
      });
    }
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
  }

  Future<String?> _uploadImage() async {
    if (_profileImage == null) return null;

    try {
      const presetName = CloudinaryData.presetName;
      final imageUrl = await _cloudinaryService.uploadImageUnsigned(
        _profileImage!,
        presetName,
      );
      return imageUrl;
    } catch (e) {
      print('Kép feltöltési hiba: $e');
      return null;
    }
  }

  Future<void> _register() async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      final String? profileImageUrl = await _uploadImage();

      await FirebaseFirestore.instance.collection('users').doc(userCredential.user?.uid).set({
        'firstName': firstNameController.text,
        'lastName': lastNameController.text,
        'username': usernameController.text,
        'email': emailController.text,
        'birthdate': DateTime(selectedYear!, selectedMonth!, selectedDay!).toString(),
        'profilePicture': profileImageUrl ?? '',
      });

      print("User registered and data saved: ${userCredential.user?.uid}");
    } on FirebaseAuthException catch (e) {
      print("Registration failed: ${e.message}");
    } catch (e) {
      print("Error saving user data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // Page title
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
                      Essentials().createSlideRoute(LoginPage(
                        toggleTheme: widget.toggleTheme
                      ),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 20,
                  ),
                  // Button back
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
                  AppLocalizations.of(context)!.create_account_title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF255f38),
                  ),
                ),
                actions: [

                ],
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

              // Main Content as a SliverList
              SliverPadding(
                padding: const EdgeInsets.all(16.0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      SingleChildScrollView(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: GestureDetector(
                                onTap: _pickImage,
                                child: Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.4),
                                        blurRadius: 4,
                                        offset: const Offset(4, 4),
                                      ),
                                    ],
                                    image: DecorationImage(
                                      image: _profileImage != null
                                          ? FileImage(_profileImage!)
                                          : const AssetImage('assets/default_profile_picture.jpg')
                                      as ImageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            // First and Last Name Fields
                            Row(
                              children: [
                                // First Name
                                Expanded(
                                  child: TextField(
                                    key: const Key('firstNameField'),
                                    controller: firstNameController,
                                    decoration: InputDecoration(
                                      labelText: AppLocalizations.of(context)!.firstname,
                                      border: _inputBorder(),
                                      enabledBorder: _inputBorder(),
                                      focusedBorder: _focusedBorder(),
                                      errorText: _errors['firstName'],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                // Last Name
                                Expanded(
                                  child: TextField(
                                    key: const Key('lastNameField'),
                                    controller: lastNameController,
                                    decoration: InputDecoration(
                                      labelText: AppLocalizations.of(context)!.lastname,
                                      border: _inputBorder(),
                                      enabledBorder: _inputBorder(),
                                      focusedBorder: _focusedBorder(),
                                      errorText: _errors['lastName'],
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 16),

                            // Username
                            TextField(
                              key: const Key('usernameField'),
                              controller: usernameController,
                              decoration: InputDecoration(
                                labelText: AppLocalizations.of(context)!.username,
                                border: _inputBorder(),
                                enabledBorder: _inputBorder(),
                                focusedBorder: _focusedBorder(),
                                errorText: _errors['username'],
                              ),
                            ),

                            const SizedBox(height: 16),

                            // Birthdate label
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                AppLocalizations.of(context)!.birthdate,
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),

                            // Birthdate Dropdowns
                            Row(
                              children: [
                                // Year
                                Expanded(
                                  child: DropdownButtonFormField<int>(
                                    value: selectedYear,
                                    hint: Text(AppLocalizations.of(context)!.year),
                                    items: years
                                        .map((y) => DropdownMenuItem(value: y, child: Text('$y')))
                                        .toList(),
                                    onChanged: (val) => setState(() => selectedYear = val),
                                    decoration: _dropdownDecoration(),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                // Month
                                Expanded(
                                  child: DropdownButtonFormField<int>(
                                    value: selectedMonth,
                                    hint: Text(AppLocalizations.of(context)!.month),
                                    items: months
                                        .map((m) => DropdownMenuItem(
                                        value: m, child: Text(m.toString().padLeft(2, '0'))))
                                        .toList(),
                                    onChanged: (val) => setState(() => selectedMonth = val),
                                    decoration: _dropdownDecoration(),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                // Day
                                Expanded(
                                  child: DropdownButtonFormField<int>(
                                    value: selectedDay,
                                    hint: Text(AppLocalizations.of(context)!.day),
                                    items: days
                                        .map((d) => DropdownMenuItem(
                                        value: d, child: Text(d.toString().padLeft(2, '0'))))
                                        .toList(),
                                    onChanged: (val) => setState(() => selectedDay = val),
                                    decoration: _dropdownDecoration(),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 16),

                            // Email
                            TextField(
                              key: const Key('emailField'),
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: AppLocalizations.of(context)!.email,
                                border: _inputBorder(),
                                enabledBorder: _inputBorder(),
                                focusedBorder: _focusedBorder(),
                                errorText: _errors['email'],
                              ),
                            ),

                            const SizedBox(height: 16),

                            // Password
                            TextField(
                              key: const Key('passwordField'),
                              controller: passwordController,
                              obscureText: _obscurePassword,
                              decoration: InputDecoration(
                                labelText: AppLocalizations.of(context)!.password,
                                border: _inputBorder(),
                                enabledBorder: _inputBorder(),
                                focusedBorder: _focusedBorder(),
                                errorText: _errors['password'],
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                                    color: Color(0xFF27391c),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                              ),
                            ),

                            const SizedBox(height: 16),

                            // Confirm Password
                            TextField(
                              key: const Key('confirmPasswordField'),
                              controller: confirmPasswordController,
                              obscureText: _obscureConfirmPassword,
                              decoration: InputDecoration(
                                labelText: AppLocalizations.of(context)!.confirm_password,
                                border: _inputBorder(),
                                enabledBorder: _inputBorder(),
                                focusedBorder: _focusedBorder(),
                                errorText: _errors['confirmPassword'],
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureConfirmPassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Color(0xFF27391c),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscureConfirmPassword = !_obscureConfirmPassword;
                                    });
                                  },
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            // Register Button
                            Center(
                              child: Container(
                                width: AppLocalizations
                                    .of(context)!
                                    .play_animation_button_text
                                    .length * 10 + 20,
                                height: 40,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [Color(0xFF255f38), Color(0xFF27391c)],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.4),
                                      blurRadius: 4,
                                      offset: Offset(4, 4),
                                    ),
                                  ],
                                ),
                                child: RawMaterialButton(
                                  onPressed: () {
                                    _register();
                                    HapticFeedback.mediumImpact();
                                  },
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.register_text,
                                        style: TextStyle(
                                          color: Theme
                                              .of(context)
                                              .scaffoldBackgroundColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  InputBorder _inputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.grey),
    );
  }

  InputBorder _focusedBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.green),
    );
  }

  InputDecoration _dropdownDecoration() {
    return InputDecoration(
      border: _inputBorder(),
      enabledBorder: _inputBorder(),
      focusedBorder: _focusedBorder(),
    );
  }


}