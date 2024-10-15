// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'delivery_selection_bloc.dart';

class DeliverySelectionState extends Equatable {
  final String? title;
  final String? id;

  const DeliverySelectionState(this.title, this.id);

  @override
  List<Object> get props => [title ?? '', id ?? ''];

  DeliverySelectionState copyWith({
    String? title,
    String? id,
  }) {
    return DeliverySelectionState(
      title ?? this.title,
      id ?? this.id,
    );
  }
}
