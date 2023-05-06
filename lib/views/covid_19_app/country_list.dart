import 'package:flutter/material.dart';
import 'package:learn_api/services/state_services.dart';
import 'package:learn_api/views/covid_19_app/detail_screen.dart';
import 'package:shimmer/shimmer.dart';

class CountryList extends StatefulWidget {
  const CountryList({super.key});

  @override
  State<CountryList> createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {
  final _searchController = TextEditingController();
  StateServices stateServices = StateServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            TextFormField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                  hintText: 'Search with Country name',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50))),
            ),
            Expanded(
                child: FutureBuilder(
                    future: stateServices.countriesListApi(),
                    builder: ((context, AsyncSnapshot<List<dynamic>> snapshot) {
                      if (!snapshot.hasData) {
                        return Shimmer.fromColors(
                            baseColor: Colors.grey.shade800,
                            highlightColor: Colors.grey.shade100,
                            child: ListView.builder(
                                itemCount: 5,
                                itemBuilder: ((context, index) {
                                  return Column(
                                    children: [
                                      ListTile(
                                        title: Container(
                                          height: 10,
                                          width: 90,
                                          color: Colors.white,
                                        ),
                                        subtitle: Container(
                                          height: 10,
                                          width: 90,
                                          color: Colors.white,
                                        ),
                                        leading: Container(
                                          height: 50,
                                          width: 50,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  );
                                })));
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: ((context, index) {
                              final name =
                                  snapshot.data![index]['country'].toString();
                              if (_searchController.text.isEmpty) {
                                return Column(
                                  children: [
                                    ListTile(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) => DetailScreen(
                                                    name: snapshot.data![index]
                                                        ['country'],
                                                    image: snapshot.data![index]
                                                        ['countryInfo']['flag'],
                                                    active: snapshot.data![index]
                                                        ['active'],
                                                    critical: snapshot.data![index]
                                                        ['critical'],
                                                    test: snapshot.data![index]
                                                        ['tests'],
                                                    todayRecovered:
                                                        snapshot.data![index]
                                                            ['recovered'],
                                                    totalCases: snapshot.data![index]
                                                        ['cases'],
                                                    totalDeaths: snapshot.data![index]
                                                        ['deaths'],
                                                    totalRecovered: snapshot.data![index]['todayRecovered']))));
                                      },
                                      title: Text(snapshot.data![index]
                                              ['country']
                                          .toString()),
                                      subtitle: Text(snapshot.data![index]
                                              ['cases']
                                          .toString()),
                                      leading: Image(
                                          height: 50,
                                          width: 50,
                                          image: NetworkImage(
                                              snapshot.data![index]
                                                  ['countryInfo']['flag'])),
                                    )
                                  ],
                                );
                              } else if (name.toLowerCase().contains(
                                  _searchController.text.toLowerCase())) {
                                return Column(
                                  children: [
                                    ListTile(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) => DetailScreen(
                                                    name: snapshot.data![index]
                                                        ['country'],
                                                    image: snapshot.data![index]
                                                        ['countryInfo']['flag'],
                                                    active: snapshot.data![index]
                                                        ['active'],
                                                    critical: snapshot.data![index]
                                                        ['critical'],
                                                    test: snapshot.data![index]
                                                        ['tests'],
                                                    todayRecovered:
                                                        snapshot.data![index]
                                                            ['recovered'],
                                                    totalCases: snapshot.data![index]
                                                        ['cases'],
                                                    totalDeaths: snapshot.data![index]
                                                        ['deaths'],
                                                    totalRecovered: snapshot.data![index]['todayRecovered']))));
                                      },
                                      title: Text(snapshot.data![index]
                                              ['country']
                                          .toString()),
                                      subtitle: Text(snapshot.data![index]
                                              ['cases']
                                          .toString()),
                                      leading: Image(
                                          height: 50,
                                          width: 50,
                                          image: NetworkImage(
                                              snapshot.data![index]
                                                  ['countryInfo']['flag'])),
                                    )
                                  ],
                                );
                              } else {
                                return Container();
                              }
                            }));
                      }
                    })))
          ],
        ),
      )),
    );
  }
}
