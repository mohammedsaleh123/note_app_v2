import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_v2/business_logic/cubit/note_cubit.dart';
import 'package:note_app_v2/core/app_strings.dart';
import 'package:note_app_v2/presentation/view/add_note_view.dart';
import 'package:note_app_v2/presentation/view/note_view.dart';

class AppRoute {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case noteHomeRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => NoteCubit(),
            child: const NoteView(),
          ),
        );
      default:
        return MaterialPageRoute(
            builder: (context) => BlocProvider.value(
                value: NoteCubit(), child: const AddNoteView()));
    }
  }
}
