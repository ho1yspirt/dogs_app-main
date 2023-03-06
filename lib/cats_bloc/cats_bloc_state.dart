part of 'cats_bloc_bloc.dart';

@immutable
abstract class CatsBlocState {}

class CatsBlocInitial extends CatsBlocState {}

class CatsBlocLoading extends CatsBlocState {}

class CatsBlocSuccess extends CatsBlocState {
  final CatsModel model;
  CatsBlocSuccess({required this.model});
}

class CatsBlocError extends CatsBlocState {}
