import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sunday_school_attendance/app/common/util/input_validator.dart';
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
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                CustomLabel(label: 'Nama Panjang'),
                CustomTextFormField(
                  hintText: 'Nama Panjang',
                  controller: controller.nameController,
                  validator: emptyValidator,
                ),
                //
                SizedBox(height: 16.0),
                //
                ElevatedButton(
                  onPressed: () {
                    controller.pickImage(ImageSource.gallery);
                  },
                  child: Text('Ambil Foto dari Galeri'),
                ),
                //
                const SizedBox(height: 24.0),
                //
                controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : CustomButton(
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
