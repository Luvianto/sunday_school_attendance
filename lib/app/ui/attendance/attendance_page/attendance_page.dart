import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sunday_school_attendance/app/common/widgets/custom_card.dart';
import 'package:sunday_school_attendance/app/ui/attendance/attendance_page/attendance_controller.dart';
import 'package:table_calendar/table_calendar.dart';

class AttendancePage extends GetView<AttendanceController> {
  const AttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: controller.refreshPage,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          Obx(
            () => SizedBox(
              height: 400,
              child: TableCalendar(
                locale: 'id_ID',
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
                  titleTextFormatter: (date, locale) =>
                      DateFormat.MMMM(locale).format(date),
                ),
                onPageChanged: controller.onPagesChanged,
                calendarBuilders: CalendarBuilders(
                  dowBuilder: (context, day) {
                    final text = DateFormat.E('id_ID').format(day);
                    if (day.weekday == DateTime.sunday) {
                      return Center(
                        child: Text(
                          text,
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    } else {
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
          ),
          Divider(),
          const SizedBox(height: 8.0),
          Obx(() {
            final selectedDay = controller.selectedDay.value;
            final day = DateFormat.d('id_ID').format(selectedDay);
            final weekday = DateFormat.EEEE('id_ID').format(selectedDay);
            final month = DateFormat.MMMM('id_ID').format(selectedDay);
            final year = DateFormat.y('id_ID').format(selectedDay);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "$weekday, $day $month $year",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            );
          }),
          const SizedBox(height: 8.0),
          Obx(() {
            if (controller.attendanceList.isEmpty) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                child: const Center(
                  child: Text('Belum ada absensi!'),
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: controller.attendanceList
                    .map((attendance) => CustomCard(
                          title: DateFormat.Hms()
                              .format(attendance.timestamp.toDate()),
                          onTap: () => controller.toDetail(attendance),
                        ))
                    .toList(),
              ),
            );
          }),
        ],
      ),
    );
  }
}
