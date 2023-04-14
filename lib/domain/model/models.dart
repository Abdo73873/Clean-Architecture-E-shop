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
/*
class ForgetPassword{
  int status;
  String message;
  String support;

  ForgetPassword(this.status, this.message, this.support);
}*/
