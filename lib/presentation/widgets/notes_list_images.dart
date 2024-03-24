import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note_app_v2/business_logic/cubit/note_cubit.dart';
import 'package:note_app_v2/core/app_strings.dart';
import 'package:note_app_v2/core/widgets/custom_text.dart';

// ignore: must_be_immutable
class NotesListImages extends StatelessWidget {
  NotesListImages({
    super.key,
    required this.cubit,
  });
  NoteCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.sp),
      child: SizedBox(
        height: 100.h,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: notesImages.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  cubit.chooseImage(index);
                },
                child: Padding(
                  padding: EdgeInsets.all(8.sp),
                  child: SizedBox(
                    height: 100.h,
                    width: 100.w,
                    child: GridTile(
                      footer: Container(
                        color: Colors.black54,
                        child: CustomText(
                          text: notesTitles[index],
                          textAlign: TextAlign.center,
                          color: Colors.white,
                        ),
                      ),
                      child: Image.asset(
                        notesImages[index],
                        height: 100.h,
                        width: 100.w,
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
