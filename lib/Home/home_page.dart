import 'dart:math';
import 'package:flutter/material.dart';
import 'package:loja/Home/SideBar/menu_button.dart';
import 'package:loja/Home/SideBar/side_bar.dart';
import 'package:rive/rive.dart';
import '../Utils/rive_utils.dart';
import 'Screen/home_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> animation;
  late Animation<double> scaleAnimation;

  late SMIBool isBarOpen;
  bool isMenuOpen = true;

  String startMenu = "toggleX";

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(() {
        setState(() {});
      });

    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));

    scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF45484A),
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
            width: 288,
            left: isMenuOpen ? -288 : 0,
            height: MediaQuery.of(context).size.height,
            child: const SideBar(),
          ),
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(animation.value - 30 * animation.value * pi / 180),
            child: Transform.translate(
              offset: Offset(animation.value * 265, 0),
              child: Transform.scale(
                scale: scaleAnimation.value,
                child: const ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                  child: HomeScreen(),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
            left: isMenuOpen ? 0 : 210,
            top: 16,
            child: MenuButton(
              press: () {
                isBarOpen.value = !isBarOpen.value;
                if (isMenuOpen) {
                  _animationController.forward();
                } else {
                  _animationController.reverse();
                }
                setState(() {
                  isMenuOpen = !isBarOpen.value;
                });
              },
              riveOnInit: (artboard) {
                StateMachineController controller = RiveUtils.getRiveController(
                    artboard,
                    stateMachineName: "switch");
                isBarOpen = controller.findSMI(startMenu) as SMIBool;

                isBarOpen.value = false;
              },
            ),
          ),
        ],
      ),
    );
  }
}
