import 'package:mena/app/constants.dart';
import 'package:mena/app/extantsions.dart';

import '../../domain/model/models.dart';
import '../responses/responses.dart';

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
        this?.name.orEmpty() ?? Constants.empty,
        this?.id.orEmpty() ?? Constants.empty,
        this?.numOfNotification.orZero() ?? Constants.zero);
  }
}

extension ContactResponseMapper on ContactResponse? {
  Contact toDomain() {
    return Contact(
        this?.phone.orEmpty() ?? Constants.empty,
        this?.email.orEmpty() ?? Constants.empty,
        this?.link.orEmpty() ?? Constants.empty);
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(
      this?.customer.toDomain(),
      this?.contacts.toDomain(),
    );
  }
}

extension ForgetPasswordResponseMapper on ForgotPasswordResponse? {
  String toDomain() {
    return this?.support?.orEmpty() ?? Constants.empty;
  }
}

extension ServiceResponseMapper on ServiceResponse? {
  Service toDomain() {
    return Service(
        this?.id.orZero() ?? Constants.zero,
        this?.title.orEmpty() ?? Constants.empty,
        this?.image.orEmpty() ?? Constants.empty);
  }
}

extension StoreResponseMapper on StoreResponse? {
  Store toDomain() {
    return Store(
        this?.id.orZero() ?? Constants.zero,
        this?.title.orEmpty() ?? Constants.empty,
        this?.image.orEmpty() ?? Constants.empty);
  }
}

extension BannerResponseMapper on BannerResponse? {
  BannerAd toDomain() {
    return BannerAd(
      this?.id.orZero() ?? Constants.zero,
      this?.title.orEmpty() ?? Constants.empty,
      this?.image.orEmpty() ?? Constants.empty,
      this?.link.orEmpty() ?? Constants.empty,
    );
  }
}

extension HomeResponseMapper on HomeResponse? {
  HomeObject toDomain() {
    List<Service> services = (this?.data?.services?.map((serviceResponse) =>
        serviceResponse.toDomain())
        ?? const Iterable.empty())
        .cast<Service>()
        .toList();
    List<BannerAd> banners = (this?.data?.banners?.map((bannersResponse) =>
        bannersResponse.toDomain())
        ?? const Iterable.empty())
        .cast<BannerAd>()
        .toList();
    List<Store> stores = (this?.data?.stores?.map((storesResponse) =>
        storesResponse.toDomain())
        ?? const Iterable.empty())
        .cast<Store>()
        .toList();

    HomeData data = HomeData(services, banners, stores);

    return HomeObject(
        this?.status.orZero() ?? Constants.zero,
        this?.message.orEmpty() ?? Constants.empty,
        data
    );
  }
}
