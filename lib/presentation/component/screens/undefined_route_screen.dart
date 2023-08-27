import 'package:flutter/material.dart';

import '../components.dart';

class UndefinedRouteScreen extends StatelessWidget {
  const UndefinedRouteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CustomText(
          text: "This route isn't found !!",
        ),
      ),
    );
  }
}
