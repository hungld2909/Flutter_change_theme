import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   bool darkThemeEnabled = false;
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: "Change Theme",
//       theme: darkThemeEnabled ? ThemeData.dark() : ThemeData.light(),
//       home: HomePage(),
      
//     );
//   }
  //! Way: Trường Hợp Bình thường.
  // Widget HomePage() {
  //   return Scaffold(
  //     appBar: new AppBar(
  //       title: Text("Dynamic Theme"),
  //     ),
  //     body: Center(
  //       child: Text("Change Theme"),
    
  //       ),
  //       drawer: Drawer(
  //         child: ListView(
  //           children: <Widget>[
  //             ListTile(
  //               title: Text("Change Theme"),
  //               trailing: Switch(
  //                 value: darkThemeEnabled, 
  //                 onChanged: (changedTheme){
  //                 setState(() {
  //                   darkThemeEnabled = changedTheme;
  //                 });
  //                 }
  //                 ),
  //               )
  //           ],
  //         ),
  //       ),
  //   );
  // }
// }

//! way2: trường hợp bloc xử lý ngay tại hàm MyApp StatelessWidget
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: bloc.darkThemeEnabled,
//       initialData: false,
//       builder: (context,snapshot) => MaterialApp(
//         theme: snapshot.data? ThemeData.dark() : ThemeData.light(),
//         home: Scaffold(
//         appBar: new AppBar(
//           title: Text("Dynamic Theme"),
//         ),
//         body: Center(
//           child: Text("Change Theme"),
      
//           ),
//           drawer: Drawer(
//             child: ListView(
//               children: <Widget>[
//                 ListTile(
//                   title: Text("Change Theme"),
//                   trailing: Switch(
//                     value: snapshot.data, 
//                     onChanged: bloc.changeTheme
//                     ),
//                   )
//               ],
//             ),
//           ),
//       )
//       ),
//     );
//   }
// }


//! way3: tách ra từ trường hợp 2 để dễ hiểu code hơn.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.darkThemeEnabled,
      initialData: false,
      builder: (context,snapshot) => MaterialApp(
        theme: snapshot.data? ThemeData.dark() : ThemeData.light(),
        home: HomePage(snapshot.data)
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  bool darkThemeEnabled;
  HomePage(this.darkThemeEnabled);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: Text("Dynamic Theme"),
        ),
        body: Center(
          child: Text("Change Theme"),
      
          ),
          drawer: Drawer(
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: Text("Change Theme"),
                  trailing: Switch(
                    value: darkThemeEnabled, 
                    onChanged: bloc.changeTheme
                    ),
                  )
              ],
            ),
          ),
      );
  }
}





class Bloc{
  final _themeController = StreamController<bool>();
  get changeTheme => _themeController.sink.add;
  get darkThemeEnabled => _themeController.stream;
}

final bloc = Bloc();