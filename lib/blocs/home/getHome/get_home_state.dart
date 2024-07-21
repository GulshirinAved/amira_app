part of 'get_home_bloc.dart';

sealed class GetHomeState extends Equatable {
  const GetHomeState();

  @override
  List<Object> get props => [];
}

final class GetHomeInitial extends GetHomeState {}

final class GetHomeLoading extends GetHomeState {}

final class GetHomeLoaded extends GetHomeState {
  final List<dynamic> getHomeBannerList;
  final List<List<dynamic>> getHomeProducts;
  final List<Datum> getHomeData;

  const GetHomeLoaded({
    required this.getHomeBannerList,
    required this.getHomeProducts,
    required this.getHomeData,
  });
  @override
  List<Object> get props => [
        getHomeBannerList,
        getHomeProducts,
        getHomeData,
      ];
}

final class GetHomeError extends GetHomeState {
  final String? error;

  const GetHomeError({required this.error});
  @override
  List<Object> get props => [error ?? ''];
}
