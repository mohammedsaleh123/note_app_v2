import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note_app_v2/business_logic/cubit/note_cubit.dart';
import 'package:note_app_v2/core/extension/padding_extension.dart';
import 'package:note_app_v2/core/widgets/custom_text.dart';

// ignore: must_be_immutable
class DisplayNoteImage extends StatelessWidget {
  DisplayNoteImage({
    super.key,
    required this.cubit,
  });
  NoteCubit cubit;

  @override
  Widget build(BuildContext context) {
    return cubit.imageChoose == ''
        ? const SizedBox()
        : SizedBox(
            height: 75.h,
            width: 75.w,
            child: GridTile(
              footer: Container(
                color: Colors.black54,
                child: CustomText(
                  text: cubit.imageTitle,
                  textAlign: TextAlign.center,
                  color: Colors.white,
                ),
              ),
              child: Image.asset(
                cubit.imageChoose,
                height: 75.h,
                width: 75.w,
              ),
            ),
          ).padding(8.w, 8.h);
  }
}
