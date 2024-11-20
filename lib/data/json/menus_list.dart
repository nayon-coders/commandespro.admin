import 'package:commandespro_admin/routes/app_pages.dart';
import 'package:flutter/material.dart';

class AppMenus{
 static final List menus = [
    {
      "id" : "DASHBOARD",
      "title": "DASHBOARD",
      "items" : [],
      "page" : AppRoute.dashboard
    },
    {
      "id" : "PRODUCTS",
      "title": "PRODUCTS",
      "items" : [
        {
          "id" : "PRODUCTS",
          "title": "PRODUCT LIST",
          "sub_items":[] ,//no sub items,
          "page" : AppRoute.product_list
        },
        {
          "id" : "PRODUCTS",
          "title": "ADD NEW PRODUCT",
          "sub_items":[],//no sub items
          "page" : AppRoute.add_new_product
        },
        {
          "id" : "PRODUCTS",
          "title": "CATEGORIES",
          "sub_items":[], //no sub items
          "page" : AppRoute.categories
        },

      ]
    },
    {
      "id" : "ORDERS",
      "title": "ORDERS",
      "items" : [],
      "page" : AppRoute.orders
    },
    {
      "id" : "INVOICE",
      "title": "INVOICE",
      "items" : [],
      "page" : AppRoute.invoice_genaret
    },
    {
      "id" : "CREDITS",
      "title": "CREDITS",
      "items" : [],
      "page" : AppRoute.assets
    },
    {
      "id" : "CUSTOMERS",
      "title": "CUSTOMERS",
      "items" : [],
      "page" : AppRoute.customers
    },
    {
      "id" : "SETTINGS",
      "title": "SETTINGS",
      "items" : [
        {
          "id" : "SETTINGS",
          "title": "USER LIST",
          "sub_items":[] ,//no sub items
          "page" : AppRoute.admin_list
        },
        {
          "id" : "SETTINGS",
          "title": "ADD NEW USER",
          "sub_items":[], //no sub items
          "page" : AppRoute.add_new_user
        },
        {
          "id" : "SETTINGS",
          "title": "POSTAL CODE",
          "sub_items":[],//no sub items
          "page" : AppRoute.postal_code
        },
      ]
    },
   {
     "title": "APP",
     "id" : "APP",
     "items" : [
       {
         "id" : "APP",
         "title": "PAGE",
         "sub_items":[], //no sub items
          "page" : AppRoute.pages
       },
       {
         "id" : "APP",
         "title": "SETTING",
         "sub_items":[], //no sub items
          "page" : AppRoute.setting
       },
     ]
   },
  ];
}