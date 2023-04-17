import 'dart:async';
import 'dart:ffi';

import 'package:mena/domain/model/models.dart';
import 'package:mena/domain/usecase/store_details.dart';
import 'package:mena/persentation/base/base_viewmodel.dart';
import 'package:rxdart/rxdart.dart';

import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_imp.dart';

class StoreDetailsViewModel extends BaseViewModel
    with StoreDetailsViewModelInputs, StoreDetailsViewModelOutputs {
  final StoreDetailsUseCase _storeDetailsUseCase;

  StoreDetailsViewModel(this._storeDetailsUseCase);

  final StreamController _streamController = BehaviorSubject<StoreDetails>();

  @override
  void start() {
    _getData();
  }
  @override
  void dispose() {
    super.dispose();
    _streamController.close();
  }

  @override
  Sink get inputStoreDetails => _streamController.sink;

  @override
  Stream<StoreDetails> get outputStoreDetails => _streamController.stream.map((event) => event);

  _getData() async {
    inputState.add(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));

    ( await _storeDetailsUseCase
       .execute(Void))
       .fold((failure){
     inputState.add(ErrorState(StateRendererType.fullScreenErrorState, failure.message));
   }, (storeDetails){
     inputState.add(ContentState());
     inputStoreDetails.add(storeDetails);
   });

  }
}

abstract class StoreDetailsViewModelInputs {
  Sink get inputStoreDetails;
}

abstract class StoreDetailsViewModelOutputs {
  Stream<StoreDetails> get outputStoreDetails;
}