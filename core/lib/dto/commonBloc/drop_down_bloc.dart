import 'package:core/dto/models/baseModules/drop_down_mapper.dart';
import 'package:core/ui/bases/bloc_base.dart';
import 'package:rxdart/rxdart.dart';

class DropDownBloc extends BlocBase {
  // A BehaviorSubject for managing the selected dropdown item.
  final BehaviorSubject<DropDownMapper?> _selectedDropDownBehaviour =
      BehaviorSubject<DropDownMapper?>();

  // Stream getter to access the selected dropdown item.
  Stream<DropDownMapper?> get selectedDropDownStream =>
      _selectedDropDownBehaviour.stream;

  // Method to update the selected dropdown item.
  void updateValue(DropDownMapper value) =>
      _selectedDropDownBehaviour.sink.add(value);

  // Getter to access the currently selected dropdown item.
  DropDownMapper? get value => _selectedDropDownBehaviour.valueOrNull;

  @override
  void dispose() {
    // Close the BehaviorSubject when the bloc is disposed to release resources.
    _selectedDropDownBehaviour.close();
  }
}
