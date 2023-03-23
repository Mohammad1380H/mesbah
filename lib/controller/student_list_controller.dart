import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mesbah/models/class_categories_model.dart';
import 'package:mesbah/models/class_grade_model.dart';
import '../data.dart';
import '../models/student_model.dart';

class StudentListController extends GetxController {
  RxList<StudentModel> studentList = RxList();
  RxList<ClassCategoriesModel> classCategoriesList = RxList();
  RxList<ClassGradeModel> classGradeList = RxList();
  RxBool isLoading = false.obs;
  @override
  onInit() {
    super.onInit();
    getClassesCats();
    getGrades();
    debugPrint("اتصال لیست دانش آموزان");
  }

  int getIdOfCategories(String catName_) {
    for (int i = 0; i < classCategoriesList.length; i++) {
      if (classCategoriesList[i].cateName == catName_) {
        return classCategoriesList[i].id;
      }
    }
    return -1;
  }

  getClassesCats() {
    classCategoriesList.clear();
    for (int i = 0; i < classCatOptionsFake.length; i++) {
      classCategoriesList
          .add(ClassCategoriesModel(id: i, cateName: classCatOptionsFake[i]));
      log(classCategoriesList[i].cateName!);
    }
    log('getClassesCats');
  }

  getGrades() {
    classGradeList.clear();
    for (int i = 0; i < gradeOptionsFake.length; i++) {
      classGradeList
          .add(ClassGradeModel(id: i, gradeName: gradeOptionsFake[i]));
    }
    log('getGrades');
  }

  getStudentListByCat(int id) {
    studentList.clear();

    for (int i = 0; i < studentsFake.length; i++) {
      log("${studentsFake[i].id}}}}");
      if (studentsFake[i].classCatId == id) {
        studentList.add(studentsFake[i]);
      }
    }

    log('getStudentListByCat');
  }

  addNewCategory(String? text) {
    classCatOptionsFake.add(text!);
  }
}
