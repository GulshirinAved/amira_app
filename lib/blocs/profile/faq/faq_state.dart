part of 'faq_bloc.dart';

sealed class FaqState extends Equatable {
  const FaqState();

  @override
  List<Object> get props => [];
}

final class FaqInitial extends FaqState {}

final class FaqLoaded extends FaqState {
  final List<Row> faqList;

  const FaqLoaded({required this.faqList});

  @override
  List<Object> get props => [faqList];
}

final class FaqError extends FaqState {
  final String error;

  const FaqError({required this.error});

  @override
  List<Object> get props => [error];
}
