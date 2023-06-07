import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:mesbah/component/strings.dart';
import 'package:mesbah/controller/student_list_controller.dart';
import 'package:mesbah/view/todo_list_screen.dart';
import '../component/component.dart';
import '../data.dart';
import '../gen/assets.gen.dart';
import 'list_student_screen.dart';

class MainScreen extends StatefulWidget {
  final Function toggleTheme;

  const MainScreen({super.key, required this.toggleTheme});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  StudentListController studentListController =
      Get.put(StudentListController());

  bool isDarkMode = false;
  TextEditingController newClassNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: drawerApp(context),
        appBar: appBarApp(context),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            posterApp(),
            Obx(() => studentListController.isLoading.value
                ? Column(children: [
                    const SizedBox(
                      height: 100,
                    ),
                    loading()
                  ])
                : listViewApp())
          ],
        ),
      ),
    );
  }

  Expanded listViewApp() {
    return Expanded(
      child: ListView.builder(
        itemCount: itemsFake.length,
        itemBuilder: (context, index) {
          final item = itemsFake[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
                title: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item.name,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                )),
                subtitle: Center(
                    child: Text(
                  item.description,
                  style: Theme.of(context).textTheme.headlineSmall,
                )),
                onTap: () {
                  if (index == 0) {
                    _showButtomSheetChooseClass();
                  } else if (index == 1) {
                    _showButtomSheetAddClass();
                  } else if (index == 2) {
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ToDoListScreen()),
                    );
                  }
                }),
          );
        },
      ),
    );
  }

  Obx posterApp() {
    return Obx(
      () => Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image:
                          NetworkImage(studentListController.posterUrl.value))),
            ),
    );
  }

  AppBar appBarApp(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      title: SizedBox(
        width: double.infinity,
        height: 30,
        child: Marquee(
          text: 'سامانه‌ی مدیریت کانون فرهنگی هنری مسجد جامع',
          style: Theme.of(context).textTheme.headlineLarge,
          scrollAxis: Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.start,
          blankSpace: 20.0,
          velocity: 100.0,
          pauseAfterRound: const Duration(seconds: 2),
          startPadding: 10.0,
          accelerationDuration: const Duration(seconds: 2),
          accelerationCurve: Curves.linear,
          decelerationDuration: const Duration(milliseconds: 500),
          decelerationCurve: Curves.easeOut,
        ),
      ),
      actions: [
        IconButton(
            onPressed: () {
              widget.toggleTheme();
              setState(() {
                isDarkMode = (!isDarkMode);
              });
            },
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode)),
        const SizedBox(
          width: 15,
        ),
      ],
    );
  }

  Drawer drawerApp(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(children: [
          const SizedBox(
            height: 20,
          ),
          ListTile(
            title: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  FromStrings.contactUs,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const Icon(
                  Icons.contact_mail,
                  size: 40,
                )
              ],
            )),
            onTap: () {
              launchUrl_("https://denabourse.ir");
            },
          ),
          ListTile(
            title: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  FromStrings.aboutUs,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const Icon(
                  Icons.info,
                  size: 40,
                )
              ],
            )),
            onTap: () {
              showAlertDialog(context);
            },
          ),
          ListTile(
            title: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  FromStrings.exit,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const Icon(
                  Icons.exit_to_app,
                  size: 40,
                )
              ],
            )),
            onTap: () {
              exit(0);
            },
          ),
        ]),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = ElevatedButton(
      child: Text(
        "خوندم",
        style: Theme.of(context).textTheme.headlineLarge,
      ),
      onPressed: () {
        Navigator.of(context).pop(); // بستن popup
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        FromStrings.aboutUs,
        style: Theme.of(context).textTheme.headlineLarge,
      ),
      content: SizedBox(
        height: MediaQuery.of(context).size.height / 4,
        child: Column(
          children: [
            Text(
              FromStrings.contentAboutUs,
              style: Theme.of(context).textTheme.headlineLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _showButtomSheetChooseClass() {
    var textTheme = Get.textTheme;
    var firstItem = studentListController.classCategoriesList[0];
    String selectedCategoryId = firstItem.id!;
    String selectedCategoryName = firstItem.cateName!;

    Get.bottomSheet(Container(
      height: Get.height / 3,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
        child: Column(children: [
          Text(
            "لطفاً کلاس مورد نظر را انتخاب کنید:",
            style: textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 15,
          ),
          DropdownButtonFormField<String>(
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
                  .getIdOfCategories(selectedCategoryName)!;
              log("${selectedCategoryId}selectedIndex");
            },
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                studentListController.getStudentListByCat(selectedCategoryId);
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListStudentScreen(
                            selectedCategoryId: selectedCategoryId,
                            selectedCategoryName: selectedCategoryName,
                          )),
                );
              },
              child: Text(
                "ورود",
                style: textTheme.headlineLarge,
              ))
        ]),
      ),
    ));
  }

  _showButtomSheetAddClass() {
    var textTheme = Get.textTheme;
    Get.bottomSheet(Container(
      height: Get.height / 3,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(children: [
          Text(
            "لطفاً نام حلقه را وارد کنید:",
            style: textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            style: textTheme.headlineMedium,
            controller: newClassNameController,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              labelStyle: textTheme.headlineMedium,
              labelText: 'نام حلقه',
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                studentListController
                    .addNewCategory(newClassNameController.text);
                studentListController.getClassesCats();
                Navigator.pop(context);
              },
              child: Text(
                "ایجاد حلقه",
                style: textTheme.headlineLarge,
              ))
        ]),
      ),
    ));
  }
}
