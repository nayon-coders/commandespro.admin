import 'package:commandespro_admin/routes/app_pages.dart';
import 'package:flutter/material.dart';

class AppMenus{
 static final List menus = [
    {
      "title": "DASHBOARD",
      "items" : [],
      "page" : AppRoute.dashboard
    },
    {
      "title": "PRODUCTS",
      "items" : [
        {
          "title": "PRODUCT LIST",
          "sub_items":[] ,//no sub items,
          "page" : AppRoute.product_list
        },
        {
          "title": "ADD NEW PRODUCT",
          "sub_items":[],//no sub items
          "page" : AppRoute.add_new_product
        },
        {
          "title": "CATEGORIES",
          "sub_items":[], //no sub items
          "page" : AppRoute.categories
        },

      ]
    },
    {
      "title": "ORDERS",
      "items" : [],
      "page" : AppRoute.orders
    },
    {
      "title": "INVOICE",
      "items" : [],
      "page" : AppRoute.invoice_genaret
    },
    {
      "title": "CREDITS",
      "items" : [],
      "page" : AppRoute.assets
    },
    {
      "title": "CUSTOMERS",
      "items" : [],
      "page" : AppRoute.customers
    },
    {
      "title": "SETTINGS",
      "items" : [
        {
          "title": "USER LIST",
          "sub_items":[] ,//no sub items
          "page" : AppRoute.admin_list
        },
        {
          "title": "ADD NEW USER",
          "sub_items":[], //no sub items
          "page" : AppRoute.add_new_user
        },
        {
          "title": "POSTAL CODE",
          "sub_items":[],//no sub items
          "page" : AppRoute.postal_code
        },
      ]
    },
   {
     "title": "APP",
     "items" : [
       {
         "title": "PAGE",
         "sub_items":[], //no sub items
          "page" : AppRoute.pages
       },
       {
         "title": "SETTING",
         "sub_items":[], //no sub items
          "page" : AppRoute.setting
       },
     ]
   },
  ];
}