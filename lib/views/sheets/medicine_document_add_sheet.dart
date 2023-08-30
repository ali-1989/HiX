import 'package:app/tools/app/appNavigator.dart';
import 'package:app/tools/app/appToast.dart';
import 'package:app/tools/permissionTools.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:app/system/extensions.dart';
import 'package:app/tools/app/appDecoration.dart';
import 'package:app/tools/app/appImages.dart';
import 'package:app/views/components/my_sheet_layout.dart';
import 'package:iris_tools/models/dataModels/mediaModel.dart';
import 'package:iris_tools/widgets/customCard.dart';
import 'package:permission_handler/permission_handler.dart';

class MedicineDocumentAddSheet extends StatefulWidget {
  const MedicineDocumentAddSheet({
    Key? key
  }) : super(key: key);

  @override
  State createState() => _MedicineDocumentAddSheetState();
}
///============================================================================================
class _MedicineDocumentAddSheetState extends State<MedicineDocumentAddSheet> {
  TextEditingController amountCtr = TextEditingController();
  MediaModel? file;

  @override
  Widget build(BuildContext context) {
    return MySheetLayout (
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(AppImages.doctorDocIco, width: 25),
                const SizedBox(width: 10),
                const Text('افزودن مدرک پزشکی').font(AppDecoration.morabbaFont).fsR(1),
              ],
            ),

            const SizedBox(height: 30),

            GestureDetector(
              onTap: pickFile,
                child: Image.asset(AppImages.fileUploadIco)
            ),

            const SizedBox(height: 15),
            const Text('لطفا مدرک پزشکی خود را انتخاب کنید').thinFont(),
            const SizedBox(height: 5),
            const Text('فرمت های jpg, png, pdf پذیرفته است').thinFont(),

            Visibility(
              visible: file != null,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 15, 30, 20),
                  child: CustomCard(
                    color: Colors.grey.shade200,
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: GestureDetector(
                      onTap: onChangeTitleClick,
                      child: Row(
                        children: [
                          const Text('عنوان: '),
                          Flexible(child: Text('${file?.fileName}', maxLines: 1,)),
                        ],
                      ),
                    ),
                  ),
                )
            ),

            const SizedBox(height: 10),

            /// button
            SizedBox(
              width: 170,
              child: ElevatedButton(
                  onPressed: file == null? null : onRegisterClick,
                  child: const Text('ارسال')
              ),
            )
          ],
        ),
      ),
    );
  }

  Future pickFile() async {
    final granted = await PermissionTools.requestStoragePermission();

    if(granted != PermissionStatus.granted){
      AppToast.showToast(context, 'لطفا اجازه ی دسترسی به فایل را فعال کنید');
      return;
    }

    final pFile = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'pdf']
    );

    if(pFile != null && pFile.files.isNotEmpty){
      file = MediaModel();
      file!.path = pFile.files[0].path;
      file!.fileName = pFile.files[0].name;
      file!.extension = pFile.files[0].extension;
      file!.volume = pFile.files[0].size;

      setState(() {});
    }
  }

  void onRegisterClick() {
  }

  void onChangeTitleClick() {
    final route = PageRouteBuilder(
      opaque: false,
        barrierColor: Colors.blue,
        pageBuilder: (_, anim1, anim2){
          return TextFieldInput();
        }
    );

    Navigator.of(context).push(route);
  }
}

class TextFieldInput extends StatefulWidget {

  const TextFieldInput({super.key});

  @override
  State<StatefulWidget> createState() {
    return TextFieldInputState();
  }
}
///========================================================================
class TextFieldInputState extends State {

  @override
  Widget build(BuildContext context) {
   return Material(
     color: Colors.transparent,
     child: CustomCard(
       color: Colors.transparent,
       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
         child: TextField(
           decoration: AppDecoration.outlineBordersInputDecoration,
         ),
     ),
   );
  }

}