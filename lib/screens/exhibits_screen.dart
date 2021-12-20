import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:uran_flutter_challange/models/exhibit.dart';
import 'package:uran_flutter_challange/rest_exhibit_loader.dart';
import 'package:uran_flutter_challange/widgets/exhibit_widget.dart';

class ExhibitsScreen extends StatefulWidget {
  const ExhibitsScreen({Key? key}) : super(key: key);

  @override
  State<ExhibitsScreen> createState() => _ExhibitsScreenState();
}

class _ExhibitsScreenState extends State<ExhibitsScreen> {
  Future<List<Exhibit>>? exhibitFuture;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  RestExhibitsLoader restExhibitsLoader = RestExhibitsLoader();
  @override
  void initState() {
    super.initState();
    exhibitFuture = restExhibitsLoader.getExhibitList(http.Client());
  }

  _refresh() {
    setState(() {
      exhibitFuture = restExhibitsLoader.getExhibitList(http.Client());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Uran Flutter challenge'),
      ),
      body: SafeArea(
        child: FutureBuilder<List<Exhibit>>(
            future: exhibitFuture,
            builder: (context, AsyncSnapshot<List<Exhibit>> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return SmartRefresher(
                    onRefresh: () {
                      setState(() {});
                      _refresh();
                    },
                    enablePullDown: true,
                    controller: _refreshController,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return ExhibitWidget(
                            title: snapshot.data![index].title,
                            images: snapshot.data![index].images,
                          );
                        }),
                  );
                }
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'There is no data at the moment',
                        style: TextStyle(fontSize: 20),
                      ),
                      ElevatedButton(
                          onPressed: () => _refresh(),
                          child: const Text('Retry')),
                    ],
                  ),
                );
              }
              return const Center(child: const CircularProgressIndicator());
            }),
      ),
    );
  }
}
