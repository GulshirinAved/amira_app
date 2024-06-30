// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_show_products_bloc.dart';

class SearchShowProductsEvent extends Equatable {
  final String? pressedText;
  const SearchShowProductsEvent(
    this.pressedText,
  );

  @override
  List<Object> get props => [pressedText ?? ''];
}
