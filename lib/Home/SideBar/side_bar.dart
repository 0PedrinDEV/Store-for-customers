import 'package:flutter/material.dart';
import 'package:loja/Dados/dados.dart';
import '../../Components/rive_asset.dart';
import 'info_card.dart';
import 'menu_tile.dart';

class SideBar extends StatefulWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  RiveAsset selectedMenu = sideMenus.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 288,
        height: double.infinity,
        color: const Color(0xFF45484A),
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                InfoCard(name: tname, email: temail),
                const Padding(
                  padding: EdgeInsets.only(left: 24, right: 24),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32, left: 24, bottom: 16),
                  child: Text(
                    "PERFIL",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.white60),
                  ),
                ),
                ...sideMenus.map(
                  (menu) => SideMenuTile(
                    isActive: selectedMenu == menu,
                    menu: menu,
                    press: () {
                      //  menu.input!.change(true);
                      //    Future.delayed(const Duration(seconds: 1), () {
                      //      menu.input!.change(false);
                      //  },
                      // );
                      setState(() {
                        selectedMenu = menu;
                      });
                    },
                    riveonInit: (artboard) {
                      //  StateMachineController controller =
                      //      RiveUtils.getRiveController(artboard,
                      //           stateMachineName: menu.stateMachineName);
                      //   menu.input = controller.findSMI("active") as SMIBool;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32, left: 24, bottom: 16),
                  child: Text(
                    "PROMOÇÕES",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.white60),
                  ),
                ),
                ...sideMenus2.map(
                  (menu) => SideMenuTile(
                    isActive: selectedMenu == menu,
                    menu: menu,
                    press: () {
                      //  menu.input!.change(true);
                      //    Future.delayed(const Duration(seconds: 1), () {
                      //      menu.input!.change(false);
                      //  },
                      // );
                      setState(() {
                        selectedMenu = menu;
                      });
                    },
                    riveonInit: (artboard) {
                      //  StateMachineController controller =
                      //      RiveUtils.getRiveController(artboard,
                      //           stateMachineName: menu.stateMachineName);
                      //   menu.input = controller.findSMI("active") as SMIBool;
                    },
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
/*
   
                  menu: menu,
                  riveonInit: (artboard) {
                    StateMachineController controller =
                        RiveUtils.getRiveController(artboard,
                            stateMachineName: menu.stateMachineName);

                    menu.input = controller.findSMI("active") as SMIBool;
                  },
                  isActive: false,
                  press: () {
                    menu.input!.change(true);
                  },
*/
