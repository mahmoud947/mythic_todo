import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'components/home_app_bar.dart';
import 'components/home_body.dart';

import '../../../../auth/domain/model/user_model.dart';

import '../../cubit/home/home_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.userModel}) : super(key: key);
  final UserModel userModel;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getNotes();
  }

  @override
  void dispose() {
    context.read<HomeCubit>().close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat.MMMEd();
    final date = dateFormat.format(DateTime.now());
    return Scaffold(
      appBar: homeAppBar(
        context: context,
        userModel: widget.userModel,
      ),
      body: HomeBody(date: date),
    );
  }
}
