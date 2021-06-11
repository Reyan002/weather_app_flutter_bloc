import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice1/blocs/blocs.dart';
import 'package:practice1/widgets/widgets.dart';
import 'dart:async';
class Weather extends StatefulWidget {
  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  Completer<void> _refreshCompleter;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshCompleter=Completer<void>();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Weather'),
        actions: [

          IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                final city = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CitySelection()));
                if(city!=null){
                  BlocProvider.of<WeatherBloc>(context)
                      .add(WeatherRequested(city: city));
                }
              }),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Settings(),
                ),
              );
            },
          ),

        ],
      ),
      body: Center(
        child: BlocConsumer<WeatherBloc, WeatherState>(
          listener:(context, state) {
            if(state is WeatherLoadSuccess){
              _refreshCompleter?.complete();
              _refreshCompleter=Completer();
              BlocProvider.of<ThemeBloc>(context).add(
                WeatherChanged(condition: state.weather.weatherCondition),
              );
            }
          },
          // ignore: missing_return
          builder: (context,state){
            if (state is WeatherInitial) {
              return Center(child: Text('Please Select a Location'));
            }
            if (state is WeatherLoadInProgress) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is WeatherLoadSuccess) {
              final weather = state.weather;
              return BlocBuilder<ThemeBloc, ThemeState>(builder: (context,themeState){
                return GradientContainer(
                  color: themeState.color,
                  child: RefreshIndicator(
                    onRefresh: (){
                      BlocProvider.of<WeatherBloc>(context).add(
                          WeatherRefreshRequested(city: weather.location)
                      );
                      return _refreshCompleter.future;
                    },
                    child: ListView(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 100.0),
                          child: Center(
                            child: Location(location: weather.location!=null?weather.location:""),
                          ),
                        ),
                        Center(
                          child: LastUpdated(dateTime: weather.lastUpdated),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 50.0),
                          child: Center(
                            child: CombinedWeatherTemperature(
                              weather: weather,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
            }
            if (state is WeatherLoadFailure) {
              return Text(
                'Something went wrong!',
                style: TextStyle(color: Colors.red),
              );
            }
          },
        ),
      ),
    );
  }
}