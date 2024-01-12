import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/todo_bloc.dart';
import '../dialogs/picker_dialogs.dart';

class DatePickerWidget extends StatelessWidget {
  const DatePickerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      buildWhen: (previous, current) => current is DatePickingState,
      builder: (ctx, state) {
        return ListTile(
          onTap: () async {
            ctx.read<TodoBloc>().add(
                  DatePickingEvent(
                    dateTime: datePickerDialog(ctx),
                  ),
                );
          },
          leading: const Icon(Icons.date_range),
          title: Text(
            state is DatePickingState ? state.date : "Date",
          ),
        );
      },
    );
  }
}
