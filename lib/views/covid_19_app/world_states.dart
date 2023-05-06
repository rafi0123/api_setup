import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:learn_api/models/world_state_model.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../services/state_services.dart';
import 'country_list.dart';

class WorldsStates extends StatefulWidget {
  const WorldsStates({super.key});

  @override
  State<WorldsStates> createState() => _WorldsStatesState();
}

class _WorldsStatesState extends State<WorldsStates>
    with TickerProviderStateMixin {
  StateServices stateServices = StateServices();
  late final controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  List<Color> colorList = [
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            FutureBuilder<WorldStateModel>(
              future: stateServices.getWorldStateRecord(),
              builder: (context, AsyncSnapshot<WorldStateModel> snapshot) {
                print(snapshot.toString());
                if (!snapshot.hasData) {
                  return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        color: Colors.grey,
                        size: 50,
                        // controller: controller,
                      ));
                } else {
                  return Column(
                    children: [
                      PieChart(

                        dataMap: {
                          'Total':
                              double.parse(snapshot.data!.cases.toString()),
                          'Recover':
                              double.parse(snapshot.data!.recovered.toString()),
                          'Death':
                              double.parse(snapshot.data!.deaths.toString())
                        },
                        
                        animationDuration: const Duration(milliseconds: 1200),
                        chartType: ChartType.ring,
                        colorList: const [
                          Color(0xff4285F4),
                          Color(0xff1aa260),
                          Color(0xffde5246),
                        ],
                        chartValuesOptions: const ChartValuesOptions(
                            showChartValuesInPercentage: true),
                        chartRadius: MediaQuery.of(context).size.width / 3.2,
                        legendOptions: const LegendOptions(
                            legendPosition: LegendPosition.left),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical:
                                MediaQuery.of(context).size.height * 0.06),
                        child: Card(
                          child: Column(children: [
                            reusibleWidget(
                                title: 'Totoal',
                                value: snapshot.data!.cases.toString()),
                            reusibleWidget(
                                title: 'Deaths',
                                value: snapshot.data!.deaths.toString()),
                            reusibleWidget(
                                title: 'Recovered',
                                value: snapshot.data!.recovered.toString()),
                            reusibleWidget(
                                title: 'Active',
                                value: snapshot.data!.active.toString()),
                            reusibleWidget(
                                title: 'Criticals',
                                value: snapshot.data!.critical.toString()),
                            reusibleWidget(
                                title: 'Today Deaths',
                                value: snapshot.data!.todayDeaths.toString()),
                            reusibleWidget(
                                title: 'Today Recovered',
                                value:
                                    snapshot.data!.todayRecovered.toString()),
                          ]),
                        ),
                      ),
                      MaterialButton(
                        color: const Color(0xff1aa260),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => const CountryList())));
                        },
                        child: const Text(
                          'Track Country',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  );
                }
              },
            ),
          ],
        ),
      )),
    );
  }

  Widget reusibleWidget({required String title, required value}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5, left: 10, right: 10, top: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider(),
        ],
      ),
    );
  }
}
