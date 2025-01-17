import 'package:get_it/get_it.dart';

import './core/services/api.dart';
import './core/viewmodels/CRUDModel.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<Api>(() => Api('businessInfo'));
  locator.registerLazySingleton<CRUDModel>(() => CRUDModel()) ;
}