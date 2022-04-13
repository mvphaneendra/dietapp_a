import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/day_basic_info.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/b_Middle%20widgets/_common_top_widget_middle.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class DayPlanMiddle extends StatelessWidget {
  final List<DayModel> listDays;
  final String? text;
  const DayPlanMiddle({
    Key? key,
    required this.listDays,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    return CommonTopWidgetMiddle(
      text: text,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: listDays.length,
          itemBuilder: (context, index) {
            DayModel dm = listDays[index];
            return Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(MdiIcons.calendarToday, color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Day plan (${days[dm.dayIndex]})",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
