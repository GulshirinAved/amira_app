part of 'language_bloc.dart';

sealed class LanguageState extends Equatable {
  const LanguageState();

  @override
  List<Object> get props => [];
}

final class LanguageInitial extends LanguageState {}

class ChangeLanguageState extends LanguageState {
  final String languageCode;

  const ChangeLanguageState({required this.languageCode});
  @override
  List<Object> get props => [languageCode];
}
