import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:waste_time_out/service/helper.dart';
import 'package:meta/meta.dart';



class LoadingCubit extends Cubit<LoadingState> {
  LoadingCubit() : super(LoadingInitial());

  showLoading(BuildContext context, String message, bool isDismissible) =>
      showProgress(context, message, isDismissible);

  hideLoading() => hideProgress();
}



@immutable
abstract class LoadingState {}

class LoadingInitial extends LoadingState {}