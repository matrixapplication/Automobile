import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:flutter/material.dart';

class TextIconWidget extends StatelessWidget {
  final String? title ;
  final IconData icon ;
  const TextIconWidget({
    super.key, this.title, required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon)  ,
        SizedBox(width :  10.w),
        SizedBox(
          width: 200.w,
          child: Text("$title" , style: Theme.of(context).textTheme.titleMedium,),
        )
      ],
    );
  }
}