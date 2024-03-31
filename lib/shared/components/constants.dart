import 'package:path/path.dart';

import '../../modules/shop_app/login/shop_login_screen.dart';
import '../Network/local/cache_helper.dart';
import 'components.dart';

void signout (context){
  CasheHelper.removeData(key: 'token').then((value) {
    if(value!){
      navigateTo(context, ShopLoginScreen());
    }
  });
}
void PrintFullText (String text)
{
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
String token ='';
String uId ='';