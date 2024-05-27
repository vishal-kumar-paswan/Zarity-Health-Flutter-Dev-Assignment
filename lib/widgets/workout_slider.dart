import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:zarity_health_assignment/data/workout.dart';

class WorkoutSlider extends StatefulWidget {
  const WorkoutSlider({
    super.key,
    required this.workouts,
  });

  final List<Workout> workouts;

  @override
  State<WorkoutSlider> createState() => _WorkoutSliderState();
}

class _WorkoutSliderState extends State<WorkoutSlider> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: widget.workouts
          .map(
            (workout) => Container(
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 0.3,
                  color: Colors.black87,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Material(
                elevation: 1,
                borderRadius: BorderRadius.circular(15),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: ColorFiltered(
                          colorFilter: const ColorFilter.mode(
                            Color.fromARGB(255, 210, 209, 209),
                            BlendMode.darken,
                          ),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            height: 200.h,
                            width: double.infinity,
                            imageUrl: workout.image!,
                            placeholder: (context, url) {
                              return Image.memory(kTransparentImage);
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 20.h,
                          left: 20.w,
                        ),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            workout.title!,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  color: Colors.white,
                                  fontSize: 26.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
          .toList(),
      options: CarouselOptions(
        viewportFraction: 1,
        height: 220.h,
        initialPage: 0,
        enableInfiniteScroll: true,
        autoPlay: true,
        reverse: false,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: false,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
