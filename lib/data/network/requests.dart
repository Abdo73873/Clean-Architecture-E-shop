 class LoginRequest{
  String email;
  String password;

  LoginRequest(this.email, this.password);
}
 class RegisterRequest {
   String userName;
   String email;
   String countryCode;
   String mobile;
   String password;
   String profileImage;

   RegisterRequest({
     required this.userName,
     required this.email,
     required this.countryCode,
     required this.mobile,
     required this.password,
     required this.profileImage});

 }