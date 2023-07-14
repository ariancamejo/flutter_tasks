import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_tasks/data/const.dart';

import 'package:my_tasks/presentation/blocs/dash/dash_bloc.dart';
import 'package:my_tasks/presentation/widgets/error/error.dart';


class OperationCount extends StatelessWidget {
  const OperationCount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashBloc, DashState>(builder: (ctx, state) {
      switch (state.runtimeType) {
        case DashInitialState:
          return _buildLoadingState();

        case DashReadyState:
          return _buildReadyState(state as DashReadyState);

        case DashErrorState:
          return buildErrorState(context, state as DashErrorState);

        case DashUnknownErrorState:
          return buildUnknownErrorState(context, state as DashUnknownErrorState);

        default:
          return _buildLoadingState();
      }
    });
  }

  _buildLoadingState() => const Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      );

  _buildReadyState(DashReadyState state) {
    return SingleChildScrollView(
      child: Column(
        children: nameCounters.map(
          (e) {
            int index = state.list.indexWhere((element) => element.name == e['name']);
            int operationCounts = 0;
            if (index != -1) {
              operationCounts = state.list[index].count;
            }

            return Card(
              child: ListTile(
                title: Text(e['name']),
                subtitle: Text("Operations: $operationCounts"),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}