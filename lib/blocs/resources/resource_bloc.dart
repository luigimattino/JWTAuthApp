import '../../blocs/auth/auth.dart';

import '../../models/model.dart';
import '../../services/resource-api/resource_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_session/flutter_session.dart';
import 'resource_event.dart';
import 'resource_state.dart';

class ResourceBloc extends Bloc<ResourceEvent, ResourceState> {
  final AuthBloc _authBloc;
  final ResourceService _resourceService;
  ResourceBloc(AuthBloc authenticationBloc, ResourceService resourceService)
      : assert(authenticationBloc != null),
        assert(resourceService != null),
        _authBloc = authenticationBloc,
        _resourceService = resourceService,
        super(ResourceLoading());

  @override
  Stream<ResourceState> mapEventToState(ResourceEvent event) async* {
    if (event is LoadResource) {
      yield* _mapLoadResourceToState();
    }
  }

  Stream<ResourceState> _mapLoadResourceToState() async* {
    yield ResourceLoading();
    try {
      final accessToken = await FlutterSession().get('accessToken');
      var result = await _resourceService.doResources(accessToken);
      if (result is ResourcesResponse) {
        yield ResourceLoaded(resources: result);
      } else if (result is AuthError) {
        _authBloc.add(AuthRefresh());
        yield ResourceWaiting();
      } else {
        yield ResourceFailure(error: 'An unexpected error occured');
      }
    } catch (err) {
      yield ResourceFailure(
          error: err.message || err.message.isEmpty ??
              'An unexpected error occured');
    }
  }
}
