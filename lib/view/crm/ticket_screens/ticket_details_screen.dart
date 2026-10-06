import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kfon_lnp/providers/ticket/ticket_provider.dart';
import 'package:kfon_lnp/providers/utlis/dynamic_provider.dart';
import 'package:kfon_lnp/utils/global_functions.dart';
import 'package:kfon_lnp/utils/global_variables.dart';

import '../../../utils/style.dart';
import '../../../widget/utils_widgets/full_screen_image_dialog.dart';

class TicketDetailsScreen extends StatefulWidget {
  final String ticketID;

  const TicketDetailsScreen({
    super.key,
    required this.ticketID,
  });

  @override
  State<TicketDetailsScreen> createState() => _TicketDetailsScreenState();
}

class _TicketDetailsScreenState extends State<TicketDetailsScreen> {
  TextEditingController descController = TextEditingController();
  TicketProvider _ticketProvider = Get.find();

  @override
  void initState() {
    Future.delayed(
      Duration(milliseconds: 100),
          () {
        _ticketProvider.getTicketDetails(widget.ticketID);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DynamicProviderValue<TicketProvider>(
      child: (context, provider) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Ticket Information"),
          ),
          body: SafeArea(
            child: Column(
              children: [
                ticketDetailsCard(provider),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await provider.getTicketDetails(widget.ticketID);
                    },
                    child: ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      controller: provider.scrollControllerChat,
                      itemCount: _ticketProvider
                          .ticketDetailsModel?.chathistory.length ??
                          0,
                      itemBuilder: (context, index) {
                        var singleItem = _ticketProvider
                            .ticketDetailsModel?.chathistory[index];
                        bool isUser = globalLoginModel?.partnername ==
                            singleItem?.createdBy;
                        return ChatMessage(
                          isUser: isUser,
                          message: "${singleItem?.note}",
                          date: "${singleItem?.createDate?.formatDate(
                            dateFormat: DateFormat("h:mma 'on' EEEE d MMMM y"),
                          )}",
                          imageUrl: singleItem?.attachment,
                          createdBY: singleItem?.createdBy ?? '-',
                        );
                      },
                    ),
                  ),
                ),
                if (provider.ticketDetailsModel?.tdetails?.status != "closed")
                  _buildInputField(provider),
              ],
            ),
          ),
        );
      },
      provider: _ticketProvider,
    );
  }

  Widget _buildInputField(TicketProvider provider) {
    return Column(
      children: [
        // if (pickerImagePath != null)
        //   Image.file(
        //     File("$pickerImagePath"),
        //     height: 200,
        //   ),
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.grey[200],
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: (e) {
                    setState(() {});
                  },
                  controller: descController,
                  decoration: InputDecoration(
                    hintText: 'Type your message...',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              ),
              // const SizedBox(width: 10),
              // IconButton(
              //   icon: Icon(
              //     pickerImagePath == null ? Icons.image_outlined : Icons.close,
              //     color: descController.text.isNotEmpty ? primaryColor : null,
              //   ),
              //   onPressed: () async {
              //     if (pickerImagePath != null) {
              //       pickerImagePath = null;
              //       provider.notifyListeners();
              //     } else {
              //       imagePicker(provider);
              //     }
              //
              //     // Handle send button press
              //   },
              // ),
              IconButton(
                icon: Icon(
                  Icons.send,
                  color: descController.text.removeExtraSpaces().isNotEmpty
                      ? primaryColor
                      : null,
                ),
                onPressed: () async {
                  if (descController.text.removeExtraSpaces().isNotEmpty) {
                    await provider.replyTicket(
                        widget.ticketID,descController.text.removeExtraSpaces(),"");
                  }
                  descController.clear();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget ticketDetailsCard(TicketProvider provider) {
    return Card(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Ticket ID: ${provider.ticketDetailsModel?.tdetails?.ticketid ?? ''}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Subject: ${provider.ticketDetailsModel?.tdetails?.subject ?? ''}',
            ),
            // const SizedBox(height: 8),
            // Text(
            //   'Description: ',
            // ),
            const SizedBox(height: 8),
            Text(
              'Time Opened: ${provider.ticketDetailsModel?.tdetails?.createdDate?.formatDate(dateFormat: DateFormat("h:mma 'on' EEEE d MMMM y")) ?? ''}',
            ),
            const SizedBox(height: 8),
            Text(
              'Status: ${provider.ticketDetailsModel?.tdetails?.status ?? ''}',
            ),
            // const SizedBox(height: 8),
            // Row(
            //   children: [
            //     const Text('Attachments:'),
            //     InkWell(
            //       onTap: () {
            //         showFullscreenImageDialog(
            //           "${provider.ticketDetailsModel?.data?.row?.attachment}",
            //         );
            //       },
            //       child: Text(
            //         "View Image",
            //         style: appTextStyle(
            //           color: primaryColor,
            //         ),
            //       ),
            //     )
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final bool isUser;
  final String message;
  final String date;
  final String? imageUrl;

  final String createdBY;

  ChatMessage({
    super.key,
    required this.isUser,
    required this.message,
    required this.date,
    this.imageUrl,
    required this.createdBY,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isUser ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment:
          isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            if (imageUrl != null &&
                "$imageUrl".isNotEmpty &&
                imageUrl?.startsWith("http") == true ||
                imageUrl?.startsWith("https") == true)
              InkWell(
                onTap: () {
                  showFullscreenImageDialog(
                    "$imageUrl",
                  );
                },
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 200),
                  child: CachedNetworkImage(
                      imageUrl: "$imageUrl",
                      errorWidget: (context, url, error) => Center(
                        child: const Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                      )),
                ),
              ),
            Text(
              message,
              style: TextStyle(color: isUser ? Colors.white : Colors.black),
            ),
            if (!isUser)
              Text(
                "Reply by: ${createdBY}",
                style: TextStyle(
                    color:
                    isUser ? Colors.black54 : Colors.black.withOpacity(0.7),
                    fontSize: 10),
              ),
            Text(
              "at $date",
              style: TextStyle(
                  color:
                  isUser ? Colors.black54 : Colors.black.withOpacity(0.7),
                  fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}
