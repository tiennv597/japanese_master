import 'package:jamas_web/pages/questions/widgets_questions/set_form.dart';
import 'package:jamas_web/provider/tables.dart';
import 'package:jamas_web/widgets/page_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'constants/constants.dart';
import 'controller/question_controller.dart';
import 'dialog/dialog_confirm_question.dart';
import 'models/sub_type.dart';
import 'models/type.dart';

// Trang hiển thị thêm câu hỏi và xác nhận thêm câu hỏi
class QuestionAddPage extends StatefulWidget {
  @override
  _QuestionAddPageState createState() => _QuestionAddPageState();
}

class _QuestionAddPageState extends State<QuestionAddPage> {
  final QuestionController questionCtr = Get.find();
  @override
  Widget build(BuildContext context) {
    final TablesProvider tablesProvider = Provider.of<TablesProvider>(context);
    return SingleChildScrollView(
        child: Container(
      margin: const EdgeInsets.all(10.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            PageHeader(
              text: 'Thêm câu hỏi',
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //Chọn cấp độ câu hỏi
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Obx(
                        () => DropdownButton<String>(
                          dropdownColor: Colors.white,
                          value: questionCtr.questionModel.value.level,
                          icon: Icon(Icons.arrow_downward),
                          iconSize: 16,
                          elevation: 16,
                          style: TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 1,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String newValue) {
                            questionCtr.updateLevel(newValue);
                          },
                          items: LEVEL_CODE
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    //Chọn thể loại câu hỏi
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Obx(
                        () => DropdownButton<String>(
                          dropdownColor: Colors.white,
                          value: questionCtr.questionModel.value.type,
                          icon: Icon(Icons.arrow_downward),
                          iconSize: 16,
                          elevation: 16,
                          style: TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 1,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String newValue) {
                            questionCtr.updateType(newValue);
                          },
                          items: typeList
                              .map<DropdownMenuItem<String>>((Type type) {
                            return DropdownMenuItem<String>(
                              value: type.typeCode,
                              child: Text(type.typeName),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    //Chọn thể loại con của câu hỏi
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Obx(
                        () => DropdownButton<String>(
                          dropdownColor: Colors.white,
                          value: questionCtr.questionModel.value.subType,
                          icon: Icon(Icons.arrow_downward),
                          iconSize: 16,
                          elevation: 16,
                          style: TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 1,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String newValue) {
                            questionCtr.updateSubType(newValue);
//                            setState(() {
//                              questionCtr.selectedSubTypeCode = newValue;
//                              questionCtr.changeForm(newValue);
//                            });
                          },
                          items: questionCtr.subType
                              .map<DropdownMenuItem<String>>((SubType subType) {
                            questionCtr.selectedSubType = subType.subTypeName;
                            return DropdownMenuItem<String>(
                              value: subType.subTypeCode,
                              child: Text(subType.subTypeName),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Obx(() =>
                FormAddQuestion(questionCtr.questionModel.value.formCode)),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    DialogConfirmQuestion());
                          },
                          color: Colors.green,
                          child: Text(
                            "Lưu câu hỏi",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          onPressed: () {
                            questionCtr.clearALl();
                          },
                          color: Colors.red,
                          child: Text("Xóa tất cả",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                        ),
                      ),
                      Obx(() =>
                          Text('${Get.find<QuestionController>().message}'))
                    ],
                  ),
                )
              ],
            ),
          ]),
    ));
  }
}
