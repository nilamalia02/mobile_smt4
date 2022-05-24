import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tokoku/models/store_model.dart';
import 'package:tokoku/services/store_service.dart';

part 'store_state.dart';

class StoreCubit extends Cubit<StoreState> {
  StoreCubit() : super(StoreInitial());

  void getStores() async {
    try {
      emit(StoreLoading());
      List<StoreModel> students = await StoreService().getStores();
      print(students);
      emit(StoreLoaded(students));
    } catch (e) {
      emit(StoreFailure(error: e.toString()));
    }
  }

  void deleteStore(String id) async {
    try {
      await StoreService().deleteStore(id);
      getStores();
    } catch (e) {
      emit(StoreFailure(error: e.toString()));
    }
  }

  void addStore(StoreModel student) async {
    try {
      emit(StoreLoading());
      await StoreService().addStore(student);
      emit(StoreLoaded([]));
    } catch (e) {
      emit(StoreFailure(error: e.toString()));
    }
  }

  void editStore(StoreModel student) async {
    try {
      emit(StoreLoading());
      await StoreService().editStore(student);
      emit(StoreLoaded([]));
    } catch (e) {
      emit(StoreFailure(error: e.toString()));
    }
  }
}
