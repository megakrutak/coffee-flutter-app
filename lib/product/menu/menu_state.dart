import 'package:robo_coffee_app/product/product_entity.dart';
import 'package:equatable/equatable.dart';

abstract class MenuState extends Equatable {
  const MenuState();

  @override
  List<Object> get props => [];
}

class MenuLoading extends MenuState {}

class MenuLoaded extends MenuState {

  final List<ProductMenuItem> menuItems;

  const MenuLoaded([this.menuItems = const []]);

  @override
  List<Object> get props => [menuItems];

  @override
  String toString() => 'MenuLoaded { menuItems: $menuItems }';
}

class MenuNotLoaded extends MenuState {}