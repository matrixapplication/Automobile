import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:flutter/material.dart';

import '../../../core/resources/resources.dart';
import '../../component/components.dart';

class NewCarDetailsData extends StatefulWidget {
  const NewCarDetailsData({Key? key}) : super(key: key);

  @override
  State<NewCarDetailsData> createState() => _NewCarDetailsDataState();
}

class _NewCarDetailsDataState extends State<NewCarDetailsData> {
  List<String> titles = ["Specifications", "Safety", "Technologies"];
  List<List<String>> content = [
    [
      "Specifications 1",
      "Specifications 2",
      "Specifications 3",
    ],
    [
      "safety 1",
      "safety 2",
      "safety 3",
    ],
    [
      "Technologies 1",
      "Technologies 2",
      "Technologies 3",
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: 3,
        itemBuilder: (context, i) {
          return Container(
            decoration: BoxDecoration(
                color: ColorManager.greyColorCBCBCB.withOpacity(0.4),
                borderRadius: BorderRadius.circular(12.r)),
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: ExpansionTile(
              tilePadding: const EdgeInsets.all(0),
              childrenPadding: const EdgeInsets.all(0),
              
              initiallyExpanded: i == 0 ? true : false,
              title: CustomText(
                text: titles[i],
                textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeightManager.semiBold,
                    height: 1,
                    color: ColorManager.black),
                maxLines: 1,
                // overflow: TextOverflow.ellipsis,
              ),
              children: <Widget>[
                Column(
                  children: _buildExpandableContent(data: content[i]),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 10.h,
          );
        },
      ),
    );
  }

  _buildExpandableContent({required List<String> data}) {
    List<Widget> columnContent = [];

    for (int i = 0; i < data.length; i++) {
      columnContent.add(Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomText(
            text: data[i],
            textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: ColorManager.lightBlack,
                fontWeight: FontWeightManager.semiBold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ));
    }

    return columnContent;
  }
}
