import 'package:untitled/models/shop_app/change_favorites_model.dart';
import 'package:untitled/models/shop_app/login_model.dart';

abstract class ShopStates {}
class ShopInitialState extends ShopStates {}
class ShopChangeBottomNavState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}
class ShopSuccessHomeDataState extends ShopStates {}
class ShopErrorHomeDataState extends ShopStates {}

class ShopLoadingCategoriesDataState extends ShopStates {}
class ShopSuccesCategoriesDataState extends ShopStates {}
class ShopErrorCategoriesDataState extends ShopStates {}

class ShopLoadingChangeFavoritesState extends ShopStates {}
class ShopSuccessChangeFavoritesState extends ShopStates {
  final ChangeFavoritesModel model;
  ShopSuccessChangeFavoritesState(this.model);
}
class ShopErrorChangeFavoritesState extends ShopStates {}

class ShopLoadingGetFavoritesState extends ShopStates {}
class ShopSuccesGetFavoritesState extends ShopStates {}
class ShopErrorGetFavoritesState extends ShopStates {}

class ShopLoadingUserDataState extends ShopStates {}
class ShopSuccesUserDataState extends ShopStates {
  final ShopLoginModel? loginModel;

  ShopSuccesUserDataState(this.loginModel);
}
class ShopErrorUserDataState extends ShopStates {}

class ShopLoadingUpdateUserState extends ShopStates {}
class ShopSuccesUpdateUserState extends ShopStates {
  final ShopLoginModel? loginModel;

  ShopSuccesUpdateUserState(this.loginModel);
}
class ShopErrorUpdateUserState extends ShopStates {}


