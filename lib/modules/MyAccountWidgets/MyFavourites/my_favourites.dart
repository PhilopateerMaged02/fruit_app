import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_app/shared/components.dart';
import 'package:fruit_app/shared/cubit/cubit.dart';
import 'package:fruit_app/shared/cubit/states.dart';

class MyFavourites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "المفضلة",
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_outlined),
        ),
      ),
      body: BlocConsumer<FruitAppCubit, FruitAppStates>(
        listener: (BuildContext context, FruitAppStates state) {
          if (state is FruitAppGetFavouritesDataLoading) {
            Center(child: CircularProgressIndicator());
          }
        },
        builder: (BuildContext context, FruitAppStates state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10, top: 10),
                  child: SizedBox(
                    height: MediaQuery.of(context)
                        .size
                        .height, // Set a specific height
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: FruitAppCubit.get(context).favList.length,
                      itemBuilder: (context, index) {
                        final product =
                            FruitAppCubit.get(context).favList[index];
                        return buildFruitItemInFav(context, product, () {
                          FruitAppCubit.get(context).toggleFavorite(product.id);
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
