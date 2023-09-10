import 'package:automobile_project/config/navigation/navigation.dart';
import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:automobile_project/presentation/component/components.dart';
import 'package:flutter/material.dart';
import '../../../core/resources/resources.dart';
import '../../component/custom_button.dart';


class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  late PageController _pageController;
  bool isLast = false;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.canvasColorFBFBFB,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: deviceHeight,
              child:  CustomAssetsImage(
                image:"assets/images/Component 1 – 1.png",
                boxFit: BoxFit.fitHeight,

              ),
            ),
          ),
          SafeArea(
            child: SizedBox(
              height: deviceHeight,
              width: deviceWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/images/Group 2953.png" , height: 120.h,),
                  SizedBox(
                    height: 100.h,
                  ) ,
                  SizedBox(
                    width: 380.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(text: "Automobile" , textStyle: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(
                            color: ColorManager.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),),


                        SizedBox(
                          height: 30.h,
                        ) ,
                        SizedBox(
                          width: 400.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomButton(
                                backgroundColor: ColorManager.white,
                                width: 350.w,
                                radius: 15.r,
                                buttonText: "Get Started",
                                textColor: ColorManager.primaryColor,
                                onTap: (){
                                  NavigationService.pushReplacement(context, Routes.loginScreen) ;
                                },

                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                    color: ColorManager.primaryColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),

                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
