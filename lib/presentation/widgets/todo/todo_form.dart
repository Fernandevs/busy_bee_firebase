import 'package:busy_bee/presentation/helpers/util.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'package:busy_bee/data/models/todo.dart';

class TodoForm extends ConsumerWidget {
  final Todo? todo;
  final bool viewMode;
  final Function(Todo todo)? onPressed;

  const TodoForm({
    Key? key,
    this.todo,
    this.onPressed,
    this.viewMode = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late TimeOfDay? time = TimeOfDay.now();
    late DateTime? date = todo != null ? todo?.datetime : DateTime.now();
    final TextEditingController titleEditingController = TextEditingController(
      text: todo?.title,
    );
    final TextEditingController descriptionEditingController =
        TextEditingController(
      text: todo?.description,
    );
    final TextEditingController noteEditingController = TextEditingController(
      text: todo?.note,
    );
    final TextEditingController dateEditingController = TextEditingController(
      text: DateFormat('dd/MM/yyyy').format(date!),
    );
    final TextEditingController timeEditingController = TextEditingController(
      text: DateFormat('hh:mm a').format(date),
    );

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 20.0,
          bottom: 8,
          left: 35,
          right: 35,
        ),
        child: Form(
          child: Center(
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: titleEditingController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Título',
                  ),
                  readOnly: viewMode,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: descriptionEditingController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Descripción',
                  ),
                  readOnly: viewMode,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: noteEditingController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Notas',
                  ),
                  readOnly: viewMode,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: dateEditingController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    icon: const Icon(Icons.calendar_today),
                    labelText: "Fecha",
                  ),
                  readOnly: true,
                  onTap: !viewMode
                      ? () async {
                          date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2101),
                            confirmText: 'Aceptar',
                            cancelText: 'Cancelar',
                          );
                          dateEditingController.text = DateFormat('dd/MM/yyyy').format(date!);
                        }
                      : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: timeEditingController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    icon: const Icon(Icons.access_time_filled),
                    labelText: "Hora",
                  ),
                  readOnly: true,
                  onTap: !viewMode
                      ? () async {
                          time = await showTimePicker(
                            initialEntryMode: TimePickerEntryMode.dial,
                            helpText: 'Hora',
                            context: context,
                            initialTime: TimeOfDay.now(),
                            confirmText: 'Aceptar',
                            cancelText: 'Cancelar',
                          );
                          timeEditingController.text =
                              DateFormat('hh:mm a').format(
                            DateTime(
                              date!.year,
                              date!.month,
                              date!.day,
                              time!.hour,
                              time!.minute,
                            ),
                          );
                        }
                      : null,
                ),
                const SizedBox(height: 50),
                if (!viewMode)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          context.goNamed('home');
                        },
                        child: const Text(
                          "Cancelar",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          if (todo == null) {
                            final todo = Todo(
                              title: titleEditingController.text,
                              description: descriptionEditingController.text,
                              color: Util.randomColor(),
                              datetime: DateTime(
                                date!.year,
                                date!.month,
                                date!.day,
                                time!.hour,
                                time!.minute,
                              ),
                              char: Util.randomChar(titleEditingController.text),
                            );
                            onPressed!(todo);
                          } else {
                            todo?.title = titleEditingController.text;
                            todo?.description = descriptionEditingController.text;
                            todo?.note = noteEditingController.text;
                            todo?.datetime = DateFormat('dd/MM/yyyy hh:mm aaa').parse(
                              '${dateEditingController.text} ${timeEditingController.text}',
                            );
                            onPressed!(todo!);
                          }
                        },
                        child: const Text(
                          'Guardar',
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
