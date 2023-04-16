import 'package:get/get.dart';

class MainPanelController extends GetxController {
  RxInt selectedPage = 0.obs;

  changePage(int page) {
    selectedPage.value = page;
  }
}
