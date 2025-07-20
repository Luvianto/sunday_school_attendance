import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sunday_school_attendance/app/models/student_model.dart';
import 'package:sunday_school_attendance/app/services/student_service.dart';

class StudentFormController extends GetxController {
  File? image;
  String? base64Image;
  final ImagePicker picker = ImagePicker();

  final studentService = StudentService();

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  StudentModel? student;

  @override
  void onInit() {
    super.onInit();
    final argument = Get.arguments;
    if (argument is StudentModel) {
      student = argument;
      nameController.text = student!.name;
    }
  }

  void saveStudents() async {
    if (isLoading.value) return;
    if (!formKey.currentState!.validate()) return;
    isLoading.value = true;

    final newStudent = StudentModel(
      id: student?.id,
      name: nameController.text.trim(),
      status: true,
      profilePicture: base64Image,
    );

    final result = student?.id != null
        ? await studentService.updateStudent(newStudent)
        : await studentService.addStudent(newStudent);
    if (result.isSuccess) {
      Get.back(result: true);
    }
    if (result.isError) {
      errorMessage.value = result.message!;
      Get.snackbar('Error', result.message!,
          snackPosition: SnackPosition.BOTTOM);
    }

    isLoading.value = false;
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        image = File(pickedFile.path);

        await compressAndEncodeImage();
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> compressAndEncodeImage() async {
    if (image == null) return;
    try {
      final compressedImage = await FlutterImageCompress.compressWithFile(
        image!.path,
        quality: 50,
      );
      if (compressedImage == null) return;

      base64Image = base64Encode(compressedImage);
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }
}
