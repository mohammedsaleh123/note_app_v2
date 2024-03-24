import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_v2/business_logic/cubit/note_cubit.dart';
import 'package:note_app_v2/core/app_strings.dart';
import 'package:note_app_v2/core/widgets/custom_text.dart';

class NoteView extends StatefulWidget {
  const NoteView({super.key});

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  @override
  void initState() {
    BlocProvider.of<NoteCubit>(context).createDatabase();

    BlocProvider.of<NoteCubit>(context).getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: 'Notes'),
      ),
      body: BlocBuilder<NoteCubit, NoteState>(builder: (context, state) {
        final cubit = context.read<NoteCubit>();
        if (state is NoteLoading) {
          return Container();
        } else if (state is NoteError) {
          return Container();
        } else {
          return ListView.builder(
              itemCount: context.read<NoteCubit>().notes.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    //context.read<NoteCubit>().deleteData(index + 1);
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
