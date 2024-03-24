import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_v2/business_logic/cubit/note_cubit.dart';
import 'package:note_app_v2/core/widgets/custom_text.dart';

class NoteView extends StatelessWidget {
  const NoteView({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<NoteCubit>(context).createDataBase();
    BlocProvider.of<NoteCubit>(context).getData();
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: 'Notes'),
      ),
      body: BlocBuilder<NoteCubit, NoteState>(builder: (context, state) {
        // if (state is NoteInitial) {
        //   return const Center(child: CircularProgressIndicator());
        //}
        if (state is NoteLoading) {
          return Container();
        } else if (state is NoteError) {
          return Container();
        } else {
          return ListView.builder(
              itemCount: context.read<NoteCubit>().noteList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: CustomText(
                      text: context.read<NoteCubit>().noteList[index].title),
                );
              });
        }
      }),
    );
  }
}
