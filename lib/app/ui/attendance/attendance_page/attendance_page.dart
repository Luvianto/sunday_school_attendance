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
              child: CustomCalendar(
                firstDay: controller.firstDay,
                lastDay: controller.lastDay,
                focusedDay: controller.focusedDay.value,
                selectedDay: controller.selectedDay.value,
                onDaySelected: controller.onDaySelected,
                onPageChanged: controller.onPageChanged,
              ),
            ),
          ),
          Divider(),
          const SizedBox(height: 8.0),
          Obx(() {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                controller.formattedDate.value,
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
                child: Center(
                  child: Text(
                    controller.errorMessage.value,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: controller.attendanceList
                    .map((attendance) => CustomCard(
                          title: 'Judul Attendance',
                          subtitle: DateFormat.Hms()
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

class CustomCalendar extends StatelessWidget {
  final DateTime firstDay;
  final DateTime lastDay;
  final DateTime focusedDay;
  final DateTime selectedDay;
  final void Function(DateTime, DateTime)? onDaySelected;
  final void Function(DateTime)? onPageChanged;
  const CustomCalendar({
    super.key,
    required this.firstDay,
    required this.lastDay,
    required this.focusedDay,
    required this.selectedDay,
    this.onDaySelected,
    this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: 'id_ID',
      firstDay: firstDay,
      lastDay: lastDay,
      startingDayOfWeek: StartingDayOfWeek.monday,
      focusedDay: focusedDay,
      rangeSelectionMode: RangeSelectionMode.disabled,
      selectedDayPredicate: (day) {
        return isSameDay(selectedDay, day);
      },
      onDaySelected: onDaySelected,
      headerStyle: HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
        titleTextFormatter: (date, locale) =>
            DateFormat.MMMM(locale).format(date),
      ),
      onPageChanged: onPageChanged,
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
    );
  }
}
