import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../../../bloc/add_note/add_note_bloc.dart';
import 'add_note_editor_bar.dart';
import 'add_note_form.dart';
import 'add_note_markdown_preview.dart';

class AddNoteBody extends StatefulWidget {
  const AddNoteBody({
    Key? key,
  }) : super(key: key);

  @override
  State<AddNoteBody> createState() => _AddNoteBodyState();
}

class _AddNoteBodyState extends State<AddNoteBody> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late ScrollController _scrollController;
  late ImagePicker _picker;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _scrollController = ScrollController();
    _picker = ImagePicker();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    context.read<AddNoteBloc>().add(Clear());
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddNoteBloc, AddNoteState>(listener: (_, state) {
      if (state is AddNoteFormState) {
        if (_descriptionController.text.isEmpty) {
          _descriptionController.text = state.description;
          _titleController.text = state.title;
        }
      }
    }, builder: (_, state) {
      if (state is AddNoteFormState) {
        return Stack(children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            left: 0,
            top: 0.h,
            bottom: 10.h,
            right: state.isPreview ? 55.w : 0,
            child: AddNoteForm(
              state: state,
              scrollController: _scrollController,
              descriptionController: _descriptionController,
              titleController: _titleController,
            ),
          ),
          Positioned(
            bottom: 2.h,
            left: 0,
            right: 0,
            height: 5.h,
            child: AddNoteTextEditorBar(
              controller: _titleController,
              picker: _picker,
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            top: state.isPreview ? 2.h : 0,
            right: state.isPreview ? 1.w : 0,
            height: state.isPreview ? 40.h : 0,
            width: state.isPreview ? 50.w : 0,
            child: AddNoteMarkdownPreview(
              controller: _scrollController,
              data: state.description,
            ),
          ),
        ]);
      } else {
        return Container();
      }
    });
  }
}
