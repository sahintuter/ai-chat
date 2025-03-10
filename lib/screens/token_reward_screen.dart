import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class TokenRewardScreen extends GetView<ProfileController> {
  const TokenRewardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Token Kazan'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Text(
                  'Kalan Token: ${controller.remainingTokens}',
                  style: const TextStyle(fontSize: 24),
                )),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Token kazanma işlemi
              },
              child: const Text('Reklam İzle'),
            ),
          ],
        ),
      ),
    );
  }
}
