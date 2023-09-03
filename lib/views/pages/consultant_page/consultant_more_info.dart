import 'package:app/system/extensions.dart';
import 'package:app/tools/app/appImages.dart';
import 'package:flutter/material.dart';

class ConsultantMoreInfo extends StatefulWidget {
  const ConsultantMoreInfo({Key? key}) : super(key: key);

  @override
  State<ConsultantMoreInfo> createState() => _ConsultantMoreInfoState();
}
///====================================================================================
class _ConsultantMoreInfoState extends State<ConsultantMoreInfo> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 30),
          buildAvatarSection(),

          buildNameSection(),

          buildDegreeOfEducationSection(),

          const SizedBox(height: 8),

          buildAccessSection(),

          Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [

                ],
              )
          )
        ],
      ),
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
}
