import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:task_manager/ui/model/Task.dart';
import 'package:task_manager/ui/widgets/loading_indicator_widget.dart';
import 'package:task_manager/ui/widgets/task_item_tile.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  final List<Task> tasks;
  const HomeView({Key? key, required this.tasks}) : super(key: key);

  @override
  void onViewModelReady(HomeViewModel viewModel) {
    viewModel.setUp();
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.onCreateTask,
        child: const Icon(
          Icons.add,
          size: 25,
        ),
      ),
      body: viewModel.isBusy
          ? const Center(child: LoadingIndicatotrWidget())
          : DefaultTabController(
              length: 2, // Two tabs: Active and Done
              child: SafeArea(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: NestedScrollView(
                        headerSliverBuilder: (ctx, status) => [
                              SliverAppBar(
                                title: const Text("My Tasks"),
                                bottom: TabBar(
                                  tabs: [
                                    Tab(
                                        text:
                                            'Active (${viewModel.activeTasks.length})',
                                        icon: const Icon(Icons.local_activity)),
                                    Tab(
                                        text:
                                            'Done (${viewModel.closedTasks.length})',
                                        icon: const Icon(Icons.check_circle)),
                                  ],
                                ),
                              ),
                            ],
                        body: CustomScrollView(
                          slivers: [
                            SliverFillRemaining(
                              child: TabBarView(
                                children: [
                                  RefreshIndicator(
                                    onRefresh: viewModel.onRefresh,
                                    child: ListView.builder(
                                        itemCount: viewModel.activeTasks.length,
                                        itemBuilder: (ctx, index) =>
                                            TaskItemTile(
                                                onDelete:
                                                    viewModel.onDeleteTask,
                                                onEdit: viewModel.onEdit,
                                                task: viewModel
                                                    .activeTasks[index])),
                                  ),
                                  ListView.builder(
                                      itemCount: viewModel.closedTasks.length,
                                      itemBuilder: (ctx, index) => TaskItemTile(
                                          onDelete: viewModel.onDeleteTask,
                                          onEdit: viewModel.onEdit,
                                          task: viewModel.closedTasks[index]))
                                ],
                                // ListView.builder(
                                //     itemCount: viewModel.groupedTasksByStatus.length,
                                //     itemBuilder: (ctx, catIndex) => Column(
                                //           crossAxisAlignment: CrossAxisAlignment.start,
                                //           children: [
                                //             Text(viewModel
                                //                 .groupedTasksByStatus[catIndex].key),
                                //             ...List<TaskItemTile>.generate(
                                //                 viewModel.groupedTasksByStatus[catIndex]
                                //                     .value.length, (index) {
                                //               return ;
                                //             })
                                //           ],
                                //         )),
                              ),
                            )
                          ],
                        ))),
              ),
            ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel(tasks: tasks);
}
