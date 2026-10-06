import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kfon_lnp/providers/local_providers/local_provider.dart';
import 'package:kfon_lnp/providers/subscriber/sub_create_provider.dart';
import 'package:kfon_lnp/providers/subscriber/sub_form_select_provider.dart';
import 'package:kfon_lnp/utils/routes.dart';
import 'package:kfon_lnp/utils/style.dart';
import 'package:kfon_lnp/widget/utils_widgets/globalAppBar.dart';
import 'package:provider/provider.dart';

import '../../../data_model/subscriber/caf_type_data_model.dart';
import '../../../widget/utils_widgets/build_ui.dart';

class NewSubSelectFormTypeScreen extends StatefulWidget {
  const NewSubSelectFormTypeScreen({super.key});

  @override
  State<NewSubSelectFormTypeScreen> createState() =>
      _NewSubSelectFormTypeScreenState();
}

class _NewSubSelectFormTypeScreenState
    extends State<NewSubSelectFormTypeScreen> {
  final LocaleProvider _localeProvider = Get.find();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SubFormSelectProvider(),
      builder: (context, provider) => Consumer<SubFormSelectProvider>(
        builder: (context, provider, snap) {
          return Scaffold(
            appBar: globalAppBar(
              "Subscriber Application",
            ),
            body: BuildUI(
              isLoad: provider.isLoading,
              isError: provider.isError,
              onRefreshClick: () {
                provider.getCAFType();
              },
              mainUi: Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 10,
                ),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        _buildPanel(provider),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPanel(SubFormSelectProvider provider) {
    var i = -1;
    return ExpansionPanelList(
      expandIconColor: Colors.white,
      expansionCallback: (int index, bool isExpanded) {
        if (isExpanded) {
          provider.getSUBType(
            provider.cafTypeDataModel!.caftypes[index],
          );
        }

        setState(() {
          provider.cafTypeDataModel?.caftypes[index].isExpended = isExpanded;
        });
      },
      children: provider.cafTypeDataModel == null
          ? []
          : provider.cafTypeDataModel!.caftypes
              .map<ExpansionPanel>((Caftype item) {
              i++;
              return ExpansionPanel(
                backgroundColor: primaryColor,
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    onTap: () {
                      item.isExpended = !item.isExpended;
                      if (item.isExpended) {
                        provider.getSUBType(item);
                      }
                      setState(() {});
                    },
                    title: Text(
                      "${item.cafname}",
                      style: const TextStyle(
                        color: Colors.white, // White text for contrast
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
                body: Column(
                  children: List.generate(
                    item.sType.length,
                    (index) {
                      var itemData = item.sType[index];
                      return ListTile(
                        tileColor: Colors.white, // Background for body items
                        title: Text(
                          "${itemData.profilename}",
                          style: const TextStyle(
                            color:
                                primaryColor, // Text color matches primary theme
                          ),
                        ),
                        trailing: const Icon(
                          Icons.add,
                          color:
                              secondaryColor, // Use secondary color for icons
                        ),
                        onTap: () {
                          if (item.caftypeid == "2") {
                            _localeProvider.navigate(
                              AppRoutes.AADHARDETAILSSCREEN,
                              argument: [
                                "${item.caftypeid}",
                                "${itemData.profileid}",
                                "${item.cafname}",
                              ],
                            );
                          } else {
                            _localeProvider.navigate(
                              AppRoutes.CREATESUBSCRIBER,
                              argument: [
                                "${item.caftypeid}",
                                "${itemData.profileid}",
                                null,
                                "${item.cafname}",
                              ],
                            );
                          }
                        },
                      );
                    },
                  ),
                ),
                isExpanded: item.isExpended,
              );
            }).toList(),
    );
  }
}
