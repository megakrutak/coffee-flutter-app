import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:robo_coffee_app/lang/translator.dart';
import 'package:robo_coffee_app/profile/profile_bloc.dart';
import 'package:robo_coffee_app/profile/profile_entity.dart';
import 'package:robo_coffee_app/profile/profile_event.dart';
import 'package:robo_coffee_app/profile/profile_repo.dart';
import 'package:robo_coffee_app/profile/profile_state.dart';
import 'package:robo_coffee_app/ui/loading.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var translator = Translator.of(context);
    GetIt getIt = GetIt.instance;

    return Scaffold(
      appBar: AppBar(
        title: Text(translator.trans('user_profile_title')),
      ),
      body: BlocProvider<ProfileBloc>(
        create: (context) {
          return ProfileBloc(profileRepo: getIt.get<ProfileRepository>())
            ..add(LoadProfile());
        },
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoaded) {
              return _buildProfileForm(context, state.profile);
            }

            return Loading();
          },
        ),
      ),    
    );
  }

  Widget _buildProfileForm(BuildContext context, UserProfile profile) {
    return Center(child: Text("dfgdf"));
  }
}
