import 'package:get/get.dart';

class DropDownController extends GetxController{

  var id = '';
  var name = '';


  var listItems = [];
  var emptyList = [];
  List <String> searchList = [];
  List <String> temporaryList = [];
  // List <dynamic> objectList = [];

  filterSearch(String query){
    try{
      searchList = [];
      if(query!=""){
        for (var item in temporaryList) {
          if(item.toLowerCase().contains(query.toLowerCase())){
            searchList.add(item);
          }
        }
      }else{
        searchList.addAll(temporaryList);
        update();
      }
      update();
    }catch(e){
      print(e);
    }
  }

  void filterSearchData(String searchText){
    searchList.clear();
    if(searchText != ""){
      for(int i = 0; i < temporaryList.length; i++){
        String data = temporaryList[i];
        if(data.toLowerCase().contains(searchText.toLowerCase())){
          searchList.add(data);
        }
      }
    }else{
      searchList.addAll(temporaryList);
    }
  }

  onSearchTextChanged(String searchText) async {
    listItems.clear();
    if (searchText.isEmpty) {
      // setState(() {});
      return;
    }

    for (var userDetail in emptyList) {
      if (userDetail.contains(searchText)) {
        listItems.add(userDetail);
      }
    }
    // setState(() {});
  }

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      searchList = temporaryList;
    } else {
      searchList = temporaryList
          .where((user) =>
          user.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    // setState(() {
      searchList = temporaryList;
    // });
  }
}

// 'Honda',
// 'Skoda',
// 'Hyundai',
// 'Mahindra',
// 'Kia',
// 'Toyota',
// 'Maruti',
// 'Fortuner',
// 'Audi',
// 'BMW',
// 'Scorpio',
// 'MG',
// 'Tata',
// 'Lamborghini',
// 'Mercedes',