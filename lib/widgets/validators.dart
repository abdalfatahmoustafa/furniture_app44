String ? emailValidator(String? val){
  var email = "tony123_90874.coder@yahoo.co.in";
  bool emailValid = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(val!);
  if(emailValid){
    return null;
  }else{
    return "Invalid Email";
  }
}
String ? passwordValidator(String? val){
  if(val!.length > 8){
    return null;
  }else{
    return "Invalid Password";
  }
}
String ? nameValidator(String ?val){
  if(val!.trim().length > 8){
    return null;
  }else{
    return "Invalid Name";
  }
}
String ? phoneValidator(String? val){
  if(RegExp(r'[0-9]{8}').hasMatch(val!)){
    return null;
  }else{
    return "Invalid Phone Number";
  }
}
String ? pricePerKiloValidator(String ?val){
  if(RegExp(r'[0-9]{2}').hasMatch(val!)){
    return null;
  }else{
    return "Invalid Price";
  }
}String ? carNumberValidator(String ?val){
  if(RegExp(r'[0-9]{4}').hasMatch(val!)){
    return null;
  }else{
    return "Invalid Car Number";
  }
}
