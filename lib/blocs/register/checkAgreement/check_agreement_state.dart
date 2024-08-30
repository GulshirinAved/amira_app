part of 'check_agreement_cubit.dart';

sealed class CheckAgreementState extends Equatable {
  const CheckAgreementState();

  @override
  List<Object> get props => [];
}

final class CheckAgreementInitial extends CheckAgreementState {}
