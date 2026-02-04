import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductSkeleton extends StatelessWidget {
  const ProductSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 28.0),
        child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(width: 10.w),
          itemCount: 4,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Skeletonizer.zone(
              enabled: true,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Bone(
                    borderRadius: BorderRadius.all(Radius.circular(12.r)),
                    width: 170,
                    height: 170,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
