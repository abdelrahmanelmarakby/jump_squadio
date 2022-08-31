import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:scratcher/scratcher.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            controller.user = await controller.getRandomData();
          },
          child: const Icon(Icons.shuffle_on),
        ),
        body: GetBuilder<LoginController>(
          builder: (controller) {
            if (controller.isLoadingUsers) {
              return const Center(child: Text("Guess the winner"));
            } else if (controller.user == null) {
              return const Center(
                  child: Text("Click the button to get the winner"));
            } else {
              return Center(
                child: ConfettiWidget(
                  confettiController: controller.controllerBottomCenter,
                  numberOfParticles: 100,
                  maxBlastForce: 100,
                  minBlastForce: 60,
                  blastDirectionality: BlastDirectionality
                      .explosive, // don't specify a direction, blast randomly
                  shouldLoop:
                      true, // start again as soon as the animation is finished
                  colors: const [
                    Colors.green,
                    Colors.blue,
                    Colors.pink,
                    Colors.orange,
                    Colors.purple
                  ], // manually specify the colors to be used
                  createParticlePath:
                      controller.drawStar, // define a custom sha
                  child: Scratcher(
                    brushSize: 30,
                    threshold: 50,
                    color: Colors.red,
                    onChange: (value) => print("Scratch progress: $value%"),
                    onThreshold: () {
                      controller.controllerBottomCenter.play();
                      controller.controllerCenter.play();
                      controller.controllerCenterLeft.play();
                      controller.controllerCenterRight.play();
                      controller.controllerTopCenter.play();
                    },
                    child: Container(
                      color: Colors.blue,
                      child: Text(controller.user?.name ?? ""),
                    ),
                  ),
                ),
              );
            }
          },
        ));
  }
}
