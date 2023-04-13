import 'dart:async';

import 'package:mena/persentation/common/state_renderer/state_renderer_imp.dart';

abstract class BaseViewModel extends BaseViewInputs with BaseViewOutputs {
//shared variable and function that will be used through any view
final StreamController _inputStreamController=StreamController<FlowState>.broadcast();

@override
  void dispose(){
  _inputStreamController.close();
}
@override
  Sink get inputState => _inputStreamController.sink;
@override
  Stream<FlowState> get outputState => _inputStreamController.stream.map((flowState) =>flowState );

}

abstract class BaseViewInputs {
  void start(); //start view model job
  void dispose(); //will be called when view model dies
Sink get inputState;
}

abstract class BaseViewOutputs {
  Stream<FlowState> get outputState;
}
