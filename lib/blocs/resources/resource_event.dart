import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class ResourceEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadResource extends ResourceEvent {}

class ResourceLoadingFailed extends ResourceEvent {}
