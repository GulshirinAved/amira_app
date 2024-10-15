// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'payment_selection_bloc.dart';

class PaymentSelectionState extends Equatable {
  final String? title;
  final String? id;

  const PaymentSelectionState(this.title, this.id);

  @override
  List<Object> get props => [title ?? '', id ?? ''];

  PaymentSelectionState copyWith({
    String? title,
    String? id,
  }) {
    return PaymentSelectionState(
      title ?? this.title,
      id ?? this.id,
    );
  }
}
