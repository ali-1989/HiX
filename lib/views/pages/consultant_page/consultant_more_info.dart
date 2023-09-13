import 'package:flutter/material.dart';

import 'package:iris_tools/api/generator.dart';
import 'package:iris_tools/modules/stateManagers/assist.dart';
import 'package:iris_tools/widgets/customCard.dart';

import 'package:app/structures/abstract/state_super.dart';
import 'package:app/structures/models/consultant/consultant_comment_model.dart';
import 'package:app/system/extensions.dart';
import 'package:app/tools/app/app_decoration.dart';
import 'package:app/tools/app/app_icons.dart';
import 'package:app/tools/app/app_images.dart';
import 'package:app/views/components/my_divider.dart';

class ConsultantMoreInfo extends StatefulWidget {
  const ConsultantMoreInfo({Key? key}) : super(key: key);

  @override
  State<ConsultantMoreInfo> createState() => _ConsultantMoreInfoState();
}
///====================================================================================
class _ConsultantMoreInfoState extends StateSuper<ConsultantMoreInfo> {
  bool aboutCollapse = true;
  List<ConsultantCommentModel> commentList = [];

  @override
  void initState(){
    super.initState();

    List<SenderUser> senders = [];
    List<ConsultantCommentModel> replay = [];

    List.generate(100, (index) {
      senders.add(SenderUser()..id = Generator.generateName(5)..name = Generator.getRandomFrom(['زهره املشی', 'عدیلی']));
    });

    List.generate(3, (index) {
      final i = ConsultantCommentModel()..text = Generator.getRandomFrom(['متن تصادفی '*10, ' جملات کامنت' * 40]);
      i.date = DateTime.now();
      i.id = Generator.generateName(10);
      i.rate = Generator.getRandomFrom([2, 4.2, 1]);
      i.senderUser = Generator.getRandomFrom(senders);

      replay.add(i);
    });

    List.generate(100, (index) {
      final i = ConsultantCommentModel()..text = Generator.getRandomFrom(['متن ریپلای '*10, ' جملات ریپلای' * 40]);
      i.date = DateTime.now();
      i.id = Generator.generateName(10);
      i.rate = Generator.getRandomFrom([5, 2.2, 3.1]);
      i.senderUser = Generator.getRandomFrom(senders);

      if(Generator.randomBool()) {
        i.replyList.add(Generator.getRandomFrom(replay));
      }

      commentList.add(i);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Assist(
      isHead: true,
      controller: assistCtr,
      builder: (_, ctr, data) {
        return Scaffold(
          body: Column(
            children: [
              const SizedBox(height: 30),
              buildAvatarSection(),

              buildNameSection(),

              buildDegreeOfEducationSection(),

              const SizedBox(height: 8),

              buildAccessSection(),

              const SizedBox(height: 14),
              buildRateSection(),

              const SizedBox(height: 14),
              buildDoctorNumberSection(),

              const SizedBox(height: 14),
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverList(
                        delegate: SliverChildListDelegate([buildAboutSection(),])
                    ),


                    SliverVisibility(
                      visible: aboutCollapse,
                      sliver: SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        sliver: SliverList.builder(
                            itemCount: commentList.length,
                            itemBuilder: buildCommentItems,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      }
    );
  }

  Widget buildAvatarSection() {
    return const CircleAvatar(
      backgroundImage: AssetImage(AppImages.avatar),
      radius: 30,
    );
  }

  Widget buildNameSection() {
    return const Text('مهناز حسینی').bold();
  }

  Widget buildDegreeOfEducationSection() {
    return const Text('متخصص زنان و زایمان').thinFont();
  }

  Widget buildAccessSection() {
    return Chip(
      label: const Text('دردسترس',).thinFont(),
      backgroundColor: Colors.green,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      labelPadding: EdgeInsets.zero,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
    );
  }

  buildRateSection () {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: CustomCard(
              //todo. border: Border.all(color: Colors.black12, style: BorderStyle.solid),
                padding: EdgeInsets.zero,
                child: SizedBox(
                  height: 35,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('تعداد مشاوره').fsR(-2),
                      const Text('21').fsR(-2),
                    ],
                  ),
                )
            ),
          ),

          const SizedBox(width: 6),
          Expanded(
            child: CustomCard(
              //todo. border: Border.all(color: Colors.black12, style: BorderStyle.solid),
                padding: const EdgeInsets.all(0),
                child: SizedBox(
                  height: 35,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('55').fsR(-2).bold(),
                      const SizedBox(width: 6),
                      Image.asset(AppImages.commentIco, width: 14),
                    ],
                  ),
                )
            ),
          ),

          const SizedBox(width: 8),
          Expanded(
            child: CustomCard(
              //todo. border: Border.all(color: Colors.black12, style: BorderStyle.solid),
                padding: EdgeInsets.zero,
                child: SizedBox(
                  height: 35,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('4.5').fsR(-2).bold(),
                      const SizedBox(width: 8),
                      Image.asset(AppImages.starIco, width: 14),
                    ],
                  ),
                )
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDoctorNumberSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('شماره نظام پزشکی:     ').bold(),

          Flexible(child: Text('.......' * 10, maxLines: 1,).bold()),

          const Text('     4578123658745').bold(),
        ],
      ),
    );
  }

  Widget buildAboutSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(AppImages.aboutIco, width: 14,),
              const SizedBox(width: 6),
              const Text('درباره ی مشاور:').bold()
            ],
          ),

          const SizedBox(height: 5),
          Stack(
            children: [
              GradientShader(
                isActive: aboutCollapse /* && text.length > 50 */,
                gradient: const LinearGradient(
                  colors: [
                    Colors.black,
                    Colors.black12,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                child: Text(' سلام. من روان پزشک هستم. دانشجوی دانشگاه تهران'*50 + (' ' * (aboutCollapse? 1 : 200)),
                  textAlign: TextAlign.justify,
                  maxLines: aboutCollapse? 4 : null,
                  style: const TextStyle(height: 2),
                ).fsR(-1),
              ),

              Positioned(
                  bottom: 5,
                  left: 0,
                  right: 0,
                  child: Visibility(
                    visible: true /* && text.length > 50 */,
                    child: GestureDetector(
                      onTap: onShowMoreAboutClick,
                      child: Center(
                        child: CustomCard(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          color: Colors.grey.shade100,
                          child: Builder(
                              builder: (context) {
                                if(!aboutCollapse){
                                  return const Text('بستن');
                                }

                                return Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomCard(
                                      //todo. border: Border.all(style: BorderStyle.solid),
                                        radius: 3,
                                        child: const Icon(AppIcons.add, size: 11)
                                    ),

                                    const SizedBox(width: 7),
                                    const Text('مشاهده بیشتر').fsR(-2)
                                  ],
                                );
                              }
                          ),
                        ),
                      ),
                    ),
                  )
              )
            ],
          ),

          const SizedBox(height: 20),

          Visibility(
              visible: commentList.isNotEmpty && aboutCollapse,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MyDivider(),
                  const SizedBox(height: 12),
                  const Text('نظرات کاربران').font(AppDecoration.morabbaFont).fsR(2),
                  const SizedBox(height: 12),
                ],
              )
          )
        ],
      ),
    );
  }

  void onShowMoreAboutClick() {
    aboutCollapse = !aboutCollapse;
    assistCtr.updateHead();
  }

  Widget? buildCommentItems(BuildContext context, int index) {
    final itm = commentList[index];

    if(itm.replyList.isEmpty){
      return buildConsultantCommentView(itm);
    }

    return Column(
      children: [
        buildConsultantCommentView(itm),
        ...itm.replyList.map((e) => buildConsultantCommentReplayView(e)).toList(),
      ],
    );
  }

  Widget buildConsultantCommentView(ConsultantCommentModel itm) {
    return Column(
      key: ValueKey(itm.id),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(itm.senderUser.name),

            Row(
              children: [
                Text(itm.rate.toString()).bold(),
                const SizedBox(width: 4),
                Image.asset(AppImages.starIco, width: 10),
              ],
            ),
          ],
        ),

        SizedBox(
          width: double.infinity,
          child: CustomCard(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: AppDecoration.gray,
              child: Text(itm.text, style: const TextStyle(height: 1.8)).fsR(-1.5),
          ),
        ),

        const SizedBox(height: 15),
      ],
    );
  }

  Widget buildConsultantCommentReplayView(ConsultantCommentModel itm) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(itm.senderUser.name),
            ],
          ),

          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(AppImages.infoIco3, scale: 1.3),
              const SizedBox(width: 6),

              Expanded(
                child: CustomCard(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  color: Colors.transparent,
                  child: Text(itm.text, style: const TextStyle(height: 1.8)).fsR(-1.5),
                ).wrapDotBorder(
                  padding: EdgeInsets.zero,
                  color: Colors.black12,
                  alpha: 100,
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),
        ],
      ),
    );
  }
}


class GradientShader extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final bool isActive;

  const GradientShader({
        super.key,
        required this.child,
        required this.gradient,
        this.isActive = true,
      });


  @override
  Widget build(BuildContext context) {
    if(!isActive){
      return child;
    }

    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: child,
    );
  }
}
