import 'package:flutter/material.dart';
import 'package:kfon_lnp/providers/finance/disbursement_provider.dart';
import 'package:kfon_lnp/utils/global_variables.dart';
import 'package:most_advance_scroll/most_advance_scroll.dart';

class DisbursementDetailsScreen extends StatefulWidget {
  final DisbursementProvider provider;

  const DisbursementDetailsScreen({
    super.key,
    required this.provider,
  });

  @override
  State<DisbursementDetailsScreen> createState() =>
      _DisbursementDetailsScreenState();
}

class _DisbursementDetailsScreenState extends State<DisbursementDetailsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Disbursement Details ${widget.provider.lastClickedDate}",
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
          centerTitle: false,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'GSTIN No: ${widget.provider.disbursementDetailsData.value?.partnerGST?.gstin ?? "-"}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Income Tax No: ${widget.provider.disbursementDetailsData.value?.partnerGST?.pan ?? "-"}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            if (widget.provider.disbursementDetailsData.value?.rlist.isEmpty ??
                true)
              const Center(
                child: Text("No data available in table"),
              )
            else
              Expanded(
                child: AdvanceListViewBuilder(
                  onPageEnd: (e, [bool? s]) {
                    if (!e) {
                      widget.provider.getRevDetails(
                        isPageination: true,
                      );
                    }
                  },
                  shrinkWrap: true,
                  itemCount: widget
                      .provider.disbursementDetailsData.value?.rlist.length,
                  itemBuilder: (context, index) {
                    var singleData = widget
                        .provider.disbursementDetailsData.value?.rlist[index];
                    var i = 0;
                    return InkWell(
                        onTap: () {},
                        child: Card(
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...?widget.provider.disbursementDetailsData
                                    .value?.headings
                                    .map(
                                  (e) {
                                    i++;
                                    return Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            '$e: ${singleData?[i - 1]}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                            maxLines: 1,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        )
                        // SubscriberCard(
                        //   subscriberId: '${singleData?.subscriberid}',
                        //   name: '${singleData?.username}',
                        //   revenue: '${singleData?.revenue}',
                        //   lnpShare: '${singleData?.anpshare}',
                        //   netshareReceived: '${singleData?.netshare}',
                        //   tds: '${singleData?.tds}',
                        // ),
                        );
                  },
                ),
              ),
            SizedBox(),
          ],
        ));
  }
}

// class SubscriberCard extends StatelessWidget {
//   final String subscriberId;
//   final String name;
//   final String revenue;
//   final String lnpShare;
//   final String netshareReceived;
//   final String tds;
//
//   const SubscriberCard({
//     Key? key,
//     required this.subscriberId,
//     required this.name,
//     required this.revenue,
//     required this.lnpShare,
//     required this.netshareReceived,
//     required this.tds,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }
