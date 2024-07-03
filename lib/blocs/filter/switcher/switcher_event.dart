// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'switcher_bloc.dart';

class SwitcherEvent {}

class ToggleSwitchEvent extends SwitcherEvent {
  final bool isLight;

  ToggleSwitchEvent(this.isLight);
}

class ApplySwitcherEvent extends SwitcherEvent {}
