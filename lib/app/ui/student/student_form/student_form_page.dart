import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/common/utilities/input_validator.dart';
import 'package:sunday_school_attendance/app/common/widgets/custom_button.dart';
import 'package:sunday_school_attendance/app/common/widgets/custom_label.dart';
import 'package:sunday_school_attendance/app/common/widgets/custom_text_form_field.dart';
import 'package:sunday_school_attendance/app/common/widgets/page_layout.dart';
import 'package:sunday_school_attendance/app/ui/student/student_form/student_form_controller.dart';

class StudentFormPage extends GetView<StudentFormController> {
  const StudentFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      backInvoked: Get.back,
      title: 'Murid Baru',
      body: Form(
        key: controller.formKey,
        child: Obx(
          () {
            final length = controller.nameControllers.length;
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                ...[
                  for (int i = 0; i < length; i++) ...[
                    CustomLabel(label: 'Murid ke-${i + 1}'),
                    CustomTextFormField(
                      hintText: 'Nama murid',
                      controller: controller.nameControllers[i],
                      validator: emptyValidator,
                    ),
                    const SizedBox(height: 16.0),
                  ],
                ],
                //
                const SizedBox(height: 8.0),
                //
                ElevatedButton(
                  onPressed: controller.addNameField,
                  child: Icon(Icons.add),
                ),
                //
                const SizedBox(height: 24.0),
                //
                CustomButton(
                  onPressed: controller.saveStudents,
                  label: 'Simpan',
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
