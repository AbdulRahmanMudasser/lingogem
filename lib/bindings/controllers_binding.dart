import 'package:get/get.dart';
import 'package:lingogem/controllers/prompt_screen_controller.dart';

class ControllersBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PromptScreenController());
  }
}
