part of 'get_dogs_bloc.dart';

@immutable
abstract class GetDogsState {}

class GetDogsInitial extends GetDogsState {}

class GetDogsSuccess extends GetDogsState {
  final DogsModel model;
  GetDogsSuccess({required this.model});
}

class GetDogsError extends GetDogsState {}
