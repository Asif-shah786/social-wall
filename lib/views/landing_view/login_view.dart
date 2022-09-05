import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_wall/utilities/constant.dart';
import 'package:social_wall/views/landing_view/sign_up_view.dart';

import '../../service/auth_service.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key, }) : super(key: key);


  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool hidePassword = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void initState() {
    super.initState();
    emailController = TextEditingController(text: "");
    passwordController = TextEditingController(text: "");
  }
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    bool validateAndSave() {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        return true;
      } else {
        return false;
      }
    }

    return SafeArea(
      child: Scaffold(
          backgroundColor: kBackgroundColor,
          body: Stack(children: [
            Positioned(
                left: -60,
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
                    //const SizedBox(height: 10),
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
                      padding: EdgeInsets.all(width * 0.06),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: width * 0.06,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: width * 0.03,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.04),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                hintText: 'Email',
                                hintStyle: const TextStyle(color: kPrimaryColor),
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
                          SizedBox(height: width * 0.02),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.04),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              controller: passwordController,
                              keyboardType: TextInputType.text,
                              obscureText: hidePassword,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                hintStyle: const TextStyle(color: kPrimaryColor),
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
                          SizedBox(height: width * 0.02),
                          Padding(
                            padding: EdgeInsets.all(width * 0.03),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Forget password ?',
                                  style: TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: width * 0.035,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline),
                                ),
                                SizedBox(width: width * 0.3),
                                ElevatedButton(
                                        onPressed: () async {
                                          if (validateAndSave()) {
                                            await authService.signWithEmailAndPassword(emailController.text, passwordController.text);
                                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                              content:
                                              Text("User Logged In"),
                                            ));
                                            // Navigator.pop(context);
                                          }else{
                                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                              content:
                                              Text("Fill All the Fields"),
                                            ));
                                            print('Not validated');
                                          }
                                        },
                                        style: ButtonStyle(
                                          foregroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.black),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  kPrimaryColor),
                                        ),
                                        child: const Text('Login'),
                                      ),
                              ],
                            ),
                          ),
                          SizedBox(height: width * 0.1),
                          InkWell(
                            child: Text(
                              'Don\'t have an account? Signup ',
                              style: TextStyle(
                                  fontSize: width * 0.04,
                                  fontWeight: FontWeight.bold),
                            ),
                            onTap: () {
                                Navigator.push (
                                  context,
                                  MaterialPageRoute (
                                    builder: (BuildContext context) => SignUpView(),
                                  ),
                                );
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
    );
  }
}
