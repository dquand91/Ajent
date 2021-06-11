import 'package:ajent/app/data/models/Course.dart';
import 'package:ajent/app/modules/my_course_detail/my_course_detail_controller.dart';
import 'package:ajent/routes/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ajent/core/themes/widget_theme.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class MyCourseDetailPage extends StatelessWidget {
  final Course course = Get.arguments;

  @override
  Widget build(BuildContext context) {
    final MyCourseDetailController controller =
        Get.put(MyCourseDetailController(course));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          course.name,
          overflow: TextOverflow.fade,
          style: GoogleFonts.nunitoSans(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.grey[100],
        toolbarHeight: 70,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(
        () => (controller.isLoading.value)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                                child: Row(children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(15.0),
                                child: CircleAvatar(
                                  backgroundImage: AssetImage(
                                      "assets/images/ajent_logo.png"),
                                  radius: 40.0,
                                ),
                              ),
                              Text(
                                course.name,
                                style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w700, fontSize: 14),
                              )
                            ])),
                            Center(
                                child: OutlinedButton(
                              style: outlinedButtonStyle,
                              onPressed: () {
                                Get.toNamed(Routes.RATING);
                              },
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                                  child: Text(
                                    "Đánh giá",
                                    style: GoogleFonts.nunitoSans(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700),
                                  )),
                            )),
                            Text("Mã khóa",
                                style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.bold, fontSize: 12)),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                              child: TextFormField(
                                initialValue: course.id,
                                decoration: primaryTextFieldDecoration,
                                cursorColor: primaryColor,
                                readOnly: true,
                                style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w600, fontSize: 12),
                              ),
                            ),
                            Text("Họ và tên giảng viên",
                                style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.bold, fontSize: 12)),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                              child: TextFormField(
                                onTap: () {
                                  print('teacher details');
                                },
                                initialValue: controller.teacher
                                    .name, //Get a link here to get to teacher profile page
                                decoration: primaryTextFieldDecoration,
                                cursorColor: primaryColor,
                                readOnly: true,
                                style: GoogleFonts.nunitoSans(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12),
                              ),
                            ),
                            Text("Số điện thoại giảng viên",
                                style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.bold, fontSize: 12)),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                              child: TextFormField(
                                onTap: () async {
                                  if (controller.teacher.phone != null &&
                                      controller.teacher.phone.isNotEmpty) {
                                    await launch(
                                        'tel: ${controller.teacher.phone}');
                                  }
                                },
                                initialValue: (controller.teacher.phone == null)
                                    ? "Không có"
                                    : (controller.teacher.phone.isEmpty)
                                        ? "Không có"
                                        : controller.teacher.phone,
                                decoration: primaryTextFieldDecoration,
                                cursorColor: primaryColor,
                                keyboardType: TextInputType.phone,
                                readOnly: true,
                                style: GoogleFonts.nunitoSans(
                                    color: (controller.teacher.phone != null &&
                                            controller.teacher.phone.isNotEmpty)
                                        ? Colors.blue
                                        : Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12),
                              ),
                            ),
                            Text("Địa điểm học",
                                style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.bold, fontSize: 12)),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                              child: TextFormField(
                                onTap: () {
                                  launch(
                                      'https://www.google.com/maps/search/?api=1&query=${course.address}');
                                },
                                initialValue: course
                                    .address, //Get a link here to get to google maps.
                                decoration: primaryTextFieldDecoration,
                                cursorColor: primaryColor,
                                readOnly: true,
                                style: GoogleFonts.nunitoSans(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                            Text("Thời gian học",
                                style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.bold, fontSize: 12)),
                            TextFormField(
                              initialValue:
                                  controller.course?.value?.getTimeAsString() ??
                                      "",
                              decoration: primaryTextFieldDecoration,
                              cursorColor: primaryColor,
                              readOnly: true,
                              style: GoogleFonts.nunitoSans(
                                  fontWeight: FontWeight.w600, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Center(
                          child: Text("© Ajent ",
                              style: GoogleFonts.nunitoSans(
                                  fontWeight: FontWeight.w100, fontSize: 12))),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
