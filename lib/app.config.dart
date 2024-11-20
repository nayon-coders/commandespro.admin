import 'package:flutter/material.dart';

class AppConfig{



  static const String APP_NAME = "Commendes Pros - Admin";


  static const String DOMAIN_URL = "https://grocary-ecommerce.vercel.app";
  static const String API = "api/v1";
  static const String BASE_URL = "$DOMAIN_URL/$API";

  static const String LOGIN = "$BASE_URL/admins/login";
  static const String MY_PROFILE = "$BASE_URL/admins/me";

  static const String UPDATE_PASSWORD = "$BASE_URL/admins/update/password";

  //product
  static const String PRODUCT_GET = "$BASE_URL/product/all";
  static const String PRODUCT_ADD = "$BASE_URL/product/create";
  static const String PRODUCT_UPDATE = "$BASE_URL/product/update/";
  static const String PRODUCT_DELETE = "$BASE_URL/product/delete/";
  static const String PRODUCT_SINGLE = "$BASE_URL/product/";

  static const String POST_CODER_CREATE = "$BASE_URL/product/post-code";
  static const String POST_CODE_DELETE = "$BASE_URL/product/post-code/";
  static const String POST_CODE_GET = "$BASE_URL/product/post-code";
  static const String CATEGORY_MAIN_ADD = "$BASE_URL/category/create";
  static const String CATEGORY_MAIN_GET = "$BASE_URL/category";
  static const String CATEGORY_MAIN_DELETE = "$BASE_URL/category/delete/";
  static const String CATEGORY_MAIN_UPDATE = "$BASE_URL/category/update/";
  static const String SUB_CATEGORY_CREATE = "$BASE_URL/subcategory/create";
  static const String SUB_CATEGORY_DELETE = "$BASE_URL/subcategory/delete/";
  static const String SUB_CATEGORY_UPDATE = "$BASE_URL/subcategory/update/";



  static const String USER_GET = "$BASE_URL/user/all";
  static const String USER_STATUS_UPDATE = "$BASE_URL/user/status/";
  static const String USER_SINGLE = "$BASE_URL/user/";
  static const String USER_UPDATE = "$BASE_URL/user/update/";
  static const String DELETE_USER = "$BASE_URL/user/delete/";



  static const String ADMIN_LOGIN = "$BASE_URL/admins/login";
  static const String ADMIN_SIGNUP = "$BASE_URL/admins/signup";
  static const String ADMIN_GET = "$BASE_URL/admins/me";
  static const String ADMIN_UPDATE = "$BASE_URL/admins/update";
  static const String ADMIN_PASSWORD = "$BASE_URL/admins/update/password";
  static const String ADMIN_ROLE_UPDATE = "$BASE_URL/admins/update/role/1";
  static const String SINGLE_ADMIN = "$BASE_URL/admins/";
  static const String ADMIN_GET_ALL = "$BASE_URL/admins/all";
  static const String ADMIN_DELETE = "$BASE_URL/admins/delete/";
  static const String ADMIN_ROLE_GET = "$BASE_URL/admins/rolewithpermission";
  static const String ADMIN_ROLE_PERMISSION_GET = "$BASE_URL/admins/rolewithpermission";
  static const String NEW_CUSTOMER = "$BASE_URL/user/signup";
  static const String ADD_DELIVERY_ADDRESS = "$BASE_URL/delivery-addresss/create/";
  static const String all_delivery_address = "$BASE_URL/delivery-addresss/";
  static const String CREART_ORDER = "$BASE_URL/order/create/";


  //product";

  //order
  static const String ORDER_GET = "$BASE_URL/order/all";
  static const String ORDER_GET_SINGLE = "$BASE_URL/order/";
  static const String ORDER_STATUS_UPDATE = "$BASE_URL/order/status/update/";
  static const String ORDER_PRICE_UPDATE = "$BASE_URL/order/update-price/";

  //setting
  static const String PRIVACY_GET = "$BASE_URL/settings/privacy";
  static const String PRIVACY_UPDATE = "$BASE_URL/settings/privacy";



}