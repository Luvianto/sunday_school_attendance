import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/common/widgets/custom_button.dart';
import 'package:sunday_school_attendance/app/common/widgets/custom_loading.dart';
import 'package:sunday_school_attendance/app/common/widgets/custom_text_form_field.dart';
import 'package:sunday_school_attendance/app/common/widgets/page_layout.dart';
import 'package:sunday_school_attendance/app/ui/student/student_edit/student_edit_controller.dart';

class StudentEditPage extends GetView<StudentEditController> {
  const StudentEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      backInvoked: Get.back,
      title: 'Edit Murid',
      body: Form(
        key: controller.formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: [
            CustomTextFormField(
              hintText: 'Nama murid',
              controller: controller.nameController,
            ),
            const SizedBox(height: 8.0),
            Obx(
              () => !controller.isLoading.value
                  ? CustomButton(
                      label: 'Simpan',
                      onPressed: controller.editStudent,
                    )
                  : CustomLoading(),
            ),
          ],
        ),
      ),
    );
  }
}
