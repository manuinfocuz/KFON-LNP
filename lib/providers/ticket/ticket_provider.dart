import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kfon_lnp/data_model/message_model.dart';
import 'package:kfon_lnp/utils/global_functions.dart';

import '../../data_model/ticket/ticket_details_model.dart';
import '../../data_model/ticket/ticket_list_model.dart';
import '../../data_model/ticket/ticket_subject_model.dart';
import '../../models/form_type_model.dart';
import '../../repository/ticket_repository.dart';
import '../local_providers/local_provider.dart';
import '../utlis/my_notifier.dart';

class TicketProvider extends ChangeNotifier with MyNotifier {
  final TicketRepository _ticketRepository = TicketRepository();
  TicketSubjectModel? ticketSubjectModel;
  List<DropDownDataModel> listSubject = [];
  TicketListModel? ticketListModel;
  TicketDetailsModel? ticketDetailsModel;
  int ticketPage = 1;

  ScrollController scrollController = ScrollController();

  ScrollController scrollControllerChat = ScrollController();

  TicketProvider({int type = 1}) {
    scrollController.addListener(_scrollListener);
    Future.delayed(Duration(milliseconds: 100), () {
      if (type == 2) {
        getSupportList();
      }

      if (type == 3) {
        getTicketList();
      }
    });
  }

  void _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      ticketPage += 1;
      getTicketList(isPagination: true, canLoad: false);
    }
  }

  Future<dynamic> getSupportList({bool canLoad = true}) async {
    if (canLoad) openLoader();

    var data = await _ticketRepository.getTicketSubject();
    if (data != null) {
      ticketSubjectModel = data;
      ticketSubjectModel?.issuesList.forEach((element) {
        listSubject.add(
          DropDownDataModel(
              value: "${element.msg}",
              key: "${element.slno}",
              id: "${element.slno}"),
        );
      });
    } else {}
    setIsLoading = false;
    if (canLoad) closeLoader();
  }

  Future<dynamic> sendTicket(
      String issueID, String desc, String? imagePath, String? imageName,
      {bool canLoad = true}) async {
    if (canLoad) openLoader();

    var data = await _ticketRepository.postNewIssue(
      issueID,
      desc,
      imagePath,
      imageName,
    );
    if (data != null) {
      data as MessageModel;
      // final LocaleProvider _localeProvider = Get.find();
      // _localeProvider.currentIndex = 9;
      //_localeProvider.notifyListeners();
         print('vvvvvvvvvvv');
      Future.delayed(Duration(milliseconds: 100));

      getTicketList();

      backScreen();
      GlobalFunctions.showToast(data.message, true);
    } else {}
    setIsLoading = false;
    if (canLoad) closeLoader();
  }

  Future<dynamic> getTicketList(
      {bool canLoad = true, bool isPagination = false}) async {
    if (canLoad) openLoader();

    var data = await _ticketRepository.getTicketListScreen(ticketPage);
    if (data != null) {
      data as TicketListModel;
      if (!isPagination) {
        ticketListModel = data;
      } else {
        ticketListModel?.tlist.addAll(data.tlist);
      }
      if(ticketPage==1){
        ticketPage++;
        getTicketList(isPagination: true);
      }
    } else {}
    setIsLoading = false;
    if (canLoad) closeLoader();
  }

  Future<dynamic> getTicketDetails(String ticketID,
      {bool canLoad = true}) async {
    if (canLoad) openLoader();
    var data = await _ticketRepository.getTicketDetails(ticketID);

    if (data != null) {
      ticketDetailsModel = data;
      setIsLoading = false;
      Future.delayed(Duration(milliseconds: 100), () {
        scrollControllerChat
            .jumpTo(scrollControllerChat.position.maxScrollExtent + 400);
      });
    } else {}
    setIsLoading = false;
    if (canLoad) closeLoader();
  }

  Future<dynamic> replyTicket(String ticketID, String reply, String text,
      {bool canLoad = true}) async {
    if (canLoad) openLoader();
    var data = await _ticketRepository.replyTicket(ticketID, reply);

    if (data != null) {
      getTicketDetails(ticketID);
    } else {}
    setIsLoading = false;
    if (canLoad) closeLoader();
  }
}
