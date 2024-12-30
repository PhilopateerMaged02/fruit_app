import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_app/shared/cubit/cubit.dart';
import 'package:fruit_app/shared/cubit/states.dart';

class FruitappLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FruitAppCubit, FruitAppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        return Scaffold(
          body: FruitAppCubit.get(context)
              .Screens[FruitAppCubit.get(context).currentIndex],
          bottomNavigationBar: Material(
            elevation: 8, // Add elevation for shadow effect
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), // Curve for top-left corner
              topRight: Radius.circular(30), // Curve for top-right corner
            ),
            child: ClipRRect(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              child: BottomNavigationBar(
                currentIndex: FruitAppCubit.get(context).currentIndex,
                type: BottomNavigationBarType.fixed,
                elevation: 0, // Remove default BottomNavigationBar elevation
                backgroundColor: Colors.white, // Set background color to white
                selectedItemColor: Colors.green,
                unselectedItemColor: Colors.grey,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                onTap: (index) {
                  FruitAppCubit.get(context).changeIndex(index);
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Image(
                      image: (FruitAppCubit.get(context).x ?? false)
                          ? AssetImage("assets/images/homeActive.png")
                          : AssetImage("assets/images/homeInActive.png"),
                    ),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    icon: Image(
                      image: (FruitAppCubit.get(context).y ?? false)
                          ? AssetImage("assets/images/categoriesActive.png")
                          : AssetImage("assets/images/CategoriesInActive.png"),
                    ),
                    label: "Categories",
                  ),
                  BottomNavigationBarItem(
                    icon: Image(
                      image: (FruitAppCubit.get(context).w ?? false)
                          ? AssetImage("assets/images/cartActive.png")
                          : AssetImage("assets/images/cartInActive.png"),
                    ),
                    label: "Cart",
                  ),
                  BottomNavigationBarItem(
                    icon: Image(
                      image: (FruitAppCubit.get(context).z ?? false)
                          ? AssetImage("assets/images/myaccountActive.png")
                          : AssetImage("assets/images/userInActive.png"),
                    ),
                    label: "My Account",
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
