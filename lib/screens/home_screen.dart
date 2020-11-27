import '../blocs/resources/resource.dart';
import '../screens/resources/resource_screen.dart';
import '../services/resource-api/resource_service.dart';
import '../blocs/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resources page'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(AuthLoggedOut());
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
            /*child: Text("Hello, ${user.email}"),*/
            child: Text("Here below are listed the resources"),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: BlocProvider<ResourceBloc>(
                create: (context) {
                  final authBloc = BlocProvider.of<AuthBloc>(context);
                  final resourceService =
                      RepositoryProvider.of<ResourceService>(context);
                  return ResourceBloc(authBloc, resourceService);
                },
                child: ResourcesScreen()),
          ),
        ],
      ),
    );
  }
}
