// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'payment_selection_bloc.dart';

class PaymentSelectionState extends Equatable {
  final String? title;
  const PaymentSelectionState(this.title);

  @override
  List<Object> get props => [title ?? ''];

  PaymentSelectionState copyWith({
    String? title,
  }) {
    return PaymentSelectionState(
      title ?? this.title,
    );
  }
}
