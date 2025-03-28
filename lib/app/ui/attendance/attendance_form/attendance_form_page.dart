import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/common/widgets/page_layout.dart';
import 'package:sunday_school_attendance/app/ui/attendance/attendance_form/attendance_form_controller.dart';

class AttendanceFormPage extends GetView<AttendanceFormController> {
  const AttendanceFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      backInvoked: Get.back,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return Form(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: [
              TextFormField(
                controller: controller.nameController,
                decoration: const InputDecoration(labelText: 'Nama Murid'),
                validator: (value) =>
                    value!.isEmpty ? 'Nama murid wajib diisi' : null,
              ),
              //
              const SizedBox(height: 24.0),
              //
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.saveAttendance,
                  child: const Text('Simpan'),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
