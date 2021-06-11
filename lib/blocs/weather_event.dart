
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:practice1/blocs/blocs.dart';

abstract class WeatherEvent extends Equatable{
  const WeatherEvent();
}
class WeatherRequested extends WeatherEvent{
  final String city;

  const WeatherRequested({@required this.city}):assert(city!=null);

  @override
  // TODO: implement props
  List<Object> get props => [city];
}
class WeatherRefreshRequested extends WeatherEvent{
  final String city;

  WeatherRefreshRequested({@required this.city}):assert(city!=null);

  @override
  // TODO: implement props
  List<Object> get props => [city];
}