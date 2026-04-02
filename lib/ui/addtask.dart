import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:td2_mobile/viewmodel/taskviewmodel.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';



import '../models/task.dart';

class AddTask extends StatefulWidget{
  const AddTask({super.key, this.task});
  
  final Task? task;

  final _formTitle = "";
  final _formDesc = "";
  final _formHr = 0;
  final _formDif = 0;

  @override
  State<AddTask> createState() => _AddTaskState();
  }

class _AddTaskState extends State<AddTask> {
  final _formKey = GlobalKey<FormBuilderState>();

  Key? get _formTitle => null;
  Key? get _formDesc => null;
  Key? get _formDif => null;
  Key? get _formHr => null;


  @override
  Widget build(BuildContext context) {
    final isEditing = widget.task != null;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Task' : 'Add Task'),
      ),
      body: Center(
        child: FormBuilder(
          key: _formKey,
          child: Column(
              children: [
                FormBuilderTextField(
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Titre',
                  ),
                  key: _formTitle,
                  name: 'Title',
                  initialValue: isEditing ? widget.task!.title : '',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),

                FormBuilderTextField(
                  maxLines: 5,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                  key: _formDesc,
                  name: 'Description',
                  initialValue: isEditing ? widget.task!.description : '',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),
                FormBuilderTextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Difficulté',
                  ),
                  key: _formDif,
                  name: 'Difficulty',
                  initialValue: isEditing ? widget.task!.difficulty.toString() : '',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.numeric()
                  ]),
                ),
                FormBuilderTextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Nombre d\'heure',
                  ),
                  key: _formHr,
                  name: 'NbHours',
                  initialValue: isEditing ? widget.task!.nbhours.toString() : '',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.numeric()
                  ]),
                ),

                ElevatedButton(
                  
                  onPressed: () {
                    if (_formKey.currentState!.saveAndValidate()) {
                      final formData = _formKey.currentState!.value;
                      
                      if (isEditing) {
                        final updatedTask = Task(
                          id: widget.task!.id,
                          title: formData['Title'] ?? '',
                          description: formData['Description'] ?? '',
                          difficulty: int.tryParse(formData['Difficulty'] ?? '0') ?? 0,
                          nbhours: int.tryParse(formData['NbHours'] ?? '0') ?? 0,
                          tags: widget.task!.tags,
                        );
                        
                        context.read<TaskViewModel>().updateTask(widget.task!, updatedTask);
                      } else {
                        final newTask = Task(
                          id: 0,
                          title: formData['Title'] ?? '',
                          description: formData['Description'] ?? '',
                          difficulty: int.tryParse(formData['Difficulty'] ?? '0') ?? 0,
                          nbhours: int.tryParse(formData['NbHours'] ?? '0') ?? 0,
                          tags: [],
                        );
                        
                        context.read<TaskViewModel>().addTask(newTask);
                      }
                      
                      Navigator.pop(context);
                    }
                  },
                  child: Text(isEditing ? "Update Task" : "Add Task"),
                )
              ]
          ),
        ),
      ),
    );

  }
}