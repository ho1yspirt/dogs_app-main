import 'package:bloc/bloc.dart';
import 'package:dogs/models/cats_model.dart';
import 'package:dogs/repo/get_cats_repo.dart';
import 'package:meta/meta.dart';

part 'cats_bloc_event.dart';
part 'cats_bloc_state.dart';

class CatsBlocBloc extends Bloc<CatsBlocEvent, CatsBlocState> {
  CatsBlocBloc({required this.repo}) : super(CatsBlocInitial()) {
    on<GetCatsDataEvent>(
      (event, emit) async {
        emit(
          CatsBlocLoading(),
        );
        try {
          final model = await repo.getCatsData();
          emit(
            CatsBlocSuccess(model: model),
          );
        } catch (e) {
          emit(
            CatsBlocError(),
          );
        }
      },
    );
  }
  final CatsRepo repo;
}
