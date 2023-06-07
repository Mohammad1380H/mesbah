import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mesbah/models/class_categories_model.dart';
import 'package:mesbah/models/class_grade_model.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import '../data.dart';
import '../models/student_model.dart';

class StudentListController extends GetxController {
  RxList<StudentModel> studentList = RxList();
  RxString posterUrl = ' '.obs;
  RxList<ClassCategoriesModel> classCategoriesList = RxList();
  RxList<ClassGradeModel> classGradeList = RxList();
  RxBool isLoading = false.obs;
  @override
  onInit() {
    super.onInit();
    getClassesCats();
    getGrades();
    getPosterUrl();
    debugPrint("اتصال لیست دانش آموزان");
  }

  getPosterUrl() async {
    isLoading.value = true;
    QueryBuilder<ParseObject> queryCategories =
        QueryBuilder<ParseObject>(ParseObject('Poster'));
    final ParseResponse apiResponse = await queryCategories.query();

    if (apiResponse.success && apiResponse.results != null) {
      List<ParseObject> resultList = apiResponse.results as List<ParseObject>;
      for (int i = 0; i < resultList.length; i++) {
        final varCtegories = resultList[i];
        final posterUrl_ = varCtegories.get<String>('imageUrl')!;
        posterUrl.value = posterUrl_;

      }
    }

    isLoading.value = false;
    log('get poster');
  }

///////////////////////////
  String? getIdOfCategories(String catName_) {
    for (int i = 0; i < classCategoriesList.length; i++) {
      if (classCategoriesList[i].cateName == catName_) {
        return classCategoriesList[i].id;
      }
    }
    return "-1";
  }

////////////////////////////////
  getClassesCats() async {
    classCategoriesList.clear();
    isLoading.value = true;
    QueryBuilder<ParseObject> queryCategories =
        QueryBuilder<ParseObject>(ParseObject('categories'));
    final ParseResponse apiResponse = await queryCategories.query();

    if (apiResponse.success && apiResponse.results != null) {
      List<ParseObject> resultList = apiResponse.results as List<ParseObject>;
      for (int i = 0; i < resultList.length; i++) {
        final varCtegories = resultList[i];
        final categoryName = varCtegories.get<String>('categoryName')!;
        final categoryId = varCtegories.get<String>('objectId')!;
        log("$categoryId${categoryName}dddd");
        classCategoriesList
            .add(ClassCategoriesModel(id: categoryId, cateName: categoryName));
        log(classCategoriesList[i].cateName!);
      }
    }
    isLoading.value = false;
    log('getClassesCats');
  }

//////////////////////////////
  getGrades() {
    classGradeList.clear();
    for (int i = 0; i < gradeOptionsFake.length; i++) {
      classGradeList
          .add(ClassGradeModel(id: i, gradeName: gradeOptionsFake[i]));
    }
    log('getGrades');
  }

////////////////////////////////////
  getStudentListByCat(String id) async {
    studentList.clear();
    isLoading.value = true;
    QueryBuilder<ParseObject> queryCategories =
        QueryBuilder<ParseObject>(ParseObject('users'))
          ..whereEqualTo('categoryId', id);
    final ParseResponse apiResponse = await queryCategories.query();
    if (apiResponse.success && apiResponse.results != null) {
      List<ParseObject> resultList = apiResponse.results as List<ParseObject>;
      for (int i = 0; i < resultList.length; i++) {
        final varCtegories = resultList[i];
        final classCatId = varCtegories.get<String>('categoryId')!;
        final firstName = varCtegories.get<String>('firstName')!;
        final fatherName = varCtegories.get<String>('fatherName')!;
        final birthday = varCtegories.get<String>('birthday')!;
        final grade = varCtegories.get<int>('gradeId')!;
        final id = varCtegories.get<String>('objectId')!;
        final lastName = varCtegories.get<String>('lastName')!;
        final mobilePhone = varCtegories.get<String>('mobilePhone')!;
        final nationalCode = varCtegories.get<String>('nationalCode')!;
        final presence = varCtegories.get<int>('presence')!;
        final school = varCtegories.get<String>('school')!;
        final score = varCtegories.get<int>('score')!;
        studentList.add(StudentModel.fromApp(
            classCatId: classCatId,
            firstName: firstName,
            grade: grade,
            id: id,
            lastName: lastName,
            mobilePhone: mobilePhone,
            nationalCode: nationalCode,
            presence: presence,
            school: school,
            score: score,
            birthday: birthday,
            fatherName: fatherName));
      }
    }
    isLoading.value = false;
    log('getStudentListByCat');
  }

///////////////////////////////
  addNewCategory(String? text) async {
    isLoading.value = true;
    final newMember = ParseObject('categories')..set('categoryName', text);
    await newMember.save();
    isLoading.value = false;
  }
}
