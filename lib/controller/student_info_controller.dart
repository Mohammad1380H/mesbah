import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mesbah/data.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import '../models/student_model.dart';

class StudentInfoController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<StudentModel> singleStudentInfo = StudentModel().obs;
  @override
  onInit() {
    super.onInit();
    debugPrint("اتصال اطلاعات دانش آموزان");
  }

  addNewMemberToClass() async {
    isLoading.value = true;
    final newMember = ParseObject('users')
      ..set('firstName', singleStudentInfo.value.firstName)
      ..set('lastName', singleStudentInfo.value.lastName)
      ..set('fatherName', singleStudentInfo.value.fatherName)
      ..set('birthday', singleStudentInfo.value.birthday)
      ..set('gradeId', singleStudentInfo.value.grade)
      ..set('school', singleStudentInfo.value.school)
      ..set('nationalCode', singleStudentInfo.value.nationalCode)
      ..set('mobilePhone', singleStudentInfo.value.mobilePhone)
      ..set('categoryId', singleStudentInfo.value.classCatId)
      ..set('presence', singleStudentInfo.value.presence)
      ..set('score', singleStudentInfo.value.score);
    await newMember.save();

    isLoading.value = false;
    // studentsFake.add(StudentModel.fromApp(
    //   firstName: singleStudentInfo.value.firstName,
    //   lastName: singleStudentInfo.value.lastName,
    //   grade: singleStudentInfo.value.grade,
    //   school: singleStudentInfo.value.school,
    //   nationalCode: singleStudentInfo.value.nationalCode,
    //   mobilePhone: singleStudentInfo.value.mobilePhone,
    //   score: singleStudentInfo.value.score,
    //   presence: singleStudentInfo.value.presence,
    //   classCatId: singleStudentInfo.value.classCatId,
    //   id: singleStudentInfo.value.id,
    // ));
  }

  updateMemberOfClass(String id) async {
    isLoading.value = true;
    final newMember = ParseObject('users')
      ..objectId = id
      ..set('firstName', singleStudentInfo.value.firstName)
      ..set('lastName', singleStudentInfo.value.lastName)
      ..set('fatherName', singleStudentInfo.value.fatherName)
      ..set('birthday', singleStudentInfo.value.birthday)
      ..set('gradeId', singleStudentInfo.value.grade)
      ..set('school', singleStudentInfo.value.school)
      ..set('nationalCode', singleStudentInfo.value.nationalCode)
      ..set('mobilePhone', singleStudentInfo.value.mobilePhone)
      ..set('categoryId', singleStudentInfo.value.classCatId);
    await newMember.save();

    isLoading.value = false;
  }

  updatePresenceMember(String id, int presence_) async {
    var todo = ParseObject('users')
      ..objectId = id
      ..set('presence', presence_);
    await todo.save();
  }

  updateScoreMember(String id, int score_) async {
    var todo = ParseObject('users')
      ..objectId = id
      ..set('score', score_);
    await todo.save();
  }

  deleteMemberFromClass(String? id) async {
    var todo = ParseObject('users')..objectId = id;
    await todo.delete();
  }
}
