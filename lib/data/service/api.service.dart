import 'dart:convert';
import 'dart:html' as html ;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';


class ApiService{

  //get api
  Future<http.Response> getApi(url)async{
    var response = await http.get(Uri.parse(url),
      headers: {
        "Authorization" : "Bearer ${sharedPreferences!.getString("token")}"
      }
    );
    debugPrint("Url -------------- ${url}");
    debugPrint("State Code -------------- ${response.statusCode}");
    debugPrint("Response Body -------------- ${response.body}");
    return response;
  }



  //post api
  Future<http.Response> postApi(url, data)async{
    var response = await http.post(Uri.parse(url),
        body: jsonEncode(data),

        headers: {
            "Content-Type" : "application/json",
          "Authorization" : "Bearer ${html.window.localStorage["token"]}"
        }
    );
    debugPrint("Url -------------- ${url}");
    debugPrint("State Code -------------- ${response.statusCode}");
    debugPrint("Response Body -------------- ${response.body}");
    return response;
  }


  //put api
  Future<http.Response> putApi(url, data,)async{
    var response = await http.put(Uri.parse(url),
        body: jsonEncode(data),
        headers: {
        "Content-Type" : "application/json",
          "Authorization" : "Bearer ${html.window.localStorage["token"]}"
        }
    );
    debugPrint("Url -------------- ${url}");
    debugPrint("State Code -------------- ${response.statusCode}");
    debugPrint("Response Body -------------- ${response.body}");
    return response;
  }


  //delete api
  Future<http.Response> deleteApi(url)async{
    var response = await http.delete(Uri.parse(url),
        headers: {
          "Authorization" : "Bearer ${html.window.localStorage["token"]}"
        }
    );
    debugPrint("Url -------------- ${url}");
    debugPrint("State Code -------------- ${response.statusCode}");
    debugPrint("Response Body -------------- ${response.body}");
    return response;
  }


}