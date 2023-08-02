import 'package:rive/rive.dart';

class RiveAsset {
  String artboard, stateMachineName, title, scr;
  late SMIBool? input;

  RiveAsset(this.scr,
      {required this.artboard,
      required this.stateMachineName,
      required this.title,
      this.input});

  set setInput(SMIBool status) {
    input = status;
  }
}

List<RiveAsset> sideMenus = [
  RiveAsset(
    "assets/Icons/animated_icons.riv",
    artboard: "HOME",
    stateMachineName: "HOME_Interactivity",
    title: "Inicial",
  ),
  RiveAsset(
    "assets/Icons/animated_icons.riv",
    artboard: "SEARCH",
    stateMachineName: "SEARCH_Interactivity",
    title: "Inicial",
  ),
  RiveAsset(
    "assets/Icons/animated_icons.riv",
    artboard: "CHAT",
    stateMachineName: "CHAT_Interactivity",
    title: "Curtidas",
  ),
  RiveAsset(
    "assets/Icons/animated_icons.riv",
    artboard: "LIKE/STAR",
    stateMachineName: "STAR_Interactivity",
    title: "Mensagens",
  ),
];

List<RiveAsset> sideMenus2 = [
  RiveAsset(
    "assets/Icons/animated_icons.riv",
    artboard: "TIMER",
    stateMachineName: "TIMER_Interactivity",
    title: "Curtidas",
  ),
  RiveAsset(
    "assets/Icons/animated_icons.riv",
    artboard: "BELL",
    stateMachineName: "BELL_Interactivity",
    title: "Curtidas",
  ),
];
