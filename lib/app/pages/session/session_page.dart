import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/common/widgets/page_layout.dart';
import 'package:sunday_school_attendance/app/common/util/convert_time_of_day.dart';
import 'package:sunday_school_attendance/app/common/widgets/custom_card.dart';
import 'package:sunday_school_attendance/app/pages/session/session_controller.dart';

class SessionPage extends GetView<SessionController> {
  const SessionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      title: 'Absensi',
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }
          if (controller.errorMessage.isNotEmpty) {
            return Center(child: Text(controller.errorMessage.value));
          }
          if (controller.sessionList.isEmpty) {
            return Center(child: Text("Belum ada data!"));
          }
          return RefreshIndicator(
            onRefresh: controller.refreshPage,
            child: ListView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              children: controller.sessionList.map(
                (session) {
                  return CustomCard(
                    title: session.name,
                    subtitle:
                        '${ConvertTimeOfDay.toHourMinutePeriod(session.startTime)} - ${ConvertTimeOfDay.toHourMinutePeriod(session.endTime)}',
                    onTap: () => controller.toDetail(session),
                  );
                },
              ).toList(),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.openForm,
        child: Icon(Icons.add),
      ),
    );
  }
}
