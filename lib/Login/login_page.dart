import 'package:flutter/material.dart';
import 'package:loja/Home/home_page.dart';
import 'package:loja/Login/create_account.dart';
import 'package:loja/Login/show_loading.dart';
import 'package:loja/Themes/separated_space.dart';
import 'package:rive/rive.dart';

import '../Themes/themes_color.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  swicthPage(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: ((context) => const CreatePage())));
  }

  homePage(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  dynamic validEmail = "p";
  dynamic validPassword = 1234;

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // rive controller teddy animation

  StateMachineController? controller;

  SMIInput<bool>? isChecking;
  SMIInput<double>? numLook;
  SMIInput<bool>? isHandsUp;

  SMIInput<bool>? trigSuccess;
  SMIInput<bool>? trigFail;

  @override
  void initState() {
    super.initState();

    emailFocusNode.addListener(emailFocus);
    passwordFocusNode.addListener(passwordFocus);
  }

  @override
  void dispose() {
    super.dispose();

    emailFocusNode.removeListener(emailFocus);
    passwordFocusNode.removeListener(passwordFocus);
  }

  void emailFocus() {
    isChecking?.change(emailFocusNode.hasFocus);
  }

  void passwordFocus() {
    isHandsUp?.change(passwordFocusNode.hasFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEB9AC0),
      body: Center(
        child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              SizedBox(
                  width: 250,
                  height: 250,
                  child: RiveAnimation.asset(
                    "assets/Teddy/Teddy_rive.riv",
                    fit: BoxFit.contain,
                    stateMachines: const ["Login Machine"],
                    onInit: (artboard) {
                      controller = StateMachineController.fromArtboard(
                        artboard,
                        "Login Machine",
                      );
                      if (controller == null) return;

                      artboard.addController(controller!);
                      isChecking = controller?.findInput("isChecking");
                      numLook = controller?.findInput("numLook");
                      isHandsUp = controller?.findInput("isHandsUp");
                      trigFail = controller?.findInput("trigFail");
                      trigSuccess = controller?.findInput("trigSuccess");
                    },
                  )),
              Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    color: Colors.white),
                child: Column(children: [
                  TextFormField(
                    focusNode: emailFocusNode,
                    controller: emailController,
                    onTap: () {},
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Email",
                      prefixIcon: Icon(Icons.email),
                      contentPadding: EdgeInsets.all(20),
                    ),
                    onChanged: (value) {
                      numLook?.change(value.length.toDouble());
                    },
                  ),
                  const Divider(),
                  TextFormField(
                      focusNode: passwordFocusNode,
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Password",
                        prefixIcon: Icon(Icons.lock),
                        contentPadding: EdgeInsets.all(20),
                      ),
                      onChanged: (value) {}),
                ]),
              ),
              Container(
                  padding: const EdgeInsets.only(top: 20),
                  width: double.infinity,
                  height: 70,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)))),
                    onPressed: () async {
                      emailFocusNode.unfocus();
                      passwordFocusNode.unfocus();

                      final email = emailController.text;
                      /*final password = passwordController.text;*/ //nao esta sendo usado no momento

                      showLoading(context);

                      await Future.delayed(
                        const Duration(seconds: 2),
                      );
                      if (mounted) Navigator.pop(context);

                      if (email == validEmail) {
                        trigSuccess?.change(true);
                        Future.delayed(const Duration(seconds: 2), () {
                          homePage(context);
                        });
                      } else {
                        trigFail?.change(true);
                      }
                    },
                    child: const Text("Entrar"),
                  )),
              SizedBox(
                height: tSpaceMin,
              ),
              Container(
                  padding: const EdgeInsets.only(top: 20, left: 90, right: 90),
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)))),
                    onPressed: () {
                      swicthPage(context);
                    },
                    child: Text(
                      "Criar Conta",
                      style: TextStyle(
                        color: tCorSecundary,
                      ),
                    ),
                  ))
            ]),
      ),
    );
  }
}
