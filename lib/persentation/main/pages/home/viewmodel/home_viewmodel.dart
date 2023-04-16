import 'dart:async';
import 'dart:ffi';

import 'package:mena/domain/model/models.dart';
import 'package:mena/domain/usecase/home_data_usecase.dart';
import 'package:mena/persentation/base/base_viewmodel.dart';
import 'package:mena/persentation/common/state_renderer/state_renderer.dart';
import 'package:mena/persentation/common/state_renderer/state_renderer_imp.dart';
import 'package:rxdart/rxdart.dart';

class HomeViewModel extends BaseViewModel with HomeViewModelInputs,HomeViewModelOutputs{
  final StreamController _homeStreamController= BehaviorSubject<HomeObject>();


  final HomeDataUseCase  _homeDataUseCase;

  HomeViewModel(this._homeDataUseCase);

  @override
  void start() {
    _getHomeData();
  }
  @override
  void dispose() {
    _homeStreamController.close();
    super.dispose();
  }

  _getHomeData() async {
   inputState.add( LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState,));
    (await _homeDataUseCase.execute(Void)).fold((failure){
      inputState.add(ErrorState(StateRendererType.fullScreenErrorState, failure.message));
    }, (homeObject){
      inputState.add(ContentState());
      inputHome.add(homeObject);
    });
  }

  @override
  Sink get inputHome => _homeStreamController.sink;

  @override
  Stream<HomeObject> get outputHome => _homeStreamController.stream.map((homeObject) =>homeObject );
}
abstract class HomeViewModelInputs{
  Sink get inputHome;

}
abstract class HomeViewModelOutputs{
  Stream<HomeObject> get outputHome;

}