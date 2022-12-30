import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../../core/util/extensions.dart';
import '../../../../../auth/domain/model/user_model.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../common/app_fonts.dart';
import '../../../../../../common/image_resources.dart';
import '../../../cubit/home/home_cubit.dart';

AppBar homeAppBar(
    {required BuildContext context, required UserModel userModel}) {
  return AppBar(
    backgroundColor: Theme.of(context).colorScheme.background,
    elevation: 0,
    leadingWidth: 140,
    leading: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          onPressed: () => {},
          icon: CachedNetworkImage(
            imageUrl: userModel.imageUrl.orEmpty(),
            imageBuilder: (context, imageProvider) => Container(
              width: 9.0.w,
              height: 9.0.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) =>
                SvgPicture.asset(ImageResources.emptyAvatar),
          ),
        ),
        Flexible(
          child: Text(
            userModel.displayName,
            style:
                Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12),
          ),
        )
      ],
    ),
    actions: [
      IconButton(
        onPressed: () => {context.read<HomeCubit>().deleteAllNote()},
        icon: Icon(
          Icons.search,
          size: 32,
          color: Theme.of(context).colorScheme.onBackground,
        ),
      )
    ],
    title: Text(
      'Home',
      style: TextStyle(
        color: Theme.of(context).colorScheme.onBackground,
        fontFamily: AppFontConstants.inconsolataFontFamily,
        fontSize: AppFontSize.titleMedium,
        fontWeight: AppFontWeight.bold,
      ),
    ),
  );
}
