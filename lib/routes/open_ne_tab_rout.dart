// import 'dart:html' as html;
//
// void openNewTab(String route) {
//   final url = "${Uri.base.origin}#" + route; // Uri.base.origin gives the base URL of your app
//   html.window.open(url, '_blank');
// }

import 'dart:html' as html;

void openNewTab(String route, {Map<String, String>? arguments}) {
  // Construct the base URL with the provided route
  var url = "${Uri.base.origin}#$route";

  // If there are arguments, add them as query parameters
  if (arguments != null && arguments.isNotEmpty) {
    final uri = Uri.parse(url).replace(queryParameters: arguments);
    url = uri.toString();
  }

  // Open the new tab with the URL and arguments
  html.window.open(url, '_blank');
}
