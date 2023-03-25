abstract class BaseViewModel extends BaseViewInputs with BaseViewOutputs{
//shared variable and function that will be used through any view
}

abstract class BaseViewInputs{
  void start(); //start view model job
void dispose();//will be called when view model dies

}
abstract class BaseViewOutputs{

}