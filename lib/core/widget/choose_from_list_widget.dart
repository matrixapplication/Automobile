import 'package:flutter/material.dart';

class ChooseFromListItemWidget extends StatelessWidget {
  final List<ChooseItemListModel> items;
  final void Function(ChooseItemListModel item) onChoose;
  final double? radius;
  final double? width;
  final double? height;
  final bool? isHasInitailItem;
   const ChooseFromListItemWidget({super.key,this.width, this.height,required this.onChoose,this.radius,this.isHasInitailItem, required this.items, });

   @override
  Widget build(BuildContext context) {

     String index =isHasInitailItem!=false? items[0].title:'';

     return StatefulBuilder(builder: (context,setState){
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ...items.map((e) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
              child: InkWell(
                onTap: (){
                  setState(() {
                    index =e.title;
                    onChoose(e);
                  });
                },
                child: Container(
                  height:height ,
                  width:width ,
                  decoration:BoxDecoration(
                    color: index==e.title?Colors.blue:Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(radius??20),
                    border: Border.all(color: index==e.title? Colors.transparent:Colors.grey.shade300,)
                   ),

                  child: Center(
                    child: Padding(
                      padding:  const EdgeInsets.only(top: 6,bottom: 6,right: 12,left: 12),
                      child: Text(
                        e.title,
                       style: TextStyle(
                         fontSize: 17,
                         color: index==e.title?Colors.white:Colors.grey.shade500,
                       ),
                      ),
                    ),
                  ),
                ),
              ),
            )),
          ],
        ),
      );
    });
  }
}
class ChooseItemListModel {
  final int id;
  final String title;

  ChooseItemListModel({required this.id, required this.title});
}
