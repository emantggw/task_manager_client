import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:task_manager/ui/common/dimention.dart';
import 'package:task_manager/ui/widgets/loading_indicator_widget.dart';
import 'package:task_manager/ui/widgets/text_feild_widget.dart';

import 'create_task_viewmodel.dart';

class CreateTaskView extends StackedView<CreateTaskViewModel> {
  const CreateTaskView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CreateTaskViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: viewModel.isBusy
          ? Container()
          : FloatingActionButton.extended(
              onPressed: viewModel.onSubmit, label: const Text("Submit")),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: NestedScrollView(
              headerSliverBuilder: (ctx, status) => [
                    const SliverAppBar(
                      automaticallyImplyLeading: false,
                      expandedHeight: 200,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Center(
                          child: Text(
                            "Okay, Let's create your task",
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                      ),
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
                              child: Column(children: [
                                TextFieldWidget(
                                  controller: viewModel.titleController,
                                  hintText: "Title",
                                  validator: viewModel.textValidator,
                                ),
                                kdSpace.height,
                                TextFieldWidget(
                                  controller: viewModel.descriptionController,
                                  validator: viewModel.textValidator,
                                  hintText: "Description",
                                  enableMultiLine: true,
                                  textInputType: TextInputType.multiline,
                                ),
                                kdSpace.height,
                                TextFieldWidget(
                                  controller: viewModel.categoryController,
                                  validator: viewModel.textValidator,
                                  hintText: "Category",
                                ),
                                kdSpace.height,
                              ]),
                            ),
                          ),
                        )
                      ],
                    ))),
    );
  }

  @override
  CreateTaskViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      CreateTaskViewModel();
}
