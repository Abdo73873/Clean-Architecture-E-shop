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
    return Authentication(this?.customer.toDomain(), this?.contacts.toDomain(),);
  }
}
extension ForgetPasswordResponseMapper on ForgotPasswordResponse?{
  String toDomain(){
    return this?.support?.orEmpty()?? Constants.empty;
  }
}