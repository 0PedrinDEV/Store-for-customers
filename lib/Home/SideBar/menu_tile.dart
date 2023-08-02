import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import '../../Components/rive_asset.dart';
import '../../Themes/border_size.dart';

class SideMenuTile extends StatelessWidget {
  const SideMenuTile({
    Key? key,
    required this.menu,
    required this.press,
    required this.riveonInit,
    required this.isActive,
  }) : super(key: key);

  final RiveAsset menu;
  final VoidCallback press;
  final ValueChanged<Artboard> riveonInit;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.fastOutSlowIn,
                height: 56,
                width: isActive ? 265 : 0,
                left: 1,
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 247, 147, 160),
                      borderRadius:
                          BorderRadius.all(Radius.circular(borderButton))),
                ),
              ),
              ListTile(
                onTap: press,
                leading: SizedBox(
                  width: 34,
                  height: 34,
                  child: RiveAnimation.asset(
                    menu.scr,
                    artboard: menu.artboard,
                    onInit: riveonInit,
                  ),
                ),
                title: Text(
                  menu.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(right: 30, left: 30),
            child: Divider(
              color: Colors.white70,
              height: 5,
            ),
          ),
        ],
      ),
    );
  }
}
