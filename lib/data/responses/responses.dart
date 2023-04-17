
import 'package:json_annotation/json_annotation.dart';
part 'responses.g.dart';
@JsonSerializable()
class BaseResponse{
  @JsonKey(name:"status")
  int? status;
  @JsonKey(name:"message")
  String? message;

}
@JsonSerializable()
class CustomerResponse{
  @JsonKey(name:"id")
  String? id;
  @JsonKey(name:"name")
  String? name;
  @JsonKey(name:"numOfNotification")
  int? numOfNotification;
  CustomerResponse(this.name,this.id,this.numOfNotification);

  factory CustomerResponse.fromJson(Map<String,dynamic> json)=>_$CustomerResponseFromJson(json);

  Map<String,dynamic> toJson()=>_$CustomerResponseToJson(this);

}
@JsonSerializable()
class ContactResponse{
  @JsonKey(name:"phone")
  String? phone;
  @JsonKey(name:"email")
  String? email;
  @JsonKey(name:"link")
  String? link;
  ContactResponse(this.phone,this.email,this.link);

  factory ContactResponse.fromJson(Map<String,dynamic> json)=>_$ContactResponseFromJson(json);

  Map<String,dynamic> toJson()=>_$ContactResponseToJson(this);

}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse{
  @JsonKey(name:"customer")
  CustomerResponse? customer;
  @JsonKey(name:"contacts")
  ContactResponse? contacts;
  AuthenticationResponse(this.customer,this.contacts);

  factory AuthenticationResponse.fromJson(Map<String,dynamic> json)=>_$AuthenticationResponseFromJson(json);

  Map<String,dynamic> toJson()=>_$AuthenticationResponseToJson(this);

}

@JsonSerializable()
class ForgotPasswordResponse extends BaseResponse {
  @JsonKey(name: 'support')
  String? support;

  ForgotPasswordResponse(this.support);

// toJson
  Map<String, dynamic> toJson() => _$ForgotPasswordResponseToJson(this);

//fromJson
  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordResponseFromJson(json);
}

@JsonSerializable()
class ServiceResponse{
  @JsonKey(name:"id")
  int? id;
  @JsonKey(name:"title")
  String? title;
  @JsonKey(name:"image")
  String? image;

  ServiceResponse(this.id, this.title, this.image);
  factory ServiceResponse.fromJson(Map<String,dynamic> json)=>_$ServiceResponseFromJson(json);

  Map<String,dynamic> toJson()=>_$ServiceResponseToJson(this);


}

@JsonSerializable()
class BannerResponse{
  @JsonKey(name:"id")
  int? id;
  @JsonKey(name:"title")
  String? title;
  @JsonKey(name:"link")
  String? link;
  @JsonKey(name:"image")
  String? image;

  BannerResponse(this.id, this.title, this.image,this.link);
  factory BannerResponse.fromJson(Map<String,dynamic> json)=>_$BannerResponseFromJson(json);

  Map<String,dynamic> toJson()=>_$BannerResponseToJson(this);


}

@JsonSerializable()
class StoreResponse{
  @JsonKey(name:"id")
  int? id;
  @JsonKey(name:"title")
  String? title;
  @JsonKey(name:"image")
  String? image;

  StoreResponse(this.id, this.title, this.image);
  factory StoreResponse.fromJson(Map<String,dynamic> json)=>_$StoreResponseFromJson(json);

  Map<String,dynamic> toJson()=>_$StoreResponseToJson(this);


}

@JsonSerializable()
class HomeDataResponse{
  @JsonKey(name:"services")
  List<ServiceResponse>? services;
  @JsonKey(name:"banners")
  List<BannerResponse>? banners;
  @JsonKey(name:"stores")
  List<StoreResponse>? stores;

  HomeDataResponse(this.services, this.banners, this.stores);
  factory HomeDataResponse.fromJson(Map<String,dynamic> json)=>_$HomeDataResponseFromJson(json);

  Map<String,dynamic> toJson()=>_$HomeDataResponseToJson(this);

}
@JsonSerializable()
class HomeResponse extends BaseResponse{
  @JsonKey(name:"data")
  HomeDataResponse? data;

  HomeResponse(this.data);
  factory HomeResponse.fromJson(Map<String,dynamic> json)=>_$HomeResponseFromJson(json);

  Map<String,dynamic> toJson()=>_$HomeResponseToJson(this);


}

@JsonSerializable()
class StoreDetailsResponse extends BaseResponse{
  @JsonKey(name:"id")
  int? id;
  @JsonKey(name:"title")
  String? title;
  @JsonKey(name:"image")
  String? image;
  @JsonKey(name:"details")
  String? details;
  @JsonKey(name:"services")
  String? services;
  @JsonKey(name:"about")
  String? about;


  StoreDetailsResponse(
      this.id, this.title, this.image, this.details, this.services, this.about);

  factory StoreDetailsResponse.fromJson(Map<String,dynamic> json)=>_$StoreDetailsResponseFromJson(json);

  Map<String,dynamic> toJson()=>_$StoreDetailsResponseToJson(this);


}
