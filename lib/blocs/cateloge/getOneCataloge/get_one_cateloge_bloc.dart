import 'package:amira_app/data/api_repositories/getOneCataloge_repository.dart';
import 'package:amira_app/data/models/getOneCataloge_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'get_one_cateloge_event.dart';
part 'get_one_cateloge_state.dart';

class GetOneCatelogeBloc
    extends Bloc<GetOneCatelogeEvent, GetOneCatelogeState> {
  GetOneCatelogeBloc() : super(GetOneCatelogeInitial()) {
    final GetOneCatalogeRepository getOneCatalogeRepository =
        GetOneCatalogeRepository();

    on<GetOneCataloge>((event, emit) async {
      try {
        print('it is event ${event.id}');
        emit(GetOneCatalogeLoading());
        final getOneCatalogeList =
            await getOneCatalogeRepository.getOneCataloge(event.id);

        emit(GetOneCatalogeLoaded(getOneCatalogeList: getOneCatalogeList));
      } catch (e) {
        emit(GetOneCatalogeError(error: e.toString()));
      }
    });
  }
}
