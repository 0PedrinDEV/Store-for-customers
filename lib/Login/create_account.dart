import 'package:flutter/material.dart';
import 'package:loja/Login/login_page.dart';
import 'package:loja/Login/show_loading.dart';
import 'package:rive/rive.dart';

import '../Themes/separated_space.dart';
import '../Themes/themes_color.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  routeLogin(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  dynamic validEmail = "pedro@gmail.com";
  dynamic validPassword = 1234;

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode nameFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

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
    nameFocusNode.addListener(nameFocus);
    confirmPasswordFocusNode.addListener(confirmFocus);
  }

  @override
  void dispose() {
    super.dispose();

    emailFocusNode.removeListener(emailFocus);
    passwordFocusNode.removeListener(passwordFocus);
    nameFocusNode.removeListener(nameFocus);
    confirmPasswordFocusNode.removeListener(confirmFocus);
  }

  void emailFocus() {
    isChecking?.change(emailFocusNode.hasFocus);
  }

  void passwordFocus() {
    isChecking?.change(passwordFocusNode.hasFocus);
  }

  void nameFocus() {
    isChecking?.change(nameFocusNode.hasFocus);
  }

  void confirmFocus() {
    isHandsUp?.change(confirmPasswordFocusNode.hasFocus);
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
                    focusNode: nameFocusNode,
                    controller: nameController,
                    onTap: () {},
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Nome",
                      contentPadding: EdgeInsets.all(20),
                    ),
                    onChanged: (value) {
                      numLook?.change(value.length.toDouble());
                    },
                  ),
                  const Divider(),
                  TextFormField(
                      focusNode: emailFocusNode,
                      controller: emailController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Email",
                        contentPadding: EdgeInsets.all(20),
                      ),
                      onChanged: (value) {
                        numLook?.change(value.length.toDouble());
                      }),
                  const Divider(),
                  TextFormField(
                      focusNode: passwordFocusNode,
                      controller: passwordController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Senha",
                        contentPadding: EdgeInsets.all(20),
                      ),
                      onChanged: (value) {
                        numLook?.change(value.length.toDouble());
                      }),
                  const Divider(),
                  TextFormField(
                      focusNode: confirmPasswordFocusNode,
                      controller: confirmController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Confirme sua senha",
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
                      final password = passwordController.text;

                      showLoading(context);

                      await Future.delayed(
                        const Duration(milliseconds: 2000),
                      );
                      if (mounted) Navigator.pop(context);

                      if (email == validEmail && password == validPassword) {
                        trigSuccess?.change(true);
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
                      routeLogin(context);
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
