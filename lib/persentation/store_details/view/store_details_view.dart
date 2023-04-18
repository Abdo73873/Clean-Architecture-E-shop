import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mena/app/extantsions.dart';
import 'package:mena/domain/model/models.dart';
import 'package:mena/persentation/resources/color_manager.dart';
import 'package:mena/persentation/resources/strings_manager.dart';
import 'package:mena/persentation/store_details/viewmodel/store_details_viewmodel.dart';

import '../../../app/di.dart';
import '../../common/state_renderer/state_renderer_imp.dart';
import '../../resources/values_manager.dart';

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
      appBar: AppBar(
        backgroundColor: ColorManager.primary,
        centerTitle: true,
        title: Text(
          AppStrings.storeDetails.tr(),
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
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
                  ? Padding(
                      padding: const EdgeInsets.all(AppPadding.p16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            snapshot.data!.image,
                          fit: BoxFit.cover,
                            width: double.infinity,
                            height: AppSize.s160,
                          ),
                          AppSize.s8.sh,
                          Align(
                            alignment: AlignmentDirectional.center,
                              child: Text(
                            snapshot.data!.title,
                            textAlign: TextAlign.center,
                          )),
                          _section(AppStrings.details.tr()),
                          Text(snapshot.data!.details.tr()),
                          _section(AppStrings.services.tr()),
                          Text(snapshot.data!.services.tr()),
                          _section(AppStrings.about.tr()),
                          Text(snapshot.data!.about.tr()),
                        ],
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    );
            }),
      );

  Widget _section(String title) => Padding(
        padding: const EdgeInsetsDirectional.only(
            top: AppSize.s20, start: AppSize.s8, bottom: AppSize.s8),
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      );
}
