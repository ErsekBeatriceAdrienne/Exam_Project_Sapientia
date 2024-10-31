import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class RegisterPage extends StatefulWidget
{
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

  bool _obscurePassword = true;
  File? _profileImage;
  Map<String, String> _errors = {};

  int? selectedYear;
  int? selectedMonth;
  int? selectedDay;
  final List<int> years = List.generate(100, (index) => DateTime.now().year - index);
  final List<int> months = List.generate(12, (index) => index + 1);
  final List<int> days = List.generate(31, (index) => index + 1);

  @override
  void initState() {
    super.initState();
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
    final status = await Permission.photos.request();

    if (status.isGranted) {
      try {
        final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          setState(() {
            _profileImage = File(pickedFile.path);
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No image selected')),
          );
        }
      } catch (e) {
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
            title: const Text("Permission Required"),
            content: const Text(
                "The app needs permission to access the gallery. Please allow access to select an image."),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  if (await Permission.storage.request().isGranted) {
                    _pickImage();
                  }
                },
                child: const Text("Allow"),
              ),
            ],
          ),
    );
  }

  void _register() {
    HapticFeedback.lightImpact();

    setState(() {
      _errors.clear();
    });

    final firstName = firstNameController.text;
    final lastName = lastNameController.text;
    final username = usernameController.text;
    final email = emailController.text;
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    bool hasError = false;

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

    if (password.length < 8) {
      _errors['password'] = 'Password must be at least 8 characters long.';
    } else if (!RegExp(r'^(?=.*[A-Z])(?=.*\d)[A-Za-z\d]+$').hasMatch(password)) {
      _errors['password'] = 'Password must contain at least one uppercase letter and one number, and cannot contain special characters.';
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

    if (_errors.isEmpty) {
      // Regisztrációs logika itt
    } else {
      // Hibaüzenet megjelenítése
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context)
  {
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

                // Profile image
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
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
                            errorText: _errors['firstName'],
                          ),
                        ),
                      ),

                      const SizedBox(width: 16),

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
                            errorText: _errors['lastName'],
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
                      errorText: _errors['username'],
                    ),
                    keyboardType: TextInputType.text,
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

                const SizedBox(height: 16),

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

                // Email TextField
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField(
                    key: Key('emailField'),
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
                      errorText: _errors['email'],
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),

                const SizedBox(height: 16),

                // Password TextField
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField(
                    key: Key('passwordField'),
                    controller: passwordController,
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
                      errorText: _errors['password'],
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off : Icons.visibility, // Megfordított ikonok
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    obscureText: _obscurePassword,
                  ),
                ),

                const SizedBox(height: 16),

                // Confirm Password TextField
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField(
                    key: Key('confirmPasswordField'),
                    controller: confirmPasswordController,
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
                      errorText: _errors['confirmPassword'],
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off : Icons.visibility, // Megfordított ikonok
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword; // Esetleg, külön változó is lehet
                          });
                        },
                      ),
                    ),
                    obscureText: _obscurePassword,
                  ),
                ),

                const SizedBox(height: 16),

                // Register Button
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ElevatedButton(
                    onPressed: _register,
                    child: const Text('Register'),
                  ),
                ),
              ],
            ),
          ),
        ),
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
}