import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hosam Mohaisen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

List _items = [];

class _MyHomePageState extends State<MyHomePage> {
  String SurahName = '';

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/hafs_smart_v8.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["sura"];
    });
  }

  @override
  void initState() {
    readJson();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SafeArea(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(30), topRight: Radius.circular(30)),
          child: Drawer(
            backgroundColor: Colors.white60,
            shadowColor: const Color(0xffeab676),
            width: 350,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
                      decoration: BoxDecoration(
                          color: const Color(0xffeab676),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 1, color: Colors.black)),
                      child: Column(
                          // mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                  'https://dcok7u9o4gc10.cloudfront.net/uploads/ckeditor/pictures/1430/content_shutterstock_144203029.jpg'),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 40, bottom: 10),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey),
                              child: const Text(
                                'Serch to the surah name ',
                                style: TextStyle(
                                    letterSpacing: 1,
                                    fontSize: 18,
                                    color: Colors.black),
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  showSearch(
                                      context: context, delegate: DataSearch());
                                },
                                child: const Text(
                                  'Search',
                                ),
                              ),
                            )
                          ]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xffeab676),
      body: PageView.builder(
        reverse: true,
        itemBuilder: (BuildContext context, int index) {
          if (_items.isNotEmpty) {
            String byPage = '';
            String surahName = '';
            int jozzNum = 0;
            bool isBasmalahShown = false;

            for (Map ayahData in _items) {
              if (ayahData['page'] == index + 1) {
                byPage = '$byPage ${ayahData['aya_text']}';
              }
            }

            for (Map ayahData in _items) {
              if (ayahData['page'] == index + 1) {
                surahName = ayahData['sura_name_ar'];
              }
            }

            for (Map ayahData in _items) {
              if (ayahData['page'] == index + 1) {
                jozzNum = ayahData['jozz'];
              }
            }

            for (Map ayahData in _items) {
              if (ayahData['page'] == index + 1) {
                if (ayahData['aya_no'] == 1 &&
                    ayahData['sura_name_ar'] != 'الفَاتِحة' &&
                    ayahData['sura_name_ar'] != 'التوبَة') {
                  isBasmalahShown = true;
                  break;
                }
              }
            }

            return SafeArea(
              child: Container(
                decoration: index % 2 == 0
                    ? const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                            Colors.black26,
                            Colors.transparent,
                            Colors.transparent,
                            Colors.transparent,
                            Colors.transparent
                          ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight))
                    : const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                            Colors.black26,
                            Colors.transparent,
                            Colors.transparent,
                            Colors.transparent,
                            Colors.transparent
                          ],
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Stack(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'الجزء $jozzNum',
                                style: const TextStyle(
                                    fontFamily: 'Kitab', fontSize: 18),
                                textAlign: TextAlign.center,
                                textDirection: TextDirection.rtl,
                              ),
                              Text(
                                surahName,
                                style: const TextStyle(
                                    fontFamily: 'Kitab', fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            isBasmalahShown
                                ? const Text(
                                    "‏ ‏‏ ‏‏‏‏ ‏‏‏‏‏‏ ‏",
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                        fontFamily: 'Hafs', fontSize: 18),
                                    textAlign: TextAlign.center,
                                  )
                                : Container(),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              byPage,
                              textDirection: TextDirection.rtl,
                              style: const TextStyle(
                                  fontFamily: 'Hafs', fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            '${index + 1}',
                            style: const TextStyle(
                                fontFamily: 'Kitab', fontSize: 18),
                          ))
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class DataSearch extends SearchDelegate {
  List<String> surahh = [];
  List filter = [];
  late int page;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('hello ');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (_items.isNotEmpty) {
      for (Map ayahData in _items) {
        if (!surahh.contains(ayahData['sura_name_ar'].toString())) {
          surahh.add(ayahData['sura_name_ar'].toString());
        }
      }
      ////
      filter = surahh.where((element) => element.startsWith(query)).toList();
    }
//////
    return ListView.builder(
      itemCount: query == '' ? surahh.length : filter.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            query = surahh[index];
            for (Map ayahData in _items) {
              if (ayahData['sura_no'] == surahh[index + 1]) {
                //ayahData['id']==index;

                Navigator.pushNamed(context, ayahData['sura_no']);
              } //else{Navigator.pushNamed(context, ayahData['id'].toString());}
            }
          },
          child: Container(
              padding: const EdgeInsets.all(10),
              child: query == ''
                  ? Text(
                      surahh[index],
                      style: const TextStyle(fontSize: 25),
                    )
                  : Text(
                      '${filter[index]}',
                      style: const TextStyle(fontSize: 25),
                    )),
        );
      },
    );
  }
}
////  // for (int i=0; i<surahh.length;i++) {
//       //   if((surahh.where((element) => element.startsWith(query)).toList())==true){
//       //
//       //     filter.add(surahh.where((element) => element.startsWith(query)).toList());
//       //   }
//       //
//       // }

////////query ==''?  : filter.length
// //   query==''?  /:Text(
// //                 '${filter[index]}',
// //                  style: TextStyle(fontSize: 25),)

// backgroundColor: Colors.blue,
// elevation: 4,
// width: 220,
// shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
// child: IconButton(
//   icon: Icon(Icons.search),
//   onPressed: () {
//     showSearch(context: context, delegate: DataSearch());
//   },
// ),
