

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefUtils{
  static SharedPreferences? _prefs;

  static Future<SharedPreferences?> init() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs;
  }

  static String? readPrefStr(String key) => _prefs!.getString(key);

  static Future<bool> saveStr(String key, String value) async =>
      await _prefs!.setString(key, value);

  static bool isLoggedIn() {
    //print(_prefs!.getString("token"));
    if(_prefs!.getString("token")==null||_prefs!.getString("token") == "")
    {return false;}else{return true;}
  }

  static bool isBusinessAccount() {
    //print(_prefs!.getString("token"));
    if(_prefs!.getString("type")==null)
    {return false;}else{return true;}
  }

  static void setToken(String token) async =>
      await _prefs!.setString("token", token);

  static void setPassword(String password) async =>
      await _prefs!.setString("password", password);

  static void setUserId(String userId) async =>
      await _prefs!.setString("userId", userId);

  static String? getToken() {
    //print(_prefs!.getString("token"));
    return _prefs!.getString("token") == "" ?
    null : _prefs!.getString("token").toString();
  }

  static void setCountryFlag(String flag) async =>
      await _prefs!.setString("flag", flag);

  static void setCountryId(String cid) async =>
      await _prefs!.setString("cid", cid);

  static void setStateId(String sid) async =>
      await _prefs!.setString("sid", sid);

  static void setBusinessType(String bid) async =>
      await _prefs!.setString("bid", bid);

  static void setBusinessTypeName(String bTypeName) async =>
      await _prefs!.setString("bTypeName", bTypeName);

  static void setBusinessName(String bName) async =>
      await _prefs!.setString("bName", bName);

  static void setBusinessPersonName(String bPersonName) async =>
      await _prefs!.setString("bPersonName", bPersonName);

  static void setCityId(String cityId) async =>
      await _prefs!.setString("cityId", cityId);

  // static void setCityId(String cityId) async =>
  //     await _prefs!.setString("cityId", cityId);

  static void setSelectedItem(String select) async =>
      await _prefs!.setString("select", select);

  static void setName(String name) async =>
      await _prefs!.setString("name", name);

  static void setEmail(String email) async =>
      await _prefs!.setString("email", email);

  static void setPhone(String phone) async =>
      await _prefs!.setString("phone", phone);

  static void setWebsiteURL(String url) async =>
      await _prefs!.setString("url", url);

  static void setBusinessPhone(String bPhone) async =>
      await _prefs!.setString("bPhone", bPhone);

  static void setCountry(String country) async =>
      await _prefs!.setString("country", country);

  static void setState(String state) async =>
      await _prefs!.setString("state", state);

  static void setCity(String city) async =>
      await _prefs!.setString("city", city);

  static void setProfilePic(String pp) async =>
      await _prefs!.setString("pp", pp);

  static void setBusinessLogo(String bl) async =>
      await _prefs!.setString("bl", bl);

  static void setPhoneCode(String code) async =>
      await _prefs!.setString("code", code);

  static void setBusinessPhoneCode(String bCode) async =>
      await _prefs!.setString("bCode", bCode);

  static void setAccountType(String type) async =>
      await _prefs!.setString("type", type);

  static String? getAccountType() {
    //print(_prefs!.getString("token"));
    return _prefs!.getString("type") == "" ?
    null : _prefs!.getString("type").toString();
  }

  static String? getName() {
    //print(_prefs!.getString("token"));
    return _prefs!.getString("name") == "" ?
    null : _prefs!.getString("name").toString();
  }

  static String? getUserId() {
    //print(_prefs!.getString("token"));
    return _prefs!.getString("userId") == "" ?
    null : _prefs!.getString("userId").toString();
  }

  static String? getPassword() {
    //print(_prefs!.getString("token"));
    return _prefs!.getString("password") == "" ?
    null : _prefs!.getString("password").toString();
  }

  static String? getBusinessTypeName() {
    //print(_prefs!.getString("token"));
    return _prefs!.getString("bTypeName") == "" ?
    null : _prefs!.getString("bTypeName").toString();
  }

  static String? getWebsiteURL() {
    //print(_prefs!.getString("token"));
    return _prefs!.getString("url") == "" ?
    null : _prefs!.getString("url").toString();
  }

  static String? getBusinessPersonName() {
    //print(_prefs!.getString("token"));
    return _prefs!.getString("bPersonName") == "" ?
    null : _prefs!.getString("bPersonName").toString();
  }

  static String? getBusinessName() {
    //print(_prefs!.getString("token"));
    return _prefs!.getString("bName") == "" ?
    null : _prefs!.getString("bName").toString();
  }

  static String? getBusinessPhone() {
    //print(_prefs!.getString("token"));
    return _prefs!.getString("bPhone") == "" ?
    null : _prefs!.getString("bPhone").toString();
  }

  static String? getBusinessLogo() {
    //print(_prefs!.getString("token"));
    return _prefs!.getString("bl") == "" ?
    null : _prefs!.getString("bl").toString();
  }

  static String? getBusinessType() {
    //print(_prefs!.getString("token"));
    return _prefs!.getString("bid") == "" ?
    null : _prefs!.getString("bid").toString();
  }

  static String? getProfilePic() {
    //print(_prefs!.getString("token"));
    return _prefs!.getString("pp") == "" ?
    null : _prefs!.getString("pp").toString();
  }

  static String? getCity() {
    //print(_prefs!.getString("token"));
    return _prefs!.getString("city") == "" ?
    null : _prefs!.getString("city").toString();
  }

  static String? getPhoneCode() {
    //print(_prefs!.getString("token"));
    return _prefs!.getString("code") == "" ?
    null : _prefs!.getString("code").toString();
  }

  static String? getBusinessPhoneCode() {
    //print(_prefs!.getString("token"));
    return _prefs!.getString("bCode") == "" ?
    null : _prefs!.getString("bCode").toString();
  }

  static String? getPhone() {
    //print(_prefs!.getString("token"));
    return _prefs!.getString("phone") == "" ?
    null : _prefs!.getString("phone").toString();
  }

  static String? getCountry() {
    //print(_prefs!.getString("token"));
    return _prefs!.getString("country") == "" ?
    null : _prefs!.getString("country").toString();
  }

  static String? getState() {
    //print(_prefs!.getString("token"));
    return _prefs!.getString("state") == "" ?
    null : _prefs!.getString("state").toString();
  }

  static String? getEmail() {
    //print(_prefs!.getString("token"));
    return _prefs!.getString("email") == "" ?
    null : _prefs!.getString("email").toString();
  }

  static String? getCountryFlag() {
    //print(_prefs!.getString("token"));
    return _prefs!.getString("flag") == "" ?
    null : _prefs!.getString("flag").toString();
  }

  static String? getCountryId() {
    //print(_prefs!.getString("token"));
    return _prefs!.getString("cid") == "" ?
    null : _prefs!.getString("cid").toString();
  }

  static String? getStateId() {
    //print(_prefs!.getString("token"));
    return _prefs!.getString("sid") == "" ?
    null : _prefs!.getString("sid").toString();
  }

  static String? getCityId() {
    //print(_prefs!.getString("token"));
    return _prefs!.getString("cityId") == "" ?
    null : _prefs!.getString("cityId").toString();
  }

  static String? getSelectedItem() {
    //print(_prefs!.getString("token"));
    return _prefs!.getString("select") == "" ?
    null : _prefs!.getString("select").toString();
  }

  static bool isCountrySelected() {
    if(_prefs!.getString('id') == null || _prefs!.getString('id') == '')
      {return false;} else {return true;}
  }

  static void logOut() async => await _prefs!.clear();


}