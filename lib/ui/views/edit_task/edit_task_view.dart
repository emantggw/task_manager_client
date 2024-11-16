import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:task_manager/ui/common/dimention.dart';
import 'package:task_manager/ui/model/Task.dart';
import 'package:task_manager/ui/widgets/loading_indicator_widget.dart';
import 'package:task_manager/ui/widgets/text_feild_widget.dart';

import 'edit_task_viewmodel.dart';

class EditTaskView extends StackedView<EditTaskViewModel> {
  final Task task;
  const EditTaskView({Key? key, required this.task}) : super(key: key);

  @override
  void onViewModelReady(EditTaskViewModel viewModel) {
    viewModel.setUp();
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(
    BuildContext context,
    EditTaskViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: viewModel.isBusy
          ? Container()
          : FloatingActionButton.extended(
              onPressed: viewModel.onEdit,
              label: const Text("Submit"),
            ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: NestedScrollView(
              headerSliverBuilder: (ctx, status) => [
                    const SliverAppBar(
                      automaticallyImplyLeading: false,
                      title: Text("Edit task"),
                    ),
                  ],
              body: viewModel.isBusy
                  ? const Center(
                      child: LoadingIndicatotrWidget(),
                    )
                  : CustomScrollView(
                      slivers: [
                        SliverFillRemaining(
                          child: Form(
                            key: viewModel.formKey,
                            child: SingleChildScrollView(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Title"),
                                    TextFieldWidget(
                                      controller: viewModel.titleController,
                                      validator: viewModel.textValidator,
                                      hintText: "Title",
                                    ),
                                    kdSpace.height,
                                    const Text("Description"),
                                    TextFieldWidget(
                                      hintText: "Description",
                                      controller:
                                          viewModel.descriptionController,
                                      validator: viewModel.textValidator,
                                      enableMultiLine: true,
                                      textInputType: TextInputType.multiline,
                                    ),
                                    kdSpace.height,
                                    const Text("Category"),
                                    TextFieldWidget(
                                      hintText: "Category",
                                      controller: viewModel.categoryController,
                                      validator: viewModel.textValidator,
                                    ),
                                    kdSpace.height,
                                    const Text("Is Done?"),
                                    Switch(
                                        value: viewModel.isDone,
                                        onChanged: viewModel.onDoneToggler)
                                  ]),
                            ),
                          ),
                        )
                      ],
                    ))),
    );
  }

  @override
  EditTaskViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      EditTaskViewModel(task: task);
}
