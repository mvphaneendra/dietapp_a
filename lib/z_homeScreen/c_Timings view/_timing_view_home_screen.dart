import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/Combined%20screen/_plan_creation_combined_screen.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/controllers/plan_creation_controller.dart';
import 'package:dietapp_a/app%20Constants/colors.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_metadata_model.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_widget.dart';
import 'package:dietapp_a/x_customWidgets/expandable_text.dart';
import 'package:dietapp_a/y_Active%20diet/controllers/active_plan_controller.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_day_model.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_timing_model.dart';
import 'package:dietapp_a/z_homeScreen/c_Timings%20view/a_timings_row_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

import 'b_cam_pictures_timings_view.dart';
import 'c_foods_list_timings_view.dart';

//
class TimingViewHomeScreen extends StatelessWidget {
  final bool editingIconRequired;
  final bool isDayExists;

  const TimingViewHomeScreen({
    Key? key,
    required this.isDayExists,
    this.editingIconRequired = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isDayExists) {
      return Obx(() => FirestoreListView<Map<String, dynamic>>(
          shrinkWrap: true,
          query: apc.currentActiveDayDR.value
              .collection(atmos.timings)
              .orderBy(atmos.timingString),
          itemBuilder: (context, qDS) {
            var atm = ActiveTimingModel.fromMap(qDS.data());
            atm.docRef = qDS.reference;

            return Card(
              child: Column(
                children: [
                  TimingsRowHomeScreen(atm: atm),
                  CamPicturesTimingsView(atm: atm),
                  if (atm.rumm != null)
                    RefURLWidget(
                      refUrlMetadataModel: atm.rumm ?? rummfos.constModel,
                      editingIconRequired: editingIconRequired,
                    ),
                  if (atm.notes != null && atm.notes != "") notes(context, atm),
                  FoodsListTimingsView(atm: atm, isCamFood: false),
                ],
              ),
            );
          }));
    } else {
      return dayNotExistsW();
    }
  }

  Widget dayNotExistsW() {
    var todayString = admos.dayStringFromDate(DateTime.now());
    var today = DateTime.parse(todayString);

    var selectedDate = DateTime.parse(apc.currentActiveDayDR.value.id);

    var isBefore = selectedDate.isBefore(today);

    var isAfter = true;
    if (todayString != apc.currentActiveDayDR.value.id && isBefore) {
      isAfter = false;
    }
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                "Diet not ${isAfter ? 'planned' : 'recorded'} for this day"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GFButton(
                color: primaryColor,
                onPressed: () async {
                  if (isAfter) {
                    pcc.currentDayDR.value = apc.currentActiveDayDR.value;

                    pcc.isCombinedCreationScreen.value = true;
                    Get.to(() => const PlanCreationCombinedScreen(
                          isWeekWisePlan: false,
                          isForActivePlan: true,
                          isForSingleDayActive: true,
                        ));
                    await atmos.activateDefaultTimings(pcc.currentDayDR.value);
                    pcc.currentTimingDR.value =
                        await pcc.getTimingDRfromDay(pcc.currentDayDR.value);
                  }
                },
                child: Text(isAfter ? "Plan now" : "Make a note")),
          ),
        ],
      ),
    );
  }

  Widget notes(BuildContext context, ActiveTimingModel atm) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: expText(
          atm.notes!,
          expandOnTextTap: true,
          textColor: Colors.black,
        ),
      ),
    );
  }
}
