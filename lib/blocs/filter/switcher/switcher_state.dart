// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'switcher_bloc.dart';

class SwitcherState {
  final bool isLight;
  final bool? tempIsLight;

  SwitcherState(this.isLight, {this.tempIsLight});

  SwitcherState copyWith({bool? isLight, bool? tempIsLight}) {
    return SwitcherState(
      isLight ?? this.isLight,
      tempIsLight: tempIsLight ?? this.tempIsLight,
    );
  }
}
