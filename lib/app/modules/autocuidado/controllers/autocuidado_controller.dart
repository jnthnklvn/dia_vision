import 'package:dia_vision/app/repositories/autocuidado_repository.dart';
import 'package:dia_vision/app/shared/utils/file_utils.dart';
import 'package:dia_vision/app/shared/utils/csv_utils.dart';
import 'package:dia_vision/app/repositories/model/autocuidado.dart';

import 'package:mobx/mobx.dart';

part 'autocuidado_controller.g.dart';

class AutocuidadoController = _AutocuidadoControllerBase
    with _$AutocuidadoController;

abstract class _AutocuidadoControllerBase with Store, CsvUtils, FileUtils {
  final IAutocuidadoRepository _autocuidadoRepository;

  _AutocuidadoControllerBase(this._autocuidadoRepository);

  @observable
  bool isLoading = false;
  @observable
  ObservableList<Autocuidado> autocuidados = ObservableList<Autocuidado>();
  @observable
  ObservableSet<String?> categorias = ObservableSet<String>();
  @observable
  String? categoria;

  List<Autocuidado> _autocuidados = <Autocuidado>[];

  Future<void> getData(Function(String) onError) async {
    isLoading = true;
    try {
      final result = await _autocuidadoRepository.getAll();
      result.fold((l) => onError(l.message), (r) {
        r.sort((a, b) => (a.hashCode).compareTo((b.hashCode)));
        _autocuidados = r;
        categorias = r.map((e) => e.categoria).toSet().asObservable();
        autocuidados = (r).asObservable();
      });
    } catch (e) {
      onError(e.toString());
      isLoading = false;
    }
    isLoading = false;
  }

  void filterData(String categoria) {
    this.categoria = categoria;
    if (_autocuidados.isNotEmpty) {
      autocuidados = _autocuidados
          .where((e) => e.categoria == categoria)
          .toList()
          .asObservable();
      if (autocuidados.isEmpty) {
        autocuidados = _autocuidados.asObservable();
      }
    }
  }
}
