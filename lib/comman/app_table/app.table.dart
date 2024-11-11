//
// import 'package:flutter/material.dart';
//
//
//
// class AppTable extends StatelessWidget {
//   AppTable({super.key, required this.headersChildren, required this.row, required this.onSearch, required this.searchController, required this.title, this.onChanged, this.isSearchShow = true});
//   final List<Widget> headersChildren;
//   final Color headerBg = Colors.green.shade50;
//   final Widget row;
//   final VoidCallback onSearch;
//   final TextEditingController searchController;
//   final String title;
//   final Function(String)? onChanged;
//   final bool isSearchShow;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text("${title}",
//               style:const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 20,
//               ),
//             ),
//
//             isSearchShow ?  Row(
//
//               children: [
//                 SizedBox(
//                   width: 300,
//                   height: 40,
//                   child: TextFormField(
//                     onChanged: onChanged,
//                     controller: searchController,
//                     decoration: InputDecoration(
//                         contentPadding:const EdgeInsets.only(left: 15, right: 15),
//                         hintText: "Search by Order ID",
//                         fillColor: Colors.white,
//                         hintStyle:const TextStyle(
//                             fontSize: 12
//                         ),
//                         filled: true,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(5),
//                           borderSide: BorderSide.none,
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(5),
//                           borderSide: BorderSide.none,
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(5),
//                           borderSide: BorderSide.none,
//                         )
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 10,),
//                 InkWell(
//                   onTap: onSearch,
//                   child: Container(
//                     width: 70, height: 40,
//                     decoration:const BoxDecoration(
//                       color: Colors.teal,
//                     ),
//                     child: const Center(child: Text("Search",
//                       style: TextStyle(
//                           color: Colors.white
//                       ),
//                     ),),
//                   ),
//                 )
//               ],
//             ) : Center()
//           ],
//         ),
//
//         SizedBox(height: 10,),
//
//         const SizedBox(height: 15,),
//         Container(
//           width: double.infinity,
//           height: 50,
//           padding:const EdgeInsets.only(left: 20, right: 20,),
//           decoration: BoxDecoration(
//               color: headerBg
//           ),
//           child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: headersChildren
//           ),
//         ),
//
//
//         row
//
//
//       ],
//     );
//   }
// }


import 'package:flutter/material.dart';



class AppTable extends StatelessWidget {
  AppTable({super.key, this. onPageFront, required this.headersChildren, required this.row, required this.onSearch, required this.searchController, required this.title, this.onChanged, this.isSearchShow = true, this.onPageBack, this.pageLength});
  final List<Widget> headersChildren;
  final Color headerBg = Colors.green;
  final Widget row;
  final VoidCallback onSearch;
  final TextEditingController searchController;
  final String title;
  final Function(String)? onChanged;
  final bool isSearchShow;
  final VoidCallback? onPageBack;
  final VoidCallback? onPageFront;
  final int? pageLength;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("${title}",
              style:const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),

            isSearchShow ?  Row(

              children: [
                SizedBox(
                  width: 300,
                  height: 40,
                  child: TextFormField(
                    onChanged: onChanged,
                    controller: searchController,
                    decoration: InputDecoration(
                        contentPadding:const EdgeInsets.only(left: 15, right: 15),
                        hintText: "Search by Order ID",
                        fillColor: Colors.grey.shade200,
                        hintStyle:const TextStyle(
                            fontSize: 12
                        ),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none,
                        )
                    ),
                  ),
                ),
                const SizedBox(width: 10,),
                InkWell(
                  onTap: onSearch,
                  child: Container(
                    width: 70, height: 40,
                    decoration:const BoxDecoration(
                      color: Colors.teal,
                    ),
                    child: const Center(child: Text("Search",
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),),
                  ),
                )
              ],
            ) : Center()
          ],
        ),

        SizedBox(height: 10,),

        const SizedBox(height: 15,),
        Container(
          width: double.infinity,
          height: 50,
          padding:const EdgeInsets.only(left: 20, right: 20,),
          decoration: BoxDecoration(

              color: headerBg
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: headersChildren
          ),
        ),


        row,

        SizedBox(height: 10,),
        // if (pageLength == 0) Center() else SizedBox(
        //   height: 30,
        //   child: Align(
        //       alignment: Alignment.centerRight,
        //       child: Row(
        //         children: [
        //           InkWell(
        //             onTap: onPageBack,
        //             child: Container(
        //               width: 30,
        //               height: 30,
        //               decoration: BoxDecoration(
        //                 borderRadius: BorderRadius.circular(5),
        //                 color: Colors.blue,
        //               ),
        //               child: Center(child: Icon(Icons.arrow_back, color: Colors.white, size: 20,),),
        //             ),
        //           ),
        //           SizedBox(width: 10,),
        //           Text("Page: ${pageLength}"),
        //           SizedBox(width: 10,),
        //           InkWell(
        //             onTap: onPageFront,
        //             child: Container(
        //               width: 30,
        //               height: 30,
        //               decoration: BoxDecoration(
        //                   color: Colors.blue,
        //                   borderRadius: BorderRadius.circular(5)
        //               ),
        //               child: Center(child: Icon(Icons.arrow_forward, color: Colors.white, size: 20,),),
        //             ),
        //           )
        //         ],
        //       )
        //   ),
        // )


      ],
    );
  }
}