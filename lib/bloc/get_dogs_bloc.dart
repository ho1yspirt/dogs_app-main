import 'package:bloc/bloc.dart';
import 'package:dogs/models/dogs_model.dart';
import 'package:dogs/repo/get_dogs_repo.dart';
import 'package:meta/meta.dart';

part 'get_dogs_event.dart';
part 'get_dogs_state.dart';

class GetDogsBloc extends Bloc<GetDogsEvent, GetDogsState> {
  GetDogsBloc({required this.repo}) : super(GetDogsInitial()) {
    on<GetDataEvent>(
      (event, emit) async {
        try {
          emit(
            GetDogsSuccess(
              model: await repo.getDogsData(
                count: event.count,
              ),
            ),
          );
        } catch (e) {
          emit(GetDogsError());
        }
      },
    );
  }
  final GetDogsRepo repo;
}
