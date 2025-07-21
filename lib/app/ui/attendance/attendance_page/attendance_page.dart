import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sunday_school_attendance/app/common/widgets/custom_card.dart';
import 'package:sunday_school_attendance/app/common/widgets/custom_loading.dart';
import 'package:sunday_school_attendance/app/ui/attendance/attendance_page/attendance_controller.dart';
import 'package:table_calendar/table_calendar.dart';

class AttendancePage extends GetView<AttendanceController> {
  const AttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: controller.refreshPage,
      child: Stack(
        children: [
          Obx(() {
            return ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                SizedBox(
                  height: 400,
                  child: TableCalendar(
                    firstDay: controller.firstDay,
                    lastDay: controller.lastDay,
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    focusedDay: controller.focusedDay.value,
                    rangeSelectionMode: RangeSelectionMode.disabled,
                    selectedDayPredicate: (day) {
                      return isSameDay(controller.selectedDay.value, day);
                    },
                    onDaySelected: controller.setSelectedDay,
                    headerStyle: HeaderStyle(
                      titleCentered: true,
                      formatButtonVisible: false,
                    ),
                    onPageChanged: controller.onPagesChanged,
                    calendarBuilders: CalendarBuilders(
                      dowBuilder: (context, day) {
                        if (day.weekday == DateTime.sunday) {
                          final text = DateFormat.E().format(day);
                          return Center(
                            child: Text(
                              text,
                              style: TextStyle(color: Colors.red),
                            ),
                          );
                        } else {
                          final text = DateFormat.E().format(day);
                          return Center(
                            child: Text(
                              text,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
                Divider(),
                ...controller.attendanceList.map(
                  (attendance) => CustomCard(
                    title: 'Berkah Rohani',
                    subtitle:
                        DateFormat.Hms().format(attendance.timestamp.toDate()),
                    onTap: () => controller.toDetail(attendance),
                  ),
                ),
              ],
            );
          }),
          Obx(() {
            if (controller.isLoading.value) {
              return CustomLoading();
            }
            return Center(
              child: Text(
                controller.errorMessage.value,
                textAlign: TextAlign.center,
              ),
            );
          })
        ],
      ),
    );
  }
}
