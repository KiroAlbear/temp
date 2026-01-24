import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BannersSkeleton extends StatelessWidget {
  const BannersSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(width: 10.w),
        itemCount: 4,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Skeletonizer.zone(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Bone(
                borderRadius: BorderRadius.all(Radius.circular(12.r)),
                width: 280,
                height: 200,
              ),
            ),
          );
        },
      ),
    );
  }
}
