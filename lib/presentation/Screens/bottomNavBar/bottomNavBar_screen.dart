import 'package:amira_app/blocs/addDeliveryLocation/location_add_bloc.dart';
import 'package:amira_app/blocs/cart/cartButton/cart_button_bloc.dart';
import 'package:amira_app/blocs/favButton/favbutton_bloc.dart';
import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/config/theme/theme.dart';
import 'package:amira_app/presentation/Screens/cart/cart_screen.dart';
import 'package:amira_app/presentation/Screens/cataloge/cataloge_screen.dart';
import 'package:amira_app/presentation/Screens/favorite/favorite_screen.dart';
import 'package:amira_app/presentation/Screens/home/home_screen.dart';
import 'package:amira_app/presentation/Screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FavButtonBloc()..add(LoadFavEvent()),
        ),
        BlocProvider(
          create: (context) => CartButtonBloc()..add(LoadCartEvent()),
        ),
        BlocProvider(
          create: (context) =>
              LocationAddBloc()..add(const LoadAddressEvent('')),
        ),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: PersistentTabView(
          stateManagement: true,
          resizeToAvoidBottomInset: false,
          tabs: List.generate(
            bottomNavBarItems.length,
            (index) => PersistentTabConfig(
              screen: getScreenForIndex(index),
              item: ItemConfig(
                inactiveIcon:
                    SvgPicture.asset(bottomNavBarItems[index]['icon']),
                icon: SvgPicture.asset(
                  bottomNavBarItems[index]['iconBold'],
                  colorFilter:
                      ColorFilter.mode(AppColors.purpleColor, BlendMode.srcIn),
                ),
                activeColorSecondary: AppColors.purpleColor,
              ),
            ),
          ),
          navBarBuilder: (navBarConfig) =>
              Style11BottomNavBar(navBarConfig: navBarConfig),
        ),
      ),
    );
  }

  Widget getScreenForIndex(int index) {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        return const CatelogeScreen();
      case 2:
        return const CartScreen();
      case 3:
        return const FavoriteScreen();
      default:
        return const ProfileScreen();
    }
  }
}
