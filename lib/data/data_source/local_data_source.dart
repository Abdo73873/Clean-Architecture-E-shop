import 'package:mena/data/network/error_handler.dart';

import '../responses/responses.dart';

const String CACHE_HOME_KEY="CACHE_HOME_KEY";
const String CACHE_STORE_DETAILS_KEY="CACHE_STORE_DETAILS_KEY";
const int CACHE_HOME_INTERNAL=60*1000;
abstract class LocalDataSource{
  Future<HomeResponse> getHomeData();
  Future<void>saveHomeDataToCache(HomeResponse homeResponse);

  StoreDetailsResponse getStoreDetailsData();
  Future<void>saveStoreDetailsDataToCache(StoreDetailsResponse storeDetailsResponse);


  void removeFromCache(String key);
  void clearCache( );
}

class LocalDataSourceImp implements LocalDataSource{
  //runtime cache
  Map<String,CachedItem> cacheMap=Map();
  @override
  Future<HomeResponse> getHomeData() async {
  CachedItem? cacheItem= cacheMap[CACHE_HOME_KEY];
  if(cacheItem!=null&&cacheItem.isValid(CACHE_HOME_INTERNAL)){
    return cacheItem.data;
  }else{
    throw ErrorHandler.handle(DataSource.CACHE_ERROR);
  }
  }

  @override
  Future<void> saveHomeDataToCache(HomeResponse homeResponse) async {
   cacheMap[CACHE_HOME_KEY]=CachedItem(homeResponse);
  }

  @override
  void clearCache() {
    cacheMap.clear();
  }

  @override
  void removeFromCache(String key) {
   cacheMap.remove(key);
  }

  @override
  StoreDetailsResponse getStoreDetailsData() {
    CachedItem? cacheItem= cacheMap[CACHE_STORE_DETAILS_KEY];
    if(cacheItem!=null&&cacheItem.isValid(CACHE_HOME_INTERNAL)){
      return cacheItem.data;
    }else{
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveStoreDetailsDataToCache(StoreDetailsResponse storeDetailsResponse)async {
    cacheMap[CACHE_STORE_DETAILS_KEY]=CachedItem(storeDetailsResponse);

  }

}
class CachedItem{
  dynamic data;
  int cacheTime=DateTime.now().millisecondsSinceEpoch;

  CachedItem(this.data);
}

extension CachedItemExtension on CachedItem{
  bool isValid(int expireTimeInMilliS){
    int currentTimeInMilliS=DateTime.now().millisecondsSinceEpoch;
    return currentTimeInMilliS-cacheTime<=expireTimeInMilliS;
  }
}