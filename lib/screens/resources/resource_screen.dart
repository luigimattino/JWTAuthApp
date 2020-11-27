import '../../app_routes.dart';
import '../../blocs/auth/auth.dart';
import '../../blocs/resources/resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResourcesScreen extends StatefulWidget {
  @override
  _ResourcesScreenState createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourcesScreen> {
  ResourceBloc _resourceBloc;
  @override
  void initState() {
    _resourceBloc = BlocProvider.of<ResourceBloc>(context);
    _resourceBloc.add(LoadResource());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          Navigator.pushReplacementNamed(
            context,
            AppRoutes.LoginRoute,
          );
        }
        if (state is AuthRefreshed) {
          _resourceBloc.add(LoadResource());
        }
      },
      child:
          BlocBuilder<ResourceBloc, ResourceState>(builder: (context, state) {
        if (state is ResourceLoaded) {
          return Container(
            child: Column(
              children: [
                Text('Resources'),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.resources.resources.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Text(
                                state.resources.resources[index].surname,
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(state.resources.resources[index].name),
                            ],
                          )),
                    );
                  },
                )
              ],
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor:
                AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
          ),
        );
      }),
    );
  }
}
