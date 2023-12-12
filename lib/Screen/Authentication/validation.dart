class Validation {
  static String? nameValidation(String value,{String msg="Name can't be empty"}) {
    String pattern = r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$";
    // RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return msg;
    }
    // else if (!regExp.hasMatch(pattern)) {
    //   return "Please enter a valid full name";
    // }
    return null;
  }

  static String? emailValidation(String value) {
    String pattern =
        r"^[a-z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (!value.isEmpty) {
      if (!value.contains('@') || !value.contains('.com')){
        return "Please enter a valid email";
      }
      // if (!regex.hasMatch(value) || value == null)
      //   return 'Enter a valid email';
      // else
      //   return null;
    } else {
      return "Email can't be empty";
    }
  }

  static String? passwordValidation(String value){
    if(value.isEmpty){
      return "Password can't be empty";
    }else if(value.length < 8){
      return "Password length must be atleast 8 characters";
    }else{
      return null;
    }
  }

  static  String? confirmPasswordValidation(String value, String value2, String type) {
    // (?=.*[A-Z])       // should contain at least one upper case
    // (?=.*[a-z])       // should contain at least one lower case
    // (?=.*?[0-9])      // should contain at least one digit
    // (?=.*?[!@#\$&*~]) // should contain at least one Special character
    // .{8,}             // Must be at least 8 characters in length
    if (type != "normal") {
      // RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
      RegExp uperCase = RegExp(r'(?=.*[A-Z])');
      RegExp lowerCase = RegExp(r'(?=.*[a-z])');
      RegExp number = RegExp(r'(?=.*?[0-9])');
      RegExp length = RegExp(r'.{6,}$');
      if (value.isEmpty) {
        return "Password can't be empty!";
      }
      // else if (!uperCase.hasMatch(value)) {
      //   return 'Must contain atlist 1 in Capital Case!';
      // } else if (!lowerCase.hasMatch(value)) {
      //   return 'Must contain atlist 1 in Small Case!';
      // } else if (!number.hasMatch(value)) {
      //   return 'Must contain atlist 1 Number!';
      // } else
      if (!length.hasMatch(value)) {
        return 'must be atleast 6 characters! ';
      } else
      if (value2 != value) {
        return "Password doesn't match";
      } else
        return null;
    } else {
      if (value.isEmpty) {
        return "Password can't be empty";
      }
    }
  }

  static String? phoneValidation(String value) {
    if (!value.isEmpty) {
      if (value.length < 10 || value.length > 12) {
        return "Enter a valid number";
      } else {
        return null;
      }
    } else {
      return "Phone number can't be empty";
    }
  }

  static String? mobileValidation(String value, String value2) {
    print("Value>>>"+value);
    print("Value2>>>"+value2);
    if (!value.isEmpty) {
      if (value.length < 10 || value.length > 12) {
        return "Enter a valid number";
      }
      else if (value2 != value) {
        return "Mobile number doesn't match";
      } else {
        return null;
      }
    }else {
      return "Mobile number can't be empty";
    }
  }

  static String? normalValidation(String value) {
    if (!value.isEmpty) {
      return null;
    } else {
      return "Field can't be empty";
    }
  }

  static String? normalValidation2(String value) {
    if (!value.isEmpty) {
      return null;
    } else {
      return null;
    }
  }

}