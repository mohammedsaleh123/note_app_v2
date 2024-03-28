import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:note_app_v2/business_logic/cubit/note_cubit.dart';
import 'package:note_app_v2/core/app_strings.dart';
import 'package:note_app_v2/core/extension/padding_extension.dart';
import 'package:note_app_v2/core/widgets/custom_button.dart';
import 'package:note_app_v2/core/widgets/custom_text.dart';
import 'package:note_app_v2/core/widgets/custom_text_field.dart';
import 'package:note_app_v2/presentation/widgets/display_note_image.dart';
import 'package:note_app_v2/presentation/widgets/notes_list_images.dart';

class AddNoteView extends StatelessWidget {
  const AddNoteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: 'Add Note'),
      ),
      body: BlocBuilder<NoteCubit, NoteState>(
        builder: (context, state) {
          final cubit = context.read<NoteCubit>();
          return SingleChildScrollView(
            child: Column(
              children: [
                NotesListImages(
                  cubit: cubit,
                ),
                DisplayNoteImage(
                  cubit: cubit,
                ),
                CustomTextField(
                  hintText: 'Title',
                  textController: context.read<NoteCubit>().titleController,
                ).padding(8.w, 8.h),
                CustomTextField(
                  hintText: 'Content',
                  textController: context.read<NoteCubit>().contentController,
                ).padding(8.w, 8.h),
                CustomButton(
                  onPressed: () {
                    context
                        .read<NoteCubit>()
                        .insertData(context.read<NoteCubit>().imageChoose);
                    Navigator.pop(context, noteHomeRoute);
                    context.read<NoteCubit>().clearText();
                  },
                  color: Colors.amber,
                  radius: 10.sp,
                  minWidth: Get.width,
                  child: CustomText(text: context.read<NoteCubit>().buttonTitle)
                      .padding(16.w, 16.h),
                ).padding(8.w, 8.h),
              ],
            ),
          );
        },
      ),
    );
  }
}
