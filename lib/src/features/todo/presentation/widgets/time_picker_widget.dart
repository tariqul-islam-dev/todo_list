import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/todo_bloc.dart';
import '../dialogs/picker_dialogs.dart';

class TimePickerWidget extends StatelessWidget {
  const TimePickerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      buildWhen: (previous, current) => current is TimePickingState,
      builder: (ctx, state) {
        return ListTile(
          onTap: () {
            ctx.read<TodoBloc>().add(
                  TimePickingEvent(
                    timeOfDay: timePickerDialog(ctx),
                  ),
                );
          },
          leading: const Icon(Icons.watch_later),
          title: Text(
            state is TimePickingState ? state.time : "Time",
          ),
        );
      },
    );
  }
}
