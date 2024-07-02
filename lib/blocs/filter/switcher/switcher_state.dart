// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'switcher_bloc.dart';

class SwitcherState extends Equatable {
  final bool isLight;

  const SwitcherState(this.isLight);

  @override
  List<Object> get props => [isLight];

  SwitcherState copyWith({
    bool? isLight,
  }) {
    return SwitcherState(
      isLight ?? this.isLight,
    );
  }
}
