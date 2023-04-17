class SliderObject {
  String title;
  String subTitle;
  String image;

  SliderObject(this.title, this.subTitle, this.image);
}

class SliderViewObject{
  SliderObject sliderObject;
  int numOfSlides;
  int currentIndex;

  SliderViewObject(this.sliderObject, this.numOfSlides, this.currentIndex);
}

class Customer{
  String id;
  String name;
  int numOfNotification;
  Customer(this.name,this.id,this.numOfNotification);

}
class Contact{
  String phone;
  String email;
  String link;
  Contact(this.phone,this.email,this.link);

}

class Authentication {
  Customer? customer;
  Contact? contacts;
  Authentication(this.customer,this.contacts);


}
class Service{
  int id;
  String title;
  String image;
  Service(this.id, this.title, this.image);

}
class BannerAd{
  int id;
  String title;
  String link;
  String image;
  BannerAd(this.id, this.title, this.image,this.link);

}
class Store{
  int id;
  String title;
  String image;
  Store(this.id, this.title, this.image);

}
class HomeData{
  List<Service> services;
  List<BannerAd> banners;
  List<Store> stores;

  HomeData(this.services, this.banners, this.stores);
}

class HomeObject{
  int status;
  String message;
  HomeData data;

  HomeObject(this.status, this.message, this.data);
}
class StoreDetails{
  int id;
  String title;
  String image;
  String details;
  String services;
  String about;

  StoreDetails(
      this.id, this.title, this.image, this.details, this.services, this.about);
}