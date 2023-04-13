import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mena/app/di.dart';
import 'package:mena/domain/repository/repository.dart';
import 'package:mena/domain/usecase/login_usecase.dart';
import 'package:mena/persentation/common/state_renderer/state_renderer_imp.dart';
import 'package:mena/persentation/login/view_model/login_viewmodel.dart';
import 'package:mena/persentation/resources/assets_manager.dart';
import 'package:mena/persentation/resources/strings_manager.dart';
import 'package:mena/persentation/resources/values_manager.dart';

import '../../../app/app_prefs.dart';
import '../../resources/routes_manger.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  final LoginViewModel _viewModel = instance<LoginViewModel>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  _bind() {
    _viewModel.start();
    _emailController
        .addListener(() => _viewModel.setEmail(_emailController.text));
    _passwordController
        .addListener(() => _viewModel.setPassword(_passwordController.text));
    _viewModel.isLoginSuccessfullyStreamController.stream.listen((isLoggedIn) {
      if(isLoggedIn){
        instance<AppPreferences>().setUserLoggedIn();
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacementNamed(context, Routes.mainRoute);
        });
      }
    });
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
        builder: (context, snapshot){
          return snapshot.data?.getScreenWidget(context, _getContentWidget(), (){
            _viewModel.login();
          })??_getContentWidget();
        },
      ),
    );
  }

  Widget _getContentWidget() => Container(
    padding: const EdgeInsets.only(top: AppPadding.p100),
    margin: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
    color: Colors.white,
    height: double.infinity,
    child: SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Image.asset(ImagesManager.splashLogo),
            const SizedBox(
              height: AppSize.s20,
            ),
            StreamBuilder<bool>(
              stream: _viewModel.outIsEmailValid,
              builder: (context, snapshot) => TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: AppStrings.email,
                  labelText: AppStrings.email,
                  errorText: (snapshot.data ?? true)
                      ? null
                      : AppStrings.emailError,
                ),
              ),
            ),
            const SizedBox(
              height: AppSize.s20,
            ),
            StreamBuilder<bool>(
              stream: _viewModel.outIsPasswordValid,
              builder: (context, snapshot) => TextFormField(
                keyboardType: TextInputType.visiblePassword,
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: AppStrings.password,
                  labelText: AppStrings.password,
                  errorText: (snapshot.data ?? true)
                      ? null
                      : AppStrings.passwordError,
                ),
              ),
            ),
            const SizedBox(
              height: AppSize.s20,
            ),
            StreamBuilder<bool>(
              stream: _viewModel.outputAreAllInputsValid,
              builder: (context, snapshot) => SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (snapshot.data ?? false)
                      ? () {
                    _viewModel.login();
                  }
                      : null,
                  child: const Text(AppStrings.login),
                ),
              ),
            ),
            const SizedBox(
              height: AppSize.s20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed:(){
                    Navigator.pushNamed(context, Routes.forgotPasswordRoute);

                  },
                  child:  Text(AppStrings.forgetPassword,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),),
                TextButton(
                  onPressed:(){
                    Navigator.pushReplacementNamed(context, Routes.registerRoute);
                  },
                  child:  Text(AppStrings.registerText,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),),
              ],
            ),
          ],
        ),
      ),
    ),
  );

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
