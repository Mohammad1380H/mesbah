import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mesbah/data.dart';
import '../models/student_model.dart';

class StudentInfoController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<StudentModel> singleStudentInfo = StudentModel().obs;
  @override
  onInit() {
    super.onInit();
    debugPrint("اتصال اطلاعات دانش آموزان");
  }

  addNewMemberToClass() {
    studentsFake.add(StudentModel.fromApp(
      firstName: singleStudentInfo.value.firstName,
      lastName: singleStudentInfo.value.lastName,
      grade: singleStudentInfo.value.grade,
      school: singleStudentInfo.value.school,
      nationalCode: singleStudentInfo.value.nationalCode,
      mobilePhone: singleStudentInfo.value.mobilePhone,
      score: singleStudentInfo.value.score,
      presence: singleStudentInfo.value.presence,
      classCatId: singleStudentInfo.value.classCatId,
      id: singleStudentInfo.value.id,
    ));
  }

  updateMemberOfClass(int id) {
    for (int i = 0; i < studentsFake.length; i++) {
      if (studentsFake[i].id == id) {
        var temp = studentsFake[i];
        temp.firstName = singleStudentInfo.value.firstName;
        temp.lastName = singleStudentInfo.value.lastName;
        temp.grade = singleStudentInfo.value.grade;
        temp.school = singleStudentInfo.value.school;
        temp.nationalCode = singleStudentInfo.value.nationalCode;
        temp.mobilePhone = singleStudentInfo.value.mobilePhone;
        temp.classCatId = singleStudentInfo.value.classCatId;
        
      }
    }
  }

  updatePresenceMember(int id, int presence_) {
    for (int i = 0; i < studentsFake.length; i++) {
      if (studentsFake[i].id == id) {
        var temp = studentsFake[i];
        temp.presence = presence_;
      }
    }
  }
  updateScoreMember(int id, int score_) {
    for (int i = 0; i < studentsFake.length; i++) {
      if (studentsFake[i].id == id) {
        var temp = studentsFake[i];
        temp.score = score_;
      }
    }
  }

  deleteMemberFromClass(int id) {
    for (int i = 0; i < studentsFake.length; i++) {
      if (studentsFake[i].id == id) {
        studentsFake.removeAt(i);
      }
    }
  }
}
