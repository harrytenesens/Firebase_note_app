import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passswordController = TextEditingController();
  final _confirmPassController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _ageController = TextEditingController();

  bool isloading = false;

// custom message method
  void _customSnackbar({required String text}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(text),
          duration: const Duration(seconds: 2),
        ),
      );
  }

  Future signUp() async {
    // password matching check
    try {
      if (_passswordController.text.trim() ==
          _confirmPassController.text.trim()) {
        setState(() {
          isloading = true;
        });
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passswordController.text.trim(),
        );

        addUserDetails();
        if (mounted) {
          Navigator.pop(context);
        }
      } else {
        _customSnackbar(text: 'password did not match');
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        isloading = false;
      });
      _customSnackbar(text: e.message.toString());
    }
  }

  void addUserDetails() async {
    await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).set({
      'first Name': _firstNameController.text.trim(),
      'last name': _lastNameController.text.trim(),
      'age': _ageController.text.trim(),
      'email': _emailController.text.trim(),
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passswordController.dispose();
    _ageController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: Center(
          child: isloading == true
              ? const CircularProgressIndicator()
              : SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // welcome text
                      const Text(
                        'Begin Your Adventure',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 22, 42, 63),
                        ),
                      ),
                      const SizedBox(height: 25),
                      // first name section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextField(
                              controller: _firstNameController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'First Name',
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // last name section
                      // first name section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextField(
                              controller: _lastNameController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Last Name',
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // age section
                      // first name section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextField(
                              controller: _ageController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Age',
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // email section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextField(
                              controller: _emailController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Your Email',
                              ),
                            ),
                          ),
                        ),
                      ),
                      // passoword textfield
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextField(
                              controller: _passswordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter Password',
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // confirm password box
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextField(
                              controller: _confirmPassController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Confirm password',
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      // sign in button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: ElevatedButton(
                          onPressed: signUp,
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13)),
                              minimumSize: const Size(double.infinity, 60),
                              backgroundColor:
                                  const Color.fromARGB(255, 22, 42, 63)),
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 17),
                      // register button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'I am a memeber!',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                ' Login',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              )),
                        ],
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
