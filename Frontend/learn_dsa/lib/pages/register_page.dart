import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:permission_handler/permission_handler.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  File? _profileImage;
  Map<String, String> _errors = {};

  @override
  void initState() {
    super.initState();
    // Add listeners to clear errors when fields are not empty
    _addListeners();
  }

  void _addListeners() {
    firstNameController.addListener(() {
      if (firstNameController.text.isNotEmpty) {
        setState(() {
          _errors.remove('firstName');
        });
      }
    });
    lastNameController.addListener(() {
      if (lastNameController.text.isNotEmpty) {
        setState(() {
          _errors.remove('lastName');
        });
      }
    });
    usernameController.addListener(() {
      if (usernameController.text.isNotEmpty) {
        setState(() {
          _errors.remove('username');
        });
      }
    });
    emailController.addListener(() {
      if (emailController.text.isNotEmpty) {
        setState(() {
          _errors.remove('email');
        });
      }
    });
    passwordController.addListener(() {
      if (passwordController.text.isNotEmpty) {
        setState(() {
          _errors.remove('password');
        });
      }
    });
    confirmPasswordController.addListener(() {
      if (confirmPasswordController.text.isNotEmpty) {
        setState(() {
          _errors.remove('confirmPassword');
        });
      }
    });
  }

  Future<void> _pickImage() async {
    // Check for permissions
    final status = await Permission.photos.request();

    if (status.isGranted) {
      try {
        final pickedFile = await ImagePicker().pickImage(
            source: ImageSource.gallery);
        if (pickedFile != null) {
          setState(() {
            _profileImage = File(pickedFile
                .path); // Directly set the profile image without cropping
          });
        } else {
          // Handle case where no image was selected
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No image selected')),
          );
        }
      } catch (e) {
        // Catch any error that occurs during image picking
        print('Error picking image: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to pick image: $e')),
        );
      }
    } else if (status.isDenied) {
      _showPermissionDialog();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  Future<void> _showPermissionDialog() async {
    return showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: const Text("Engedély szükséges"),
            content: const Text(
                "Az alkalmazásnak engedélyre van szüksége a galéria eléréséhez. Kérjük, engedélyezd a hozzáférést a kép kiválasztásához."),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Mégse"),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  if (await Permission.storage
                      .request()
                      .isGranted) {
                    _pickImage(); // Folytatja a képkiválasztást az engedélyezés után
                  }
                },
                child: const Text("Engedélyezés"),
              ),
            ],
          ),
    );
  }

  void _register() {
    HapticFeedback.lightImpact();

    setState(() {
      _errors.clear(); // Clear previous errors
    });

    final firstName = firstNameController.text;
    final lastName = lastNameController.text;
    final username = usernameController.text;
    final email = emailController.text;
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    bool hasError = false;

    // Validate fields and add errors to the map
    if (firstName.isEmpty) {
      _errors['firstName'] = '*required';
      hasError = true;
    }

    if (lastName.isEmpty) {
      _errors['lastName'] = '*required';
      hasError = true;
    }

    if (username.isEmpty) {
      _errors['username'] = '*required';
      hasError = true;
    }

    if (email.isEmpty) {
      _errors['email'] = '*required';
      hasError = true;
    }

    if (password.isEmpty) {
      _errors['password'] = '*required';
      hasError = true;
    } else if (password != confirmPassword) {
      _errors['confirmPassword'] = 'Passwords do not match';
      hasError = true;
    }

    if (!hasError) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration successful!')),
      );

      // Clear the fields after registration
      firstNameController.clear();
      lastNameController.clear();
      usernameController.clear();
      emailController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
      setState(() {
        _profileImage = null; // Reset profile image if needed
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme
        .of(context)
        .brightness == Brightness.dark;

    // Birth Date
    int? selectedYear;
    int? selectedMonth;
    int? selectedDay;
    final List<int> years = List.generate(100, (index) =>
    DateTime
        .now()
        .year - index);
    final List<int> months = List.generate(12, (index) => index + 1);
    final List<int> days = List.generate(31, (index) => index + 1);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8, // Set the width to 80% of the screen
                    child: CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.grey[200],
                      backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                      child: _profileImage == null ? const Icon(Icons.add_a_photo, size: 70) : null,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // First Name and Last Name fields side by side
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Row(
                    children: [

                      // First Name TextField
                      Expanded(
                        child: TextField(
                          key: Key('firstNameField'),
                          controller: firstNameController,
                          decoration: InputDecoration(
                            labelText: 'Firstname',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16), // Space between fields

                      // Last Name TextField
                      Expanded(
                        child: TextField(
                          key: Key('lastNameField'),
                          controller: lastNameController,
                          decoration: InputDecoration(
                            labelText: 'Lastname',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Username TextField
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField(
                    key: Key('usernameField'),
                    controller: usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.blue),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),

                const SizedBox(height: 16),

                // Birth Date Selection Instruction
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Birthdate:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // Birth Date Picker with separate year, month, and day dropdowns
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Row(
                    children: [
                      // Year Dropdown
                      Expanded(
                        child: DropdownButtonFormField<int>(
                          value: selectedYear,
                          hint: const Text('Year'),
                          items: years.map((year) {
                            return DropdownMenuItem<int>(
                              value: year,
                              child: Text(year.toString()),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedYear = value;
                            });
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),

                      // Month Dropdown
                      Expanded(
                        child: DropdownButtonFormField<int>(
                          value: selectedMonth,
                          hint: const Text('Month'),
                          items: months.map((month) {
                            return DropdownMenuItem<int>(
                              value: month,
                              child: Text(month.toString().padLeft(2, '0')),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedMonth = value;
                            });
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),

                      // Day Dropdown
                      Expanded(
                        child: DropdownButtonFormField<int>(
                          value: selectedDay,
                          hint: const Text('Day'),
                          items: days.map((day) {
                            return DropdownMenuItem<int>(
                              value: day,
                              child: Text(day.toString().padLeft(2, '0')),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedDay = value;
                            });
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Email TextField with rounded corners and fixed width
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField(
                    key: const Key('emailField'),
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.blue),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                const SizedBox(height: 16),

                // Password TextField with rounded corners and fixed width
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField(
                    key: const Key('passwordField'),
                    controller: passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.blue),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off : Icons
                              .visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Confirm Password TextField
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField(
                    key: Key('confirmPasswordField'),
                    controller: confirmPasswordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.blue),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off : Icons
                              .visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Register Button with fixed width
                ElevatedButton(
                  onPressed: () {
                    HapticFeedback.lightImpact();

                    final firstName = firstNameController.text;
                    final lastName = lastNameController.text;
                    final email = emailController.text;
                    final password = passwordController.text;
                  },
                  child: const Text('Register'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: isDarkMode ? Colors.grey[850] : Colors
                        .blue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}