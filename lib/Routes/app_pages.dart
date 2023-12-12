import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:kawawa_motors/CMS/about_us.dart';
import 'package:kawawa_motors/CMS/terms_and_condition.dart';
import 'package:kawawa_motors/Get%20In%20Touch/get_in_touch.dart';
import 'package:kawawa_motors/Home/Vehicle%20Types/vehicle_type_lists.dart';
import 'package:kawawa_motors/Home/home.dart';
import 'package:kawawa_motors/Live%20Chat/Chat%20Page/chat_page.dart';
import 'package:kawawa_motors/Live%20Chat/live_chat.dart';
import 'package:kawawa_motors/Screen/Authentication/forgot_password.dart';
import 'package:kawawa_motors/Screen/Authentication/login.dart';
import 'package:kawawa_motors/Screen/Authentication/register.dart';
import 'package:kawawa_motors/Screen/Authentication/reset_password.dart';
import 'package:kawawa_motors/Screen/Broadcast/broadcast.dart';
import 'package:kawawa_motors/Screen/Broadcast/create_broadcast.dart';
import 'package:kawawa_motors/Screen/Dashboard/Favourite/favourite.dart';
import 'package:kawawa_motors/Screen/Dashboard/Private%20Profile/change_password.dart';
import 'package:kawawa_motors/Screen/Dashboard/Sell/Add/add_garage.dart';
import 'package:kawawa_motors/Screen/Dashboard/Sell/Add/add_spare_parts.dart';
import 'package:kawawa_motors/Screen/Dashboard/Sell/Add/add_vehicle.dart';
import 'package:kawawa_motors/Screen/Dashboard/Sell/Garage/sell_garage.dart';
import 'package:kawawa_motors/Screen/Dashboard/Sell/Spare%20Parts/sell_spare_parts.dart';
import 'package:kawawa_motors/Screen/Dashboard/Sell/Vehicle/sell_vehicle.dart';
import 'package:kawawa_motors/Screen/Dashboard/Sell/sell.dart';
import 'package:kawawa_motors/Screen/Dashboard/business_profile.dart';
import 'package:kawawa_motors/Screen/Details/dealer_details.dart';
import 'package:kawawa_motors/Screen/Details/details_vehicle.dart';
import 'package:kawawa_motors/Screen/Details/details_garage.dart';
import 'package:kawawa_motors/Screen/Details/details_spare_parts.dart';
import 'package:kawawa_motors/Screen/My%20Enquiry/my_enquiry.dart';
import 'package:kawawa_motors/Screen/Notification/notification.dart';
import 'package:kawawa_motors/Search/More%20Filter/more_filter_spare_parts.dart';
import 'package:kawawa_motors/Search/More%20Filter/more_filter_vehicle.dart';
import 'package:kawawa_motors/Search/search.dart';
import 'package:kawawa_motors/See%20All/See%20All%20Dealer/see_all_dealer.dart';
import 'package:kawawa_motors/See%20All/See%20All%20Garage/searched_repair_garage.dart';
import 'package:kawawa_motors/See%20All/See%20All%20Garage/see_all_repair_garage.dart';
import 'package:kawawa_motors/See%20All/See%20All%20Vehicle/see_all_vehicle.dart';
import 'package:kawawa_motors/dashboard.dart';
import '../CMS/privacy_policy.dart';
import '../Screen/Broadcast/My Broadcast/my_broadcast.dart';
import '../Screen/Dashboard/Favourite/Wishlist/Car/wishlist_car.dart';
import '../Screen/Dashboard/Favourite/Wishlist/Garage/wishlist_garage.dart';
import '../Screen/Dashboard/Favourite/Wishlist/Spare Parts/wishlist_sp.dart';
import '../Screen/Details/Dealer service/dealer_services.dart';
import '../Screen/Intro/intro.dart';
import '../Screen/Splash/splash_screen.dart';
import '../See All/See All Spare Parts/see_all_spare_parts.dart';
import 'app_route.dart';

class AppPages{
  static List<GetPage> routes = [

  GetPage(
  name: AppRoute.splashScreen,
  page: () => SplashScreen(),
  transition: Transition.fade,
  transitionDuration: const Duration(seconds: 1)),

    GetPage(
        name: AppRoute.intro,
        transition: Transition.noTransition,
        page: () =>  Intro()),

    GetPage(
        name: AppRoute.login,
        transition: Transition.noTransition,
        page: () =>  Login()),

    GetPage(
        name: AppRoute.forgotPass,
        transition: Transition.noTransition,
        page: () =>  ForgotPassword()),

    GetPage(
        name: AppRoute.resetPass,
        transition: Transition.noTransition,
        page: () =>  ResetPassword()),

    GetPage(
        name: AppRoute.register,
        transition: Transition.noTransition,
        page: () =>  Register()),

    GetPage(
        name: AppRoute.dashBoard,
        transition: Transition.noTransition,
        page: () =>  DashBoard()),

    GetPage(
        name: AppRoute.changePass,
        transition: Transition.noTransition,
        page: () =>  ChangePassword()),

    GetPage(
        name: AppRoute.businessProfile,
        transition: Transition.noTransition,
        page: () =>  BusinessProfile()),

    GetPage(
        name: AppRoute.wishlistCar,
        transition: Transition.noTransition,
        page: () =>  WishListCar()),

    GetPage(
        name: AppRoute.wishlistSP,
        transition: Transition.noTransition,
        page: () =>  WishListSP()),

    GetPage(
        name: AppRoute.wishlistGarage,
        transition: Transition.noTransition,
        page: () =>  WishlistGarage()),

    GetPage(
        name: AppRoute.notification,
        transition: Transition.noTransition,
        page: () =>  Notificationn()),

    GetPage(
        name: AppRoute.myBroadcast,
        transition: Transition.noTransition,
        page: () =>  MyBroadcast()),

    GetPage(
        name: AppRoute.sellCar,
        transition: Transition.noTransition,
        page: () =>  SellVehicle()),

    GetPage(
        name: AppRoute.sellSP,
        transition: Transition.noTransition,
        page: () =>  SellSP()),

    GetPage(
        name: AppRoute.sellGarage,
        transition: Transition.noTransition,
        page: () =>  SellGarage()),

    GetPage(
        name: AppRoute.addCar,
        transition: Transition.noTransition,
        page: () =>  AddVehicle()),

    GetPage(
        name: AppRoute.addGarage,
        transition: Transition.noTransition,
        page: () =>  AddGarage()),

    GetPage(
        name: AppRoute.addSP,
        transition: Transition.noTransition,
        page: () =>  AddSpareParts()),

    GetPage(
        name: AppRoute.carDetails,
        transition: Transition.noTransition,
        page: () =>  VehicleDetails()),

    GetPage(
        name: AppRoute.spDetails,
        transition: Transition.noTransition,
        page: () =>  SPDetails()),

    GetPage(
        name: AppRoute.garageDetails,
        transition: Transition.noTransition,
        page: () =>  GarageDetails()),

    GetPage(
        name: AppRoute.dealerDetails,
        transition: Transition.noTransition,
        page: () =>  DealerDetails()),

    GetPage(
        name: AppRoute.createBroadcast,
        transition: Transition.noTransition,
        page: () =>  CreateBroadcast()),

    GetPage(
        name: AppRoute.getInTouch,
        transition: Transition.noTransition,
        page: () =>  GetInTouch()),

    GetPage(
        name: AppRoute.aboutUs,
        transition: Transition.noTransition,
        page: () =>  AboutUs()),

    GetPage(
        name: AppRoute.termsCondition,
        transition: Transition.noTransition,
        page: () =>  TermsAndCondition()),

    GetPage(
        name: AppRoute.privacyPolicy,
        transition: Transition.noTransition,
        page: () =>  PrivacyPolicy()),

    GetPage(
        name: AppRoute.sell,
        transition: Transition.noTransition,
        page: () =>  Sell()),

    GetPage(
        name: AppRoute.favourite,
        transition: Transition.noTransition,
        page: () =>  Favourite()),

    GetPage(
        name: AppRoute.seeAllVehicle,
        transition: Transition.noTransition,
        page: () =>  SeeAllVehicle()),

    GetPage(
        name: AppRoute.seeAllSP,
        transition: Transition.noTransition,
        page: () =>  SeeAllSP()),

    GetPage(
        name: AppRoute.seeAllRG,
        transition: Transition.noTransition,
        page: () =>  SeeAllRepairGarage()),

    GetPage(
        name: AppRoute.seeAllDealer,
        transition: Transition.noTransition,
        page: () =>  SeeAllDealer()),

    GetPage(
        name: AppRoute.search,
        transition: Transition.noTransition,
        page: () =>  SearchTabPage()),

    GetPage(
        name: AppRoute.searchVehicle,
        transition: Transition.noTransition,
        page: () =>  MoreFilterVehicle()),

    GetPage(
        name: AppRoute.searchSP,
        transition: Transition.noTransition,
        page: () =>  MoreFilterSpareParts()),

    GetPage(
        name: AppRoute.broadcast,
        transition: Transition.noTransition,
        page: () =>  Broadcast()),

    GetPage(
        name: AppRoute.liveChat,
        transition: Transition.noTransition,
        page: () =>  LiveChat()),

    GetPage(
        name: AppRoute.chatPage,
        transition: Transition.noTransition,
        page: () =>  ChatPage()),

    GetPage(
        name: AppRoute.myEnquiry,
        transition: Transition.noTransition,
        page: () =>  MyEnquiry()),

    GetPage(
        name: AppRoute.vType,
        transition: Transition.noTransition,
        page: () =>  VehicleTypeList()),

    GetPage(
        name: AppRoute.searchedGarage,
        transition: Transition.noTransition,
        page: () =>  SearchedGarage()),

    GetPage(
        name: AppRoute.dealerService,
        transition: Transition.noTransition,
        page: () =>  DealerServices()),
  ];
}