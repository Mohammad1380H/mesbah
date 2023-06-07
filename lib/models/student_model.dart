class StudentModel {
  String? id;
  String? firstName;
  String? lastName;
  String? fatherName;
  String? birthday;
  int? grade;
  String? school;
  String? nationalCode;
  String? mobilePhone;
  String? classCatId;
  int? score;
  int? presence;
  StudentModel();
  StudentModel.fromApp({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.fatherName,
    required this.birthday,
    required this.grade,
    required this.school,
    required this.nationalCode,
    required this.mobilePhone,
    required this.score,
    required this.presence,
    required this.classCatId,
  });
}
