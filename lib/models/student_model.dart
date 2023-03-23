class StudentModel {
  int? id;
  String? firstName;
  String? lastName;
  int? grade;
  String? school;
  String? nationalCode;
  String? mobilePhone;
  int? classCatId;
  int? score;
  int? presence;
  StudentModel();
  StudentModel.fromApp({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.grade,
    required this.school,
    required this.nationalCode,
    required this.mobilePhone,
    required this.score,
    required this.presence,
    required this.classCatId,
  });
}
