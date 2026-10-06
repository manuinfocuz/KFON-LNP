import 'package:get/get.dart';

import '../../utils/routes.dart';
import 'global_loading_dialog.dart';

class GlobalLoadingDialogController extends GetxController {
  static GlobalLoadingDialogController get to => Get.find();

  static Future openDialog() async {
    GlobalLoadingDialog.openDialog();
  }

  static Future closeDialog() async {
    //  print(Get.currentRoute);
    // if(Get.currentRoute == AppRoutes.LOADINGDIALOG.name){
    Get.back();
    //  }
  }
}
