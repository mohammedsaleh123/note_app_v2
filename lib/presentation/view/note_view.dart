import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_v2/business_logic/cubit/note_cubit.dart';
import 'package:note_app_v2/core/app_strings.dart';
import 'package:note_app_v2/core/extension/center_extension.dart';
import 'package:note_app_v2/core/widgets/custom_text.dart';

class NoteView extends StatefulWidget {
  const NoteView({super.key});

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  @override
  void initState() {
    //BlocProvider.of<NoteCubit>(context).getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<NoteCubit>(context)
      ..createDatabase()
      ..getData();
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: 'Notes'),
      ),
      body: BlocConsumer<NoteCubit, NoteState>(listener: (context, state) {
        context.read<NoteCubit>().getData();
      }, builder: (context, state) {
        final cubit = context.read<NoteCubit>();
        if (state is NoteLoading) {
          return const CircularProgressIndicator().center();
        } else if (state is NoteError) {
          return const CircularProgressIndicator().center();
        } else {
          return ListView.builder(
              itemCount: context.read<NoteCubit>().notes.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    context
                        .read<NoteCubit>()
                        .deleteData(cubit.notes[index].id!);
                  },
                  child: ListTile(
                    leading: Image.asset(cubit.notes[index].noteImage),
                    title: ExpandableText(
                      cubit.notes[index].title,
                      expandText: '...more',
                      maxLines: 1,
                      collapseText: '...less',
                    ),
                    subtitle: ExpandableText(
                      cubit.notes[index].content,
                      expandText: '...more',
                      maxLines: 1,
                      collapseText: '...less',
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        //cubit.index = index;
                        //cubit.imageToEdit(index);
                        //cubit.navigatorToAdd();
                        Navigator.pushNamed(
                          context,
                          noteEditRoute,
                          arguments: cubit.notes[index],
                        );
                      },
                      icon: const Icon(Icons.edit),
                    ),
                  ),
                );
              });
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, noteAddRoute);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
