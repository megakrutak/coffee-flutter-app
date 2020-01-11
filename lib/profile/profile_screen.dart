import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:robo_coffee_app/lang/translator.dart';
import 'package:robo_coffee_app/profile/profile_bloc.dart';
import 'package:robo_coffee_app/profile/profile_entity.dart';
import 'package:robo_coffee_app/profile/profile_event.dart';
import 'package:robo_coffee_app/profile/profile_repo.dart';
import 'package:robo_coffee_app/profile/profile_state.dart';
import 'package:robo_coffee_app/ui/loading.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();

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
          ..add(LoadProfileEvent());
      },
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoaded) {
            return _buildProfileForm(context, state.profile, state.phone);
          }

          return Loading();
        },
      ),
        ),
    );
  }

  Widget _buildProfileForm(
      BuildContext context, UserProfile profile, String phone) {
    var trans = Translator.of(context);
    var theme = Theme.of(context);
    var firstNameController =
        TextEditingController(text: profile?.firstName ?? "");
    var emailTextController = TextEditingController(text: profile?.email ?? "");

    var birthdayTextController =
        TextEditingController(text: profile?.birthDay ?? "");

    return BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileUpdated) {
            showDialog(context: context, builder: (context) {
              return AlertDialog(
                title: Text("Updated"),
                actions: <Widget>[
                  FlatButton(child: Text("OK"), onPressed: () {
                    Navigator.of(context).pop();
                  })
                ],
              );
            });
          }
        },
        child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: firstNameController,
                    decoration: InputDecoration(
                        labelText: trans.trans("first_name_title")),
                  ),
                  TextFormField(
                    controller: emailTextController,
                    decoration:
                        InputDecoration(labelText: trans.trans("email_title")),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  DateTimeField(
                    controller: birthdayTextController,
                    decoration:
                        InputDecoration(labelText: trans.trans("birthday_title")),
                    format: DateFormat("yyyy-MM-d"),
                    onShowPicker: (context, currentValue) {
                      return showDatePicker(
                          context: context,
                          firstDate: DateTime(1900),
                          initialDate: currentValue ?? DateTime.now(),
                          lastDate: DateTime(DateTime.now().year));
                    },
                  ),
                  TextFormField(
                    controller: TextEditingController(text: phone ?? ""),
                    decoration:
                        InputDecoration(labelText: trans.trans("phone_title")),
                    enabled: false,
                  )
                ],
              ),
            ),
            SizedBox(height: 8.0),
            Text(trans.trans("orders_history_description")),
            SizedBox(height: 16.0),
            FlatButton(
              textColor: theme.accentColor,
              color: theme.primaryColor,
              child: Text(trans.trans("save_button_title")),
              onPressed: () {
                BlocProvider.of<ProfileBloc>(context).add(
                  UpdateProfileEvent(
                    profile: UserProfile(
                      firstNameController.text,
                      "",
                      emailTextController.text,
                      birthdayTextController.text
                    )
                  )
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
