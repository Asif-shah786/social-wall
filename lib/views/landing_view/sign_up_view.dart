import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_wall/views/landing_view/login_view.dart';

import '../../service/auth_service.dart';
import '../../utilities/constant.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key,}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  bool hidePassword = true;
  bool hideConfirmPassword = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();
  //bool isAPICallProcess = false;

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final authService = Provider.of<AuthService>(context);

    return SafeArea(
        child:
          Scaffold(
              backgroundColor: kBackgroundColor,
              body: Stack(
                  children: [
                Positioned(
                    right: -60,
                    top: -40,
                    child: Opacity(
                        opacity: 0.3,
                        child: Image.asset(
                          'assets/ring_vetor.png',
                          width: width * 0.5,
                          height: width * 0.5,
                        ))),
                Container(
                  width: width,
                  height: height,
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: width,
                          child: Text(
                            kAppName,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              letterSpacing: 2.5,
                              color: kPrimaryColor,
                              fontSize: width * 0.10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(width * 0.05),
                          child: Text(
                            "Signup",
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: width * 0.06,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: width * 0.02),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.04),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    if (value.length < 3) {
                                      return 'username should be more then 2 letters';
                                    }

                                    return null;
                                  },
                                  keyboardType: TextInputType.text,
                                  controller: _usernameController,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    hintText: 'Username',
                                    hintStyle:
                                        const TextStyle(color: kPrimaryColor),
                                    suffixIcon: const Icon(Icons.person,
                                        color: kPrimaryColor),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: width * 0.01),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.04),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    hintText: 'Email',
                                    hintStyle:
                                        const TextStyle(color: kPrimaryColor),
                                    suffixIconColor: kPrimaryColor,
                                    suffixIcon: Icon(
                                      color: kPrimaryColor,
                                      Icons.mail,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: width * 0.01),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.04),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  controller: _passwordController,
                                  keyboardType: TextInputType.text,
                                  obscureText: hidePassword,
                                  decoration: InputDecoration(
                                    hintText: 'Password',
                                    hintStyle:
                                        const TextStyle(color: kPrimaryColor),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        color: kPrimaryColor,
                                        hidePassword
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          hidePassword = !hidePassword;
                                        });
                                      },
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: width * 0.01),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.04),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    if (value != _passwordController.text) {
                                      return 'Not Match';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.visiblePassword,
                                  controller: _confirmPasswordController,
                                  obscureText: hideConfirmPassword,
                                  textInputAction: TextInputAction.done,
                                  decoration: InputDecoration(
                                    hintText: 'Confirm password',
                                    hintStyle:
                                        const TextStyle(color: kPrimaryColor),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        color: kPrimaryColor,
                                        hideConfirmPassword
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          hideConfirmPassword =
                                              !hideConfirmPassword;
                                        });
                                      },
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: width * 0.01),
                              Padding(
                                padding: EdgeInsets.all(width * 0.03),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          kPrimaryColor,
                                        ),
                                        foregroundColor:
                                            MaterialStateProperty.all(
                                          Colors.black,
                                        ),
                                      ),
                                      child: const Text('SignUp'),
                                      onPressed: () async {
                                        if (validateAndSave()) {
                                            await authService.createUserWithEmailAndPassword(_emailController.text, _passwordController.text);
                                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                              content:
                                              Text("User Registered"),
                                            ));
                                            Navigator.pop(context);
                                        }else{
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                            content:
                                            Text("Fill All the Fields"),
                                          ));
                                          print('Not validated');
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: width * 0.01),
                              InkWell(
                                child: Text(
                                  'Already have an account? Login',
                                  style: TextStyle(
                                      fontSize: width * 0.04,
                                      fontWeight: FontWeight.bold),
                                ),
                                onTap: () {
                                    Navigator.push (
                                      context,
                                      MaterialPageRoute (
                                        builder: (BuildContext context) => LoginView(),
                                      ),
                                    );
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: width * 0.1),
                      ],
                    ),
                  ),
                )
              ])),
        );
  }

  bool validateAndSave() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      return true;
    } else {
      return false;
    }
  }
}
