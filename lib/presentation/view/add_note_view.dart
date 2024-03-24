import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:note_app_v2/business_logic/cubit/note_cubit.dart';
import 'package:note_app_v2/core/app_strings.dart';
import 'package:note_app_v2/core/widgets/custom_button.dart';
import 'package:note_app_v2/core/widgets/custom_text.dart';
import 'package:note_app_v2/core/widgets/custom_text_field.dart';

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
          return SingleChildScrollView(
            child: Column(
              children: [
                CustomTextField(
                  hintText: 'Title',
                  textController: context.read<NoteCubit>().titleController,
                ),
                CustomTextField(
                  hintText: 'Content',
                  textController: context.read<NoteCubit>().contentController,
                ),
                CustomButton(
                    onPressed: () {
                      context.read<NoteCubit>().insertData();
                      //BlocProvider.of<NoteCubit>(context).getData();

                      Navigator.pushReplacementNamed(context, noteHomeRoute);
                    },
                    color: Colors.amber,
                    radius: 10.sp,
                    minWidth: Get.width,
                    child: CustomText(text: 'Save')),
              ],
            ),
          );
        },
      ),
    );
  }
}
