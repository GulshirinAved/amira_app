import 'package:amira_app/data/api_repositories/faq_repository.dart';
import 'package:amira_app/data/models/faq_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'faq_event.dart';
part 'faq_state.dart';

class FaqBloc extends Bloc<FaqEvent, FaqState> {
  FaqBloc() : super(FaqInitial()) {
    final FaqRepository faqRepository = FaqRepository();
    on<GetList>((event, emit) async {
      try {
        final List<Row> faqList = await faqRepository.getFaq();
        emit(FaqLoaded(faqList: faqList));
      } catch (e) {
        emit(FaqError(error: e.toString()));
      }
    });
  }
}
