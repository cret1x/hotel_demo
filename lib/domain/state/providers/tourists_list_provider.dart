import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_demo/domain/model/tourist.dart';

class TouristsListProvider extends StateNotifier<List<Tourist>> {
  TouristsListProvider() : super([Tourist(id: 0, expanded: true)]);

  bool validate() {
    return state.every((tourist) => tourist.validate());
  }

  void add() {
    int prevId = state.last.id;
    state = [...state, Tourist(id: prevId + 1, expanded: true)];
  }

  void update(Tourist tourist) {
    state = [
      for (final t in state)
        if (t.id != tourist.id) t else tourist,
    ];
  }

  void toggle(Tourist tourist) {
    state = [
      for (final t in state)
        if (t.id != tourist.id) t else tourist.toggle(),
    ];
  }
}
