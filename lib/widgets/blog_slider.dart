import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:zarity_health_assignment/data/blog.dart';

class BlogSlider extends StatefulWidget {
  const BlogSlider({
    super.key,
    required this.blogs,
  });

  final List<Blog> blogs;

  @override
  State<BlogSlider> createState() => _BlogSliderState();
}

class _BlogSliderState extends State<BlogSlider> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: widget.blogs
          .map(
            (blog) => Container(
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          child: CachedNetworkImage(
                            height: 160.h,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            imageUrl: blog.image!,
                            placeholder: (context, url) {
                              return Image.memory(kTransparentImage);
                            },
                          ),
                        ),
                        Gap(8.h),
                        Text(
                          blog.date!,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Colors.black,
                                    fontSize: 12.sp,
                                  ),
                        ),
                        Gap(5.h),
                        Text(
                          blog.title!,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Colors.black,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        Gap(3.h),
                        Text(
                          "${blog.description!.substring(0, 85)}...",
                          softWrap: true,
                          textAlign: TextAlign.start,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Colors.black,
                                    fontSize: 12.sp,
                                  ),
                        ),
                        Gap(10.h),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
          .toList(),
      options: CarouselOptions(
        viewportFraction: 1,
        height: 275.h,
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
