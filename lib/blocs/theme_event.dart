import 'package:equatable/equatable.dart';
import 'package:practice1/models/models.dart';
import 'package:meta/meta.dart';

abstract class ThemeEvent extends Equatable{
  const ThemeEvent();
}
class WeatherChanged extends ThemeEvent{
  final WeatherCondition condition;
  const WeatherChanged({@required this.condition}) : assert(condition != null);
  @override
  // TODO: implement props
  List<Object> get props => [condition];

}