import 'package:flutter/material.dart';
import 'package:image_loader/image_helper.dart';

import '../../deel.dart';

class NewSectionWidget extends StatelessWidget {
  final Widget child;
  final String title;
  final void Function() onViewAllTapped;
  NewSectionWidget({
    required this.child,
    required this.onViewAllTapped,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: mostSellingBackgroundColor,
      child: Column(
        children: [_buildSectionHeader(context), SizedBox(height: 10), child],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 16, end: 16, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: title,
            customTextStyle: BoldStyle(color: secondaryColor, fontSize: 22),
          ),
          InkWell(
            onTap: onViewAllTapped,
            child: Row(
              children: [
                CustomText(
                  text: Loc.of(context)!.viewAll,
                  customTextStyle: BoldStyle(
                    color: secondaryColor,
                    fontSize: 12,
                  ),
                ),
                SizedBox(width: 12),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Transform.rotate(
                    angle: 45 * (3.141592653589793 / 2),
                    child: ImageHelper(
                      image: Assets.svg.icDropDownArrow,
                      imageType: ImageType.svg,
                    ),
                  ),
                ),
                // Icon(Icons.arrow_forward_ios, size: 10, weight: 100),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
