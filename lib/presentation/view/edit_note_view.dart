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
import 'package:note_app_v2/data/models/note_model.dart';
import 'package:note_app_v2/presentation/widgets/display_note_image.dart';
import 'package:note_app_v2/presentation/widgets/notes_list_images.dart';

// ignore: must_be_immutable
class EditNoteView extends StatefulWidget {
  const EditNoteView({
    super.key,
    required this.task,
  });
  final Task task;

  @override
  State<EditNoteView> createState() => _EditNoteViewState();
}

class _EditNoteViewState extends State<EditNoteView> {
  @override
  void initState() {
    BlocProvider.of<NoteCubit>(context).getOneTask(widget.task.id!);
    BlocProvider.of<NoteCubit>(context).taskToEdit(widget.task);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: 'Edit Note'),
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
                  textController: cubit.editTitleController,
                ).padding(8.w, 8.h),
                CustomTextField(
                  hintText: 'Content',
                  textController: cubit.editContentController,
                ).padding(8.w, 8.h),
                CustomButton(
                  onPressed: () {
                    cubit.updateData(
                      widget.task.id!,
                    );
                    //cubit.getData();
                    Navigator.pop(
                      context,
                      noteHomeRoute,
                    );
                    cubit.clearText();
                  },
                  color: Colors.amber,
                  radius: 10.sp,
                  minWidth: Get.width,
                  child: Padding(
                    padding: EdgeInsets.all(16.sp),
                    child: CustomText(text: cubit.buttonTitle),
                  ),
                ).padding(8.w, 8.h),
              ],
            ),
          );
        },
      ),
    );
  }
}
