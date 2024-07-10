import 'package:amira_app/data/api_repositories/home_repository.dart';
import 'package:amira_app/data/models/home_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'get_home_event.dart';
part 'get_home_state.dart';

class GetHomeBloc extends Bloc<GetHomeEvent, GetHomeState> {
  GetHomeBloc() : super(GetHomeInitial()) {
    final GetHomeRespoitory _getHomeRepository = GetHomeRespoitory();

    on<GetHomeBannerList>((event, emit) async {
      emit(GetHomeLoading());
      try {
        final getHomeBannerList = await _getHomeRepository.fetchHomeBanner();
        final getHomeProducts = await _getHomeRepository.fetchAllHomeProducts();
        final getHomeData = await _getHomeRepository.fetchAllHomeData();

        emit(
          GetHomeLoaded(
            getHomeBannerList: getHomeBannerList,
            getHomeProducts: getHomeProducts,
            getHomeData: getHomeData,
          ),
        );
      } catch (e) {
        emit(GetHomeError(error: e.toString()));
      }
    });
  }
}
