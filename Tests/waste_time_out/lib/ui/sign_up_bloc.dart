import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';



class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    ImagePicker _imagePicker = ImagePicker();

    on<RetrieveLostDataEvent>((event, emit) async {
      final LostDataResponse? response = await _imagePicker.retrieveLostData();
      if (response != null && response.file != null) {
        emit(PictureSelectedState(imageFile: File(response.file!.path)));
      }
    });

    on<ChooseImageFromGalleryEvent>((event, emit) async {
      XFile? xImage = await _imagePicker.pickImage(source: ImageSource.gallery);
      if (xImage != null) {
        emit(PictureSelectedState(imageFile: File(xImage.path)));
      }
    });

    on<CaptureImageByCameraEvent>((event, emit) async {
      XFile? xImage = await _imagePicker.pickImage(source: ImageSource.camera);
      if (xImage != null) {
        emit(PictureSelectedState(imageFile: File(xImage.path)));
      }
    });

    on<ValidateFieldsEvent>((event, emit) async {
      if (event.key.currentState?.validate() ?? false) {
        if (event.acceptEula) {
          event.key.currentState!.save();
          emit(ValidFields());
        } else {
          emit(SignUpFailureState(
              errorMessage: 'Please accept our terms of use.'));
        }
      } else {
        emit(SignUpFailureState(errorMessage: 'Please fill required fields.'));
      }
    });

    on<ToggleEulaCheckboxEvent>(
            (event, emit) => emit(EulaToggleState(event.eulaAccepted)));
  }
}


//part of 'sign_up_bloc.dart';

abstract class SignUpEvent {}

class RetrieveLostDataEvent extends SignUpEvent {}

class ChooseImageFromGalleryEvent extends SignUpEvent {
  ChooseImageFromGalleryEvent();
}

class CaptureImageByCameraEvent extends SignUpEvent {
  CaptureImageByCameraEvent();
}

class ValidateFieldsEvent extends SignUpEvent {
  GlobalKey<FormState> key;
  bool acceptEula;

  ValidateFieldsEvent(this.key, {required this.acceptEula});
}

class ToggleEulaCheckboxEvent extends SignUpEvent {
  bool eulaAccepted;

  ToggleEulaCheckboxEvent({required this.eulaAccepted});
}

//part of 'sign_up_bloc.dart';

abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class PictureSelectedState extends SignUpState {
  File? imageFile;

  PictureSelectedState({required this.imageFile});
}

class SignUpFailureState extends SignUpState {
  String errorMessage;

  SignUpFailureState({required this.errorMessage});
}

class ValidFields extends SignUpState {}

class EulaToggleState extends SignUpState {
  bool eulaAccepted;

  EulaToggleState(this.eulaAccepted);
}