import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../models/form_type_model.dart';
import '../../providers/subscriber/sub_create_provider.dart';
import '../../utils/style.dart';
import '../../view/subscriber/sub_create/subscriber_form_screen.dart';

class SelectedFormPlan extends StatelessWidget {
  final SubCreateProvider subCreateProvider;

  const SelectedFormPlan({
    super.key,
    required this.subCreateProvider,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
            subCreateProvider.newPlanListModel?.plantypesList.length ?? 0,
            (mIndex) {
          var itemData =
              subCreateProvider.newPlanListModel?.plantypesList[mIndex];

          return TextButton(
            onPressed: () {
              Get.bottomSheet(
                BottomSheet(
                  onClosing: () {},
                  builder: (_) {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${itemData?.title}",
                              style: appTextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: List.generate(
                                itemData?.data.length ?? 0,
                                (index) {
                                  var singleItem = itemData?.data[index];
                                  return PlanTile(
                                    subCreateProvider
                                        .newPlanListModel?.planlistHeadings,
                                    singleItem,
                                    onTab: (value) {
                                      subCreateProvider.selectedPlan = value[1];
                                      subCreateProvider.selectedPlanID =
                                          value[0];
                                      subCreateProvider
                                              .selectedPackageController.text =
                                          subCreateProvider.selectedPlan ?? "";
                                      subCreateProvider.notifyListeners();
                                      Get.back();
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
              );
            },
            child: Text("${itemData?.title}"),
          );
        }),
      ),
    );
  }
}

class PlanTile extends StatelessWidget {
  final List<String>? planlistHeadings;
  final List<String>? singleItem;
  final Function onTab;

  const PlanTile(
    this.planlistHeadings,
    this.singleItem, {
    super.key,
    required this.onTab,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          print(singleItem);
          onTab(singleItem);
        },
        child: ListTile(
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              planlistHeadings?.length ?? 0,
              (index) {
                bool isAmount = false;
                var title = planlistHeadings?[index];
                var value = singleItem?[index];
                isAmount = title?.toLowerCase() == "price";
                return Text('$title : ${isAmount ? "₹ " : ""}$value');
              },
            ),
          ),
        ),
      ),
    );
  }
}
