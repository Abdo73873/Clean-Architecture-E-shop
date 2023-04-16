import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mena/app/di.dart';
import 'package:mena/domain/model/models.dart';
import 'package:mena/persentation/common/state_renderer/state_renderer_imp.dart';
import 'package:mena/persentation/main/pages/home/viewmodel/home_viewmodel.dart';
import 'package:mena/persentation/resources/color_manager.dart';
import 'package:mena/persentation/resources/strings_manager.dart';
import 'package:mena/persentation/resources/values_manager.dart';

import '../../../../resources/routes_manger.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeViewModel _viewModel = instance<HomeViewModel>();

  void _bind() {
    _viewModel.start();
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
    return StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(context, _getContentWidget(),
              () {
            _viewModel.start();
          })??_getContentWidget();
        });
  }
  Widget _getContentWidget()=>SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _getBannersCarousel(),
        _section(AppStrings.services),
        _getServices(),
        _section(AppStrings.stores),
        _getStores(),
      ],
    ),
  );
  Widget _section(String title)=> Padding(
    padding: const EdgeInsetsDirectional.only(top: AppSize.s16,start: AppSize.s8,bottom: AppSize.s4),
    child: Text(title,style: Theme.of(context).textTheme.labelSmall,),
  );
  Widget _getBannersCarousel()=>StreamBuilder<List<BannerAd>>(
    stream: _viewModel.outputBanners,
      builder:(context, snapshot) => _getBannersWidget(snapshot.data??[]) );

  Widget _getServices()=>StreamBuilder<List<Service>>(
      stream: _viewModel.outputServices,
      builder:(context, snapshot) => _getServicesWidget(snapshot.data??[]) );

  Widget _getStores()=>StreamBuilder<List<Store>>(
      stream: _viewModel.outputStores,
      builder:(context, snapshot) => _getStoresWidget(snapshot.data??[]) );

  Widget _getBannersWidget(List<BannerAd> banners) {
    return CarouselSlider(
        items: banners.map((banner) =>SizedBox(
          width: double.infinity,
          child: Card(
            elevation: AppSize.s1_5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.s12),
              side: const BorderSide(
                color: ColorManager.primary,
                width: AppSize.s1,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSize.s12),
              child: Image.network(banner.image,
              fit: BoxFit.cover,),
            ),
          ),
        ) ).toList(),
        options: CarouselOptions(
          height: AppSize.s190,
          autoPlay: true,
          enableInfiniteScroll: true,
          enlargeCenterPage: true,
        ),
    );
  }

Widget _getServicesWidget(List<Service> services)=>Container(
  margin: const EdgeInsets.symmetric(vertical: AppMargin.m8),
  height: AppSize.s160,
  child: ListView(
    scrollDirection: Axis.horizontal,
    children: services.map((service) => Card(
      elevation: AppSize.s4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s12),
        side: const BorderSide(
          color: ColorManager.primary,
          width: AppSize.s1,
        ),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSize.s12),
            child: Image.network(service.image,
              fit: BoxFit.cover,
              width: AppSize.s120,
              height: AppSize.s120,),
          ),
          Padding(padding: const EdgeInsets.only(top: AppPadding.p8),
            child: Align(
                alignment: AlignmentDirectional.center,
                child: Text(service.title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,)),),
        ],
      ),
    )).toList(),
  ),
);

Widget _getStoresWidget(List<Store> stores)=>Padding(
  padding: const EdgeInsets.all(AppSize.s4),
  child:   Flex(
    direction: Axis.vertical,
    children: [
      GridView.count(
        crossAxisCount: AppSize.ns2,
        crossAxisSpacing: AppSize.s2,
        mainAxisSpacing: AppSize.s2,
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        children: List.generate(stores.length, (index){
          return InkWell(
            onTap: (){
              Navigator.of(context).pushNamed(Routes.storeDetailsRoute);
            },
            child: Card(
              elevation: AppSize.s4,
              child: Image.network(stores[index].image,fit: BoxFit.cover,),
            ),
          );
        }),
      ),
    ],
  ),
);

  }

