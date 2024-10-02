import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/resources/app_colors.dart';
import 'app_links_service.dart';

class ShareCarButton extends StatelessWidget {
  final String id;
  const ShareCarButton({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.share, color: ColorManager.primaryColor),
      onPressed: () {
        Share.share(
          AppLinkingService.createDynamicLink(id),
          subject: 'Check out this car!',
        );
      },
    );
  }
}
class ShareCarButton2 extends StatelessWidget {
  final String id;
  const ShareCarButton2({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return
      InkWell(
        onTap: (){
          Share.share(
            AppLinkingService.createDynamicLink(id),
            subject: 'Check out this car!',
          );
        },
      child: const Icon(Icons.share, color: ColorManager.primaryColor,size: 22,),
    );
  }
}
