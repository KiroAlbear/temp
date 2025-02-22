import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_progress_widget.dart';

class OverlayLoadingWidget extends StatelessWidget {
  final ValueNotifier<bool> showOverlayLoading;
  OverlayLoadingWidget({super.key, required this.showOverlayLoading});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: showOverlayLoading,
      builder: (context, value, child) {
        // widget.isLoadingWidgetBuilt = true;
        return !value
            ? SizedBox()
            : Container(
                color: Colors.black.withOpacity(0.3),
                child: Center(
                  child: CustomProgress(
                    color: Theme.of(context).colorScheme.primary,
                    size: 30.r,
                  ),
                ),
              );
      },
    );
  }
}
