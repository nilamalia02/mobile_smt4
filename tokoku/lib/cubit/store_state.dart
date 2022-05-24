part of 'store_cubit.dart';

abstract class StoreState extends Equatable {
  const StoreState();

  @override
  List<Object> get props => [];
}

class StoreInitial extends StoreState {}

class StoreLoading extends StoreState {}

class StoreLoaded extends StoreState {
  final List<StoreModel> stores;

  const StoreLoaded(this.stores);

  @override
  List<Object> get props => [stores];
}

class StoreFailure extends StoreState {
  final String error;
  const StoreFailure({required this.error});

  @override
  List<Object> get props => [error];
}
