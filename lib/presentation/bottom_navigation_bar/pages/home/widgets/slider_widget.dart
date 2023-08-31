import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:automobile_project/main.dart';
import 'package:automobile_project/presentation/bottom_navigation_bar/pages/home/view_model/sliders_view_model.dart';
import 'package:automobile_project/presentation/component/cutom_shimmer_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../../core/resources/resources.dart';
import '../../../../component/components.dart';

class BuildSliderComponent extends StatefulWidget {
  final GlobalKey<ScaffoldState> drawerKey;

  const BuildSliderComponent({
    required this.drawerKey,
    Key? key,
  }) : super(key: key);

  @override
  State<BuildSliderComponent> createState() => _BuildSliderComponentState();
}

class _BuildSliderComponentState extends State<BuildSliderComponent> {
  int sliderIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<SlidersViewModel>(
      builder: (_ , data , __){
        return Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Container(
              width: double.infinity,
              color: ColorManager.white,
              child: CarouselSlider.builder(
                itemCount: data.showSlidersResponse != null ?
                data.showSlidersResponse?.data?.length : 0,
                options: CarouselOptions(
                    height: deviceHeight * 0.45,
                    //  aspectRatio: 2 / 1,
                    viewportFraction: 1,
                    autoPlayAnimationDuration: const Duration(seconds: 3),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    autoPlay: true,
                    reverse: true,
                    pageSnapping: true,
                    //  enlargeCenterPage: true,
                    enlargeStrategy: CenterPageEnlargeStrategy.scale,
                    onPageChanged: (index, reason) {
                      setState(() {
                        sliderIndex = index;
                        if (kDebugMode) {
                          print(index);
                        }
                      });
                    }),
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  return
                    Stack(
                      children: [
                        CustomShimmerImage(
                          image: "${data.showSlidersResponse?.data?[index].image}",
                          boxFit:  BoxFit.cover,
                          height: deviceHeight * 0.45,
                          width: double.infinity,) ,
                      ],
                    );


                },
              ),
            ),
            Align(
              alignment: shared!.getString("lang") == "en" ? Alignment.bottomLeft : Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 100.h, horizontal: 20.w),
                child: CustomText(
                  text: "${data.showSlidersResponse?.data?[sliderIndex].title}",
                  textStyle: Theme
                      .of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(
                      height: 1,
                      color: ColorManager.white,
                      fontWeight: FontWeightManager.semiBold),
                ),
              ),
            ),
            Align(
              alignment:shared!.getString("lang") == "en" ? Alignment.bottomLeft : Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 80.h, horizontal: 20.w),
                child: AnimatedSmoothIndicator(
                  activeIndex: sliderIndex,
                  count: data.showSlidersResponse != null ?
                  data.showSlidersResponse!.data!.length : 0,
                  axisDirection: Axis.horizontal,
                  effect: JumpingDotEffect(
                    dotColor: ColorManager.white,
                    activeDotColor: ColorManager.orange,
                    dotHeight: 10.h,
                    dotWidth: 10.h,
                    spacing: 12.w,
                  ),
                ),
              ),
            ),

          ],
        ) ;
      },
    );
  }
}
