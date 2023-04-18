import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mena/app/di.dart';
import 'package:mena/persentation/common/state_renderer/state_renderer.dart';
import 'package:mena/persentation/common/state_renderer/state_renderer_imp.dart';
import 'package:mena/persentation/forget_password/viewmodel/forget_passowrd_viewmodel.dart';

import '../../resources/assets_manager.dart';
import '../../resources/routes_manger.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final TextEditingController _emailController = TextEditingController();
  final ForgetPasswordViewModel _viewModel =
      instance<ForgetPasswordViewModel>();
  final _formKey = GlobalKey<FormState>();

  void _bind() {
    _viewModel.start();
    _emailController
        .addListener(() => _viewModel.setEmail(_emailController.text));
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) {
            return snapshot.data?.getScreenWidget(context, _getContentWidget(),
                    () {
                  _viewModel.forgetPassword();
                }) ??
                _getContentWidget();
          }),
    );
  }

  Widget _getContentWidget() => Container(
        padding: const EdgeInsets.only(top: AppPadding.p100),
        margin: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
        color: Colors.white,
        height: double.infinity,
        width: double.infinity,
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
                      hintText: AppStrings.email.tr(),
                      labelText: AppStrings.email.tr(),
                      errorText: (snapshot.data ?? true)
                          ? null
                          : AppStrings.emailError.tr(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                StreamBuilder<bool>(
                  stream: _viewModel.outIsEmailValid,
                  builder: (context, snapshot) => SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: (snapshot.data ?? false)
                          ? () {
                              _viewModel.forgetPassword();
                            }
                          : null,
                      child:  Text(AppStrings.resetPassword.tr()),
                    ),
                  ),
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                TextButton(
                  onPressed:(){
                    Navigator.pushReplacementNamed(context, Routes.registerRoute);
                  },
                  child:  Text(AppStrings.registerText.tr(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),),
              ],
            ),
          ),
        ),
      );
}
