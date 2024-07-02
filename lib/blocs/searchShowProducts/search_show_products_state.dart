// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_show_products_bloc.dart';

class SearchShowProductsState extends Equatable {
  final String selectedText;
  const SearchShowProductsState(
    this.selectedText,
  );

  @override
  List<Object> get props => [selectedText];

  SearchShowProductsState copyWith({
    String? selectedText,
  }) {
    return SearchShowProductsState(
      selectedText ?? this.selectedText,
    );
  }
}
