
import 'package:bloc/bloc.dart';
import 'package:robo_coffee_app/product/menu/menu_event.dart';
import 'package:robo_coffee_app/product/menu/menu_state.dart';
import 'package:robo_coffee_app/product/product_repo.dart';
import 'package:flutter/cupertino.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {

  final ProductRepository repo;

  MenuBloc({@required this.repo}) : assert(repo != null);

  @override
  MenuState get initialState => MenuLoading();

  @override
  Stream<MenuState> mapEventToState(MenuEvent event) async* {
    if (event is LoadMenu) {
      yield MenuLoading();
      try {
        var menuResponse = await repo.getMenu();
        yield MenuLoaded(menuResponse.menu);
      } catch (_) {
        yield MenuNotLoaded();
      }
    }
  }
}