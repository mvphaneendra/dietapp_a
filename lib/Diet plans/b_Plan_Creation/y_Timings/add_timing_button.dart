import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/constsnts/const_objects_pc.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/controllers/plan_creation_controller0.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/coice_foods_model.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/foods_model_for_plan.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/timing_info_model.dart';
import 'package:dietapp_a/x_customWidgets/alert_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTimingButton extends StatelessWidget {
  AddTimingButton({Key? key}) : super(key: key);
  final List<String> listTimings =
      pcBox.get(pcc0.listTimings) ?? pcc0.constListTimings;
  final Rx<bool> isAddNewPressed = false.obs;
  final Rx<String> newTimingName = "".obs;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: ElevatedButton(
          onPressed: () {
            alertDialogueW(
              context,
              insetPadding: const EdgeInsets.all(30),
              body: LimitedBox(
                  maxHeight: 255,
                  child: Obx(
                    () => isAddNewPressed.value ? textfieldW() : listNamesW(),
                  )),
            );
          },
          child: const Text("Add timing")),
    );
  }

  Widget listNamesW() {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: listTimings.map((name) {
                return InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(name),
                  ),
                  onTap: () async {
                    await addTiming(name);
                    Get.back();
                  },
                );
              }).toList(),
            ),
          ),
        ),
        SizedBox(height: 5),
        Align(
          child: TextButton(
              onPressed: () {
                isAddNewPressed.value = true;
              },
              child: Text("Add new")),
          alignment: Alignment.bottomRight,
        ),
      ],
    );
  }

  Future<void> addTiming(String name) async {
    await FirebaseFirestore.instance
        .doc(pcc0.currentDayDRpath.value)
        .collection(tims.timings)
        .orderBy(tims.timingIndex, descending: true)
        .limit(1)
        .get()
        .then((value) async {
      int timingIndex = 0;
      if (value.docs.length == 1) {
        Map<String, dynamic> dataMap = value.docs.last.data();
        timingIndex = dataMap[tims.timingIndex];
      }
      await FirebaseFirestore.instance
          .doc(pcc0.currentDayDRpath.value)
          .collection(tims.timings)
          .add(TimingInfoModel(
                  hasChoices: null,
                  timingIndex: timingIndex + 1,
                  timingName: name,
                  notes: null,
                  refURL: null)
              .toMap())
          .then((docRef) async {
        await docRef.collection(choiceFMS.choices).add(ChoiceFoodsModel(
                choiceIndex: 0, choiceName: "", notes: null, refURL: null)
            .toMap());
      });
    });
  }

  Widget textfieldW() {
    return SizedBox(
      height: 150,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              autofocus: true,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.go,
              onChanged: (value) {
                newTimingName.value = value;
              },
              onSubmitted: (value) async {
                await addTiming(value);
                Get.back();
              },
            ),
          ),
          const SizedBox(height: 10),
          Align(
            child: TextButton(
                onPressed: () async {
                  await addTiming(newTimingName.value);
                  Get.back();
                },
                child: Text("Add new")),
            alignment: Alignment.bottomRight,
          ),
        ],
      ),
    );
  }
}
