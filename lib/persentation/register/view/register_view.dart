import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mena/app/di.dart';
import 'package:mena/persentation/register/viewmodel/register_viewmodel.dart';
import 'package:mena/persentation/resources/color_manager.dart';

import '../../../app/app_prefs.dart';
import '../../../app/constants.dart';
import '../../common/state_renderer/state_renderer_imp.dart';
import '../../resources/assets_manager.dart';
import '../../resources/routes_manger.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterViewModel _viewModel = instance<RegisterViewModel>();
  final ImagePicker _imagePicker = instance<ImagePicker>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  _bind() {
    _viewModel.start();
    _userNameController
        .addListener(() => _viewModel.setUserName(_userNameController.text));
    _emailController
        .addListener(() => _viewModel.setEmail(_emailController.text));
    _mobileController
        .addListener(() => _viewModel.setMobile(_mobileController.text));
    _passwordController
        .addListener(() => _viewModel.setPassword(_passwordController.text));
    _viewModel.setCountryCode(Constants.defaultCountry);
     _viewModel.isUserRegisteredSuccessfullyStreamController.stream.listen((isRegistered) {
      if(isRegistered){
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
  void dispose() {
    _viewModel.dispose();
    super.dispose();
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
                _viewModel.register();
              }) ??
              _getContentWidget();
        },
      ),
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
                StreamBuilder<String?>(
                  stream: _viewModel.outErrorUserName,
                  builder: (context, snapshot) => TextFormField(
                    keyboardType: TextInputType.name,
                    controller: _userNameController,
                    decoration: InputDecoration(
                      hintText: AppStrings.username.tr(),
                      labelText: AppStrings.username.tr(),
                      errorText: snapshot.data,
                    ),
                  ),
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: CountryCodePicker(
                        onChanged: (country) {
                          _viewModel
                              .setCountryCode(country.dialCode ?? Constants.empty);
                        },
                        initialSelection: "+20",
                        favorite: const ['+39', 'FR',"+966"],
                        showCountryOnly: true,
                        hideMainText: true,
                        showOnlyCountryWhenClosed: true,
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: StreamBuilder<String?>(
                        stream: _viewModel.outErrorMobile,
                        builder: (context, snapshot) => TextFormField(
                          keyboardType: TextInputType.phone,
                          controller: _mobileController,
                          decoration: InputDecoration(
                            hintText: AppStrings.mobileNumber.tr(),
                            labelText: AppStrings.mobileNumber.tr(),
                            errorText: snapshot.data,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                StreamBuilder<String?>(
                  stream: _viewModel.outErrorEmail,
                  builder: (context, snapshot) => TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: AppStrings.email.tr(),
                      labelText: AppStrings.email.tr(),
                      errorText: snapshot.data,
                    ),
                  ),
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                StreamBuilder<String?>(
                  stream: _viewModel.outErrorPassword,
                  builder: (context, snapshot) => TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: _passwordController,
                    decoration: InputDecoration(
                        hintText: AppStrings.password.tr(),
                        labelText: AppStrings.password.tr(),
                        errorText: snapshot.data),
                  ),
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                Container(
                  height: AppSize.s40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s8),
                    border: Border.all(color: ColorManager.gray),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      _showPicker(context);
                    },
                    child: _getMediaWidget(),
                  ),
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                StreamBuilder<bool>(
                  stream: _viewModel.outIAreAllInputValid,
                  builder: (context, snapshot) => SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: (snapshot.data ?? false)
                          ? () {
                              _viewModel.register();
                            }
                          : null,
                      child:  Text(AppStrings.register.tr()),
                    ),
                  ),
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, Routes.loginRoute);
                  },
                  child: Text(
                    AppStrings.alreadyHaveAccount.tr(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _getMediaWidget() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Flexible(
              flex: 2,
                child: Text(AppStrings.profilePicture.tr())),
            Flexible(
              flex: 1,
                child: StreamBuilder<File>(
              stream: _viewModel.outIsProfileImageValid,
              builder: (context, snapshot) => _imagePickedByUser(snapshot.data),
            )),
            Flexible(child: SvgPicture.asset(ImagesManager.camera)),
          ],
        ),
      );

  Widget _imagePickedByUser(File? image) {
    if (image != null && image.path.isNotEmpty) {
      return Image.file(image,);
    }
    return Container();
  }

  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
          child: Wrap(
        children:  [
          ListTile(
            trailing: const Icon(Icons.arrow_forward_ios),
            leading:  const Icon(Icons.camera),
            title:  Text(AppStrings.photoGallery.tr(),),
            onTap: (){
              _imageFromGallery();
              Navigator.pop(context);

            },
          ),
          ListTile(
            trailing: const Icon(Icons.arrow_forward_ios),
            leading:  const Icon(Icons.camera_alt_outlined),
            title:  Text(AppStrings.photoCamera.tr(),),
            onTap: (){
              _imageFromCamera();
              Navigator.pop(context);

            },
          ),
        ],
      )),
    );
  }
  Future<void> _imageFromGallery() async {
    var image =await _imagePicker.pickImage(source: ImageSource.gallery);
    _viewModel.setProfileImage(File(image?.path??Constants.empty));
  }
  Future<void> _imageFromCamera() async {
    var image =await _imagePicker.pickImage(source: ImageSource.camera);
    _viewModel.setProfileImage(File(image?.path??Constants.empty));
  }
}
