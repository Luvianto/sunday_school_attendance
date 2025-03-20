import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/common/widgets/page_layout.dart';
import 'package:sunday_school_attendance/app/pages/session_form/session_form_controller.dart';

class SessionFormPage extends GetView<SessionFormController> {
  const SessionFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      title: controller.session == null ? 'Sesi Baru' : 'Edit Sesi',
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }
          return Form(
            key: controller.formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                TextFormField(
                  controller: controller.nameController,
                  decoration: const InputDecoration(labelText: 'Nama Sesi'),
                  validator: (value) =>
                      value!.isEmpty ? 'Nama sesi wajib diisi' : null,
                ),
                //
                const SizedBox(height: 8.0),
                //
                TextFormField(
                  readOnly: true,
                  controller: controller.startTimeController,
                  decoration: const InputDecoration(labelText: 'Sesi dimulai'),
                  onTap: controller.selectStartTime,
                  validator: (value) =>
                      value!.isEmpty ? 'Sesi dimulai wajib diisi' : null,
                ),
                //
                const SizedBox(height: 8.0),
                //
                TextFormField(
                  readOnly: true,
                  controller: controller.endTimeController,
                  decoration: const InputDecoration(labelText: 'Sesi Berakhir'),
                  onTap: controller.selectEndTime,
                  validator: (value) =>
                      value!.isEmpty ? 'Sesi Berakhir wajib diisi' : null,
                ),
                //
                const SizedBox(height: 24.0),
                //
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.saveSession,
                    child: const Text('Simpan'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
