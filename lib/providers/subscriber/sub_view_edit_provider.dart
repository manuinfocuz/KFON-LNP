import 'package:flutter/material.dart';

import '../../data_model/subscriber/caf_details_data_model.dart';
import '../../repository/sub_view_edit_repository.dart';
import '../utlis/my_notifier.dart';

class SubViewEditProvider extends ChangeNotifier with MyNotifier {
  final SubViewEditRepository _subViewEditRepository = SubViewEditRepository();
  CafDetailsDataModel? cafDetailsDataModel;

  SubViewEditProvider({int? type, String? cafID}) {
    Future.delayed(
      const Duration(milliseconds: 100),
      () {
        if (type == 1) {
          getCAFDetails("$cafID");
        }
      },
    );
  }

  Future<dynamic> getCAFDetails(String cafID) async {
    setIsLoading = true;
    setIsError = false;
    openLoader();
    var data = await _subViewEditRepository.getSubmittedCAFDetails(cafID);
    if (data != null) {
      cafDetailsDataModel = data;
    } else {
      setIsError = true;
    }
    setIsLoading = false;
    closeLoader();
  }
}
