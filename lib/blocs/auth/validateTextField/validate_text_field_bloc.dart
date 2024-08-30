import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

part 'validate_text_field_event.dart';
part 'validate_text_field_state.dart';

class ValidateTextFieldBloc
    extends Bloc<ValidateTextFieldEvent, ValidateTextFieldState> {
  ValidateTextFieldBloc() : super(ValidateTextFieldState.initial()) {
    on<PhoneNumberChanged>((event, emit) {
      final isValid =
          event.phoneNumber.length == 8 && event.phoneNumber.startsWith('6');

      emit(
        state.copyWith(
          phoneNumber: event.phoneNumber,
          isPhoneValid: isValid,
        ),
      );
    });

    on<PasswordChanged>((event, emit) {
      final isValid = event.passWord.length >= 6;
      emit(
        state.copyWith(
          password: event.passWord,
          isPassValid: isValid,
        ),
      );
    });
    on<NewPasswordChanged>((event, emit) {
      final isValid =
          event.newPassWord.length >= 6 && event.newPassWord != state.password;
      emit(
        state.copyWith(
          newPassword: event.newPassWord,
          isNewPassValid: isValid,
        ),
      );
    });

    on<VerifyPassChanged>((event, emit) {
      final isValid = event.verifyPass.trim() == state.password.trim();

      emit(
        state.copyWith(
          verifyPass: event.verifyPass,
          isVerifyPassValid: isValid,
        ),
      );
    });

    on<BirthdayChanged>((event, emit) {
      try {
        DateTime date =
            DateFormat('yyyy-MM-dd').parseStrict(event.birthdayDate);
        bool isValid = date.year <= 2011 && date.month <= 12;
        if (isValid) {
          if (date.month == 2) {
// Check for leap year
            bool isLeapYear = (date.year % 4 == 0 && date.year % 100 != 0) ||
                (date.year % 400 == 0);
            isValid = isLeapYear ? date.day <= 29 : date.day <= 28;
          } else if ([4, 6, 9, 11].contains(date.month)) {
// April, June, September, November have 30 days
            isValid = date.day <= 30;
          } else {
// Other months have 31 days
            isValid = date.day <= 31;
          }
        }

        emit(
          state.copyWith(
            isVerifyBirthdayValid: isValid,
            birthdayDate: event.birthdayDate,
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            isVerifyBirthdayValid: false,
            birthdayDate: event.birthdayDate,
          ),
        );
      }
    });

    on<EmailChanged>((event, emit) {
      bool isValid = event.email.endsWith('@gmail.com');
      emit(
        state.copyWith(
          isVerifyEmailValid: isValid,
          email: event.email,
        ),
      );
    });
    on<NameChanged>((event, emit) {
      bool isValid = event.name != '';
      emit(
        state.copyWith(
          name: event.name,
          isNameValid: isValid,
        ),
      );
    });
    on<AddressChanged>((event, emit) {
      bool isValid = event.address.isNotEmpty;
      emit(
        state.copyWith(
          name: event.address,
          isAddressValid: isValid,
        ),
      );
    });
  }
}
