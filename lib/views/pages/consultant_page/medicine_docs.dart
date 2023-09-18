import 'package:flutter/material.dart';

import 'package:file_sizes/file_sizes.dart';
import 'package:iris_tools/models/dataModels/media_model.dart';
import 'package:iris_tools/modules/stateManagers/assist.dart';
import 'package:iris_tools/widgets/custom_card.dart';
import 'package:iris_tools/widgets/icon/circular_icon.dart';
import 'package:iris_tools/widgets/sizePosition/size_inInfinity.dart';

import 'package:app/structures/abstract/state_super.dart';
import 'package:app/system/extensions.dart';
import 'package:app/tools/app/app_decoration.dart';
import 'package:app/tools/app/app_icons.dart';
import 'package:app/tools/app/app_images.dart';
import 'package:app/tools/app/app_sheet.dart';
import 'package:app/views/sheets/medicine_document_add_sheet.dart';

class MedicineDocuments extends StatefulWidget {

  const MedicineDocuments({
    Key? key,
  }) : super(key: key);

  @override
  State createState() => _MedicineDocumentsState();
}
///=========================================================================================
class _MedicineDocumentsState extends StateSuper<MedicineDocuments> {
  List<MediaModel> docList = [];

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Assist(
      controller: assistCtr,
      isHead: true,
      builder: (_, ctr, data) {
        return buildBody();
      }
    );
  }

  Widget buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('مدارک پزشکی').font(AppDecoration.morabbaFont).fsR(2),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GestureDetector(
                onTap: onAddDocClick,
                child: CircularIcon(
                  icon: AppIcons.add,
                  backColor: AppDecoration.mainColor,
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 15),

        Builder(
            builder: (lCtx){
              if(docList.isEmpty){
                return SizeInInfinity(
                  builder: (BuildContext context, double? top, double? height, double? screenHeight) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                      child: SizedBox(
                        height: (screenHeight?? 300) - 100,
                        child: Card(
                          child: Center(
                            child: const Text('فایلی اضافه نشده است').bold().fsR(-2),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }

              return ListView.builder(
                  itemCount: docList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: itemBuilder
              );
            }
        )
      ],
    );
  }

  Widget? itemBuilder(BuildContext context, int index) {
    final itm = docList[index];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: CustomCard(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:14, vertical: 14),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Flexible(
                              child: Text('${itm.title}', maxLines: 1,)
                          )
                        ],
                      ),
                    ),

                    const SizedBox(width: 12),
                    Row(
                      children: [
                        Text(
                          FileSize.getSize(itm.volume),
                          textDirection: TextDirection.ltr,).englishFont().fsR(-2).alpha(),

                        const SizedBox(width: 12),
                        ColorFiltered(
                            colorFilter: const ColorFilter.matrix([
                              0, 0, 0, 0, 0,
                              0, 0, 0, 0, 0,
                              0, 0, 0, 0, 0,
                              0, 0, 0, 2, 0,
                            ]),
                            child: Image.asset(AppImages.recycleBinIco,)
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
      ),
    );
  }

  void onAddDocClick() async {
    final res = await AppSheet.showSheetCustom(
      context,
      builder: (_) => MedicineDocumentAddSheet(),
      routeName: 'MedicineDocumentAddSheet',
      contentColor: Colors.transparent,
      isScrollControlled: true,
    );

    if(res is MediaModel) {
      docList.add(res);
      assistCtr.updateHead();
    }
  }

}
