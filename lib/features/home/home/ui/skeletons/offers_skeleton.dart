import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OffersSkeleton extends StatelessWidget {
  final isMainPage;
  const OffersSkeleton({super.key, required this.isMainPage});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isMainPage ? double.infinity : 120.h,
      child: ListView.separated(
        separatorBuilder: (context, index) =>
            SizedBox(width: 10.w, height: 10.h),
        itemCount: 4,
        scrollDirection: isMainPage ? Axis.vertical : Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: isMainPage ? 8.0 : 0),
            child: Skeletonizer.zone(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Bone(
                  borderRadius: BorderRadius.all(Radius.circular(12.r)),
                  width: isMainPage ? double.infinity : 250,
                  height: isMainPage ? 150 : 140,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
