import 'dart:developer';

import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:get/get.dart';
import 'package:mesbah/component/colors.dart';
import 'package:mesbah/controller/student_info_controller.dart';
import 'package:mesbah/controller/student_list_controller.dart';
import '../component/component.dart';
import '../component/strings.dart';

// ignore: must_be_immutable
class ListStudentScreen extends StatefulWidget {
  ListStudentScreen(
      {super.key,
      required this.selectedCategoryId,
      required this.selectedCategoryName});
  String? selectedCategoryId;
  String? selectedCategoryName;

  @override
  State<ListStudentScreen> createState() => _ListStudentScreenState();
}

class _ListStudentScreenState extends State<ListStudentScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController schoolController = TextEditingController();
  TextEditingController fatherNameController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController nationalCodeController = TextEditingController();
  int gradeIdController = 0;

  StudentListController studentListController =
      Get.find<StudentListController>();
  StudentInfoController studentInfoController =
      Get.put(StudentInfoController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: ColorWith.primaryColor,
          onPressed: () {
            _showBottomSheetAddMember(false);
          },
          child: const Icon(Icons.add),
        ),
        appBar: EasySearchBar(
          title: Text(
            "${FromStrings.studentList} ${widget.selectedCategoryName!}",
            style: textTheme.headlineLarge,
          ),
          actions: const [],
          onSearch: (value) => debugPrint("پرینــت"),
        ),
        body: Obx(
          () => studentListController.isLoading.value
              ? loading()
              : ListView.builder(
                  itemCount: studentListController.studentList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
                      child: Container(
                        decoration: BoxDecoration(
                            // color:const Color.fromARGB(94, 4, 8, 207),
                            border: Border.all(color: Colors.black),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50))),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Text(
                                "${studentListController.studentList[index].firstName!} ${studentListController.studentList[index].lastName!}",
                                style: textTheme.headlineLarge,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  FromStrings.pu,
                                  style: textTheme.headlineSmall,
                                ),
                                SizedBox(
                                  width: 50,
                                  child: CupertinoSpinBox(
                                    onSubmitted: (value) {
                                      studentInfoController
                                          .updatePresenceMember(
                                              studentListController
                                                  .studentList[index].id!,
                                              value.toInt());
                                    },
                                    textStyle: textTheme.headlineMedium,
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                    spacing: 0,
                                    min: 0,
                                    max: 50,
                                    direction: Axis.vertical,
                                    value: studentListController
                                        .studentList[index].presence!
                                        .toDouble(),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  FromStrings.score,
                                  style: textTheme.headlineSmall,
                                ),
                                SizedBox(
                                  width: 50,
                                  child: CupertinoSpinBox(
                                    onSubmitted: (value) {
                                      studentInfoController.updateScoreMember(
                                          studentListController
                                              .studentList[index].id!,
                                          value.toInt());
                                    },
                                    textStyle: textTheme.headlineMedium,
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                    spacing: 0,
                                    min: -50,
                                    max: 999,
                                    step: 5,
                                    direction: Axis.vertical,
                                    value: studentListController
                                        .studentList[index].score!
                                        .toDouble(),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      color: Get.theme.primaryColor,
                                      onPressed: () {
                                        firstNameController.text =
                                            studentListController
                                                .studentList[index].firstName!;
                                        lastNameController.text =
                                            studentListController
                                                .studentList[index].lastName!;
                                        fatherNameController.text =
                                            studentListController
                                                .studentList[index].fatherName!;
                                        birthdayController.text =
                                            studentListController
                                                .studentList[index].birthday!;
                                        schoolController.text =
                                            studentListController
                                                .studentList[index].school!;
                                        nationalCodeController.text =
                                            studentListController
                                                .studentList[index]
                                                .nationalCode!;
                                        phoneNumberController.text =
                                            studentListController
                                                .studentList[index]
                                                .mobilePhone!;
                                        gradeIdController =
                                            studentListController
                                                .studentList[index].grade!;
                                        _showBottomSheetAddMember(true,
                                            id: studentListController
                                                .studentList[index].id!);
                                      },
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: () async {
                                        log(index.toString());
                                        await studentInfoController
                                            .deleteMemberFromClass(
                                                studentListController
                                                    .studentList[index].id!);
                                        studentListController
                                            .getStudentListByCat(
                                                widget.selectedCategoryId!);
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }

  _showBottomSheetAddMember(bool isEditMode, {String? id}) {
    int selectedGradeId = isEditMode ? gradeIdController : 0;
    String selectedGradeName =
        studentListController.classGradeList[selectedGradeId].gradeName!;
    String selectedCategoryName = widget.selectedCategoryName!;
    String? selectedCategoryId =
        studentListController.getIdOfCategories(selectedCategoryName);

    var textTheme = Get.textTheme;
    Get.bottomSheet(studentInfoController.isLoading.value
        ? loading()
        : Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    isEditMode ? 'ویرایش مشخصات عضو' : 'اضافه کردن عضو',
                    style: textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 16.0),
                  Obx(
                    () => DropdownButtonFormField<String>(
                      value: selectedCategoryName,
                      items: studentListController.classCategoriesList
                          .map((classCat) => DropdownMenuItem(
                                value: classCat.cateName,
                                child: Text(
                                  classCat.cateName!,
                                  style: textTheme.headlineMedium,
                                ),
                              ))
                          .toList(),
                      decoration: InputDecoration(
                        labelText: '‌حلقه‌ی قرآنی',
                        labelStyle: textTheme.headlineMedium,
                        border: const OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        selectedCategoryName = value!;
                        selectedCategoryId = studentListController
                            .getIdOfCategories(selectedCategoryName);
                      },
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    style: textTheme.headlineMedium,
                    controller: firstNameController,
                    decoration: InputDecoration(
                      labelText: 'نام',
                      labelStyle: textTheme.headlineMedium,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    style: textTheme.headlineMedium,
                    controller: lastNameController,
                    decoration: InputDecoration(
                      labelText: 'نام خانوادگی',
                      labelStyle: textTheme.headlineMedium,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    style: textTheme.headlineMedium,
                    controller: fatherNameController,
                    decoration: InputDecoration(
                      labelText: 'نام پدر',
                      labelStyle: textTheme.headlineMedium,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    style: textTheme.headlineMedium,
                    controller: birthdayController,
                    decoration: InputDecoration(
                      labelText: 'تاریخ تولد',
                      labelStyle: textTheme.headlineMedium,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 8.0),



                  TextFormField(
                    style: textTheme.headlineMedium,
                    controller: schoolController,
                    decoration: InputDecoration(
                      labelStyle: textTheme.headlineMedium,
                      labelText: 'مدرسه',
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  DropdownButtonFormField<String>(
                    value: selectedGradeName,
                    items: studentListController.classGradeList //
                        .map((grade) => DropdownMenuItem(
                              value: grade.gradeName,
                              child: Text(
                                grade.gradeName!,
                                style: textTheme.headlineMedium,
                              ),
                            ))
                        .toList(),
                    decoration: InputDecoration(
                      labelStyle: textTheme.headlineMedium,
                      labelText: 'کلاس',
                      border: const OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      selectedGradeId = studentListController.classGradeList
                          .indexWhere(
                              (category) => category.gradeName == value);
                    },
                  ),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    style: textTheme.headlineMedium,
                    controller: phoneNumberController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelStyle: textTheme.headlineMedium,
                      labelText: 'تلفن همراه',
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    style: textTheme.headlineMedium,
                    controller: nationalCodeController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelStyle: textTheme.headlineMedium,
                      labelText: 'کد ملی',
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () async {
                      studentInfoController.singleStudentInfo.update((val) {
                        val!.classCatId = selectedCategoryId;
                        val.firstName = firstNameController.text;
                        val.lastName = lastNameController.text;
                        val.fatherName = fatherNameController.text;
                        val.birthday = birthdayController.text;
                        val.grade = selectedGradeId;
                        val.school = schoolController.text;
                        val.mobilePhone = phoneNumberController.text;
                        val.nationalCode = nationalCodeController.text;
                        val.score = 0;// on edit mode 
                        val.presence = 0;// on edit mode 
                      });
                      Navigator.pop(context);
                      if (!isEditMode) {
                        await studentInfoController.addNewMemberToClass();
                      } else {
                        await studentInfoController.updateMemberOfClass(id!);
                      }
                      studentListController
                          .getStudentListByCat(widget.selectedCategoryId!);
                    },
                    child: Text(
                      'ذخیره',
                      style: textTheme.headlineLarge,
                    ),
                  ),
                ],
              ),
            ),
          ));
  }
}
