import 'package:JWTAuthApp/models/model.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class ResourceState extends Equatable {
  @override
  List<Object> get props => [];
}

class ResourceLoading extends ResourceState {}

class ResourceWaiting extends ResourceState {}

class ResourceLoaded extends ResourceState {
  final ResourcesResponse resources;

  ResourceLoaded({@required this.resources});

  @override
  List<Object> get props => [resources];
}

class ResourceFailure extends ResourceState {
  final String error;

  ResourceFailure({@required this.error});

  @override
  List<Object> get props => [error];
}
