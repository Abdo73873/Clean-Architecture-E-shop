import 'dart:async';
import 'dart:ffi';

import 'package:mena/domain/model/models.dart';
import 'package:mena/domain/usecase/home_data_usecase.dart';
import 'package:mena/persentation/base/base_viewmodel.dart';
import 'package:mena/persentation/common/state_renderer/state_renderer.dart';
import 'package:mena/persentation/common/state_renderer/state_renderer_imp.dart';
import 'package:rxdart/rxdart.dart';

class HomeViewModel extends BaseViewModel with HomeViewModelInputs,HomeViewModelOutputs{
  final StreamController _bannerStreamController= BehaviorSubject<List<BannerAd>>();
  final StreamController _servicesStreamController= BehaviorSubject<List<Service>>();
  final StreamController _storesStreamController= BehaviorSubject<List<Store>>();

  final HomeDataUseCase  _homeDataUseCase;

  HomeViewModel(this._homeDataUseCase);

  @override
  void start() {
    _getHomeData();
  }
  @override
  void dispose() {
    _bannerStreamController.close();
    _servicesStreamController.close();
    _storesStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputBanners => _bannerStreamController.sink;

  @override
  Sink get inputServices => _servicesStreamController.sink;

  @override
  Sink get inputStores =>_storesStreamController.sink;

  @override
  Stream<List<BannerAd>> get outputBanners => _bannerStreamController.stream.map((banners) => banners);

  @override
  Stream<List<Service>> get outputServices =>  _servicesStreamController.stream.map((services) => services);

  @override
  Stream<List<Store>> get outputStores => _storesStreamController.stream.map((stores) => stores);

  _getHomeData() async {
   inputState.add( LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState,));
    (await _homeDataUseCase.execute(Void)).fold((failure){
      inputState.add(ErrorState(StateRendererType.fullScreenErrorState, failure.message));
    }, (homeObject){
      inputState.add(ContentState());
      inputBanners.add(homeObject.data.banners);
      inputServices.add(homeObject.data.services);
      inputStores.add(homeObject.data.stores);
    });
  }
}
abstract class HomeViewModelInputs{
  Sink get inputBanners;
  Sink get inputServices;
  Sink get inputStores;
}
abstract class HomeViewModelOutputs{
  Stream<List<BannerAd>> get outputBanners;
  Stream<List<Service>> get outputServices;
  Stream<List<Store>> get outputStores;
}