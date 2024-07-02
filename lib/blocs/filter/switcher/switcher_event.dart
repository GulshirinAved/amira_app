// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'switcher_bloc.dart';

class SwitcherEvent extends Equatable {
  final bool isLight;
  const SwitcherEvent(
    this.isLight,
  );

  @override
  List<Object> get props => [isLight];
}
