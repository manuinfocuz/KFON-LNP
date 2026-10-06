import 'package:flutter/cupertino.dart';
import 'package:kfon_lnp/repository/aadhar_repository.dart';
import 'package:kfon_lnp/utils/global_functions.dart';
import 'package:kfon_lnp/widget/global_loader/global_loading_dialog.dart';
import 'package:kfon_lnp/widget/global_loader/global_loading_dialog_controller.dart';

import '../../data_model/subscriber/aadharDetailsModel.dart';
import '../../data_model/subscriber/aadhar_otp_sent_data_model.dart';

class AadharValidateProvider with ChangeNotifier {
  final AadharRepository _aadharRepository = AadharRepository();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool _isError = false;

  bool get isError => _isError;

  set setIsError(bool value) {
    _isError = value;
    notifyListeners();
  }

  AadharOtpSentDataModel? aadharOtpSentDataModel;
  AadharDetailsModel? aadharDetailsModel;

  AadharValidateProvider() {
    // var d = {
    //   "status": true,
    //   "Message": "",
    //   "name": "Udayagiri Rahim",
    //   "streetlo": "naginenigunta t n peta post Brahmanapalli",
    //   "doorno": "00",
    //   "cityname": "Brahmanapalle",
    //   "pincode": "686102",
    //   "user_image":
    //       "https://testbss.kfon.co.in/documents/KL/application/support/aaphoto_130904563520231202031202616869110788.png",
    //   "gender": "Male",
    //   "genderid": "1",
    //   "dob": "1993-06-10",
    //   "mobileno": "1234567899",
    //   "email": "email@gmail.com"
    // };
    // aadharDetailsModel = AadharDetailsModel.fromJson(d);
  }

  Future<dynamic> sendOTP(
      String aadharNumber, String email, String mobileNumber) async {
    setIsLoading = true;
    GlobalLoadingDialogController.openDialog();
    var data = await _aadharRepository.validateAadhar(
        aadharNumber, email, mobileNumber);

    if (data != null) {
      aadharOtpSentDataModel = data;
      GlobalLoadingDialogController.closeDialog();
      setIsLoading = false;
      return true;
    } else {}
    GlobalLoadingDialogController.closeDialog();
    setIsLoading = false;
    return false;
  }

  Future<dynamic> verifyOTP(String OTP) async {
    setIsLoading = true;
    GlobalLoadingDialogController.openDialog();
    var data = await _aadharRepository.verifyOTP(
      "${aadharOtpSentDataModel?.aadhaarnumber}",
      "${aadharOtpSentDataModel?.txnid}",
      "${aadharOtpSentDataModel?.reqsid}",
      OTP,
    );
    if (data != null) {
      // aadharDetailsModel = data;
      // aadharDetailsModel?.resid = "${aadharOtpSentDataModel?.reqsid}";
      GlobalLoadingDialogController.closeDialog();

      GlobalFunctions.showToast("${aadharDetailsModel?.message}", true);
      await aadharDetails();
      setIsLoading = false;
      return true;
    } else {
      GlobalLoadingDialogController.closeDialog();
      setIsLoading = false;
      return false;
    }
  }

  Future<dynamic> aadharDetails() async {
    setIsLoading = true;
    GlobalLoadingDialogController.openDialog();
    var data = await _aadharRepository.aadharDetails(
      "${aadharOtpSentDataModel?.aadhaarnumber}",
      "${aadharOtpSentDataModel?.reqsid}",
    );
    if (data != null) {
      aadharDetailsModel = data;
      aadharDetailsModel?.resid = "${aadharOtpSentDataModel?.reqsid}";
      GlobalLoadingDialogController.closeDialog();

      GlobalFunctions.showToast("${aadharDetailsModel?.message}", true);
      setIsLoading = false;
      return true;
    } else {
      GlobalLoadingDialogController.closeDialog();
      setIsLoading = false;
      return false;
    }
  }
}
