import 'package:flutter/material.dart';
import 'package:mena/domain/model/models.dart';
import 'package:mena/persentation/store_details/viewmodel/store_details_viewmodel.dart';

import '../../../app/di.dart';
import '../../common/state_renderer/state_renderer_imp.dart';

class StoreDetailsView extends StatefulWidget {
  const StoreDetailsView({Key? key}) : super(key: key);

  @override
  State<StoreDetailsView> createState() => _StoreDetailsViewState();
}

class _StoreDetailsViewState extends State<StoreDetailsView> {
  final StoreDetailsViewModel _viewModel = instance<StoreDetailsViewModel>();

  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(context, _getContentWidget(),
                  () {
                _viewModel.start();
              }) ??
              _getContentWidget();
        },
      ),
    );
  }

  Widget _getContentWidget() => SingleChildScrollView(
    child: StreamBuilder<StoreDetails>(
        stream: _viewModel.outputStoreDetails,
        builder: (context, snapshot) {
          return snapshot.data != null
              ? Column(
                  children: [
                    Image.network(snapshot.data!.image),
                    Text(snapshot.data!.title),
                    Text(snapshot.data!.details),
                    Text(snapshot.data!.services),
                    Text(snapshot.data!.about),
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        }),
  );
}
