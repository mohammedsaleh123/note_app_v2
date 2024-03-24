import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:note_app_v2/business_logic/cubit/note_cubit.dart';
import 'package:note_app_v2/core/app_strings.dart';
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
                Padding(
                  padding: EdgeInsets.all(8.sp),
                  child: CustomTextField(
                    hintText: 'Title',
                    textController: context.read<NoteCubit>().titleController,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.sp),
                  child: CustomTextField(
                    hintText: 'Content',
                    textController: context.read<NoteCubit>().contentController,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.sp),
                  child: CustomButton(
                      onPressed: () {
                        context
                            .read<NoteCubit>()
                            .insertData(context.read<NoteCubit>().imageChoose);
                        Navigator.pushReplacementNamed(context, noteHomeRoute);
                      },
                      color: Colors.amber,
                      radius: 10.sp,
                      minWidth: Get.width,
                      child: Padding(
                        padding: EdgeInsets.all(16.sp),
                        child: CustomText(text: 'Save'),
                      )),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
