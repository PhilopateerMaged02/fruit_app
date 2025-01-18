import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_app/modules/MostSeller/most_seller.dart';
import 'package:fruit_app/modules/Search/search.dart';
import 'package:fruit_app/modules/notifications/notifications.dart';
import 'package:fruit_app/shared/components.dart';
import 'package:shimmer/shimmer.dart';
import 'package:fruit_app/modules/Login/cubit/cubit.dart';
import 'package:fruit_app/shared/cubit/cubit.dart';
import 'package:fruit_app/shared/cubit/states.dart';

class Home extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FruitAppCubit, FruitAppStates>(
      listener: (BuildContext context, state) {
        if (state is FruitAppGetProductsDataLoading ||
            FruitAppCubit.get(context).productsList == null ||
            FruitAppCubit.get(context).productsList.isEmpty) {
          Center(child: Text('No products available.'));
        }
      },
      builder: (BuildContext context, Object? state) {
        return SafeArea(
          child: Column(
            children: [
              // Top Row with profile and greeting
              _buildProfileAndGreeting(context, state),

              // Search Field
              _buildSearchField(context),

              // Carousel Section
              _buildCarouselSlider(context, state),

              SizedBox(height: 16),

              // Row for "الأكثر مبيعًا" and "المزيد"
              _buildSectionHeader(context),

              // Grid Section for Fruits
              _buildFruitGrid(context, state),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProfileAndGreeting(BuildContext context, Object? state) {
    if (state is FruitAppGetProductsDataLoading) {
      return _buildShimmerRow();
    }

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 5),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage("assets/images/profile_image.png"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                Text(
                  "صباح الخير !..",
                  style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                Text(FruitAppCubit.get(context).userModel?.name ?? 'Guest',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 16)),
              ],
            ),
          ),
          Spacer(),
          InkWell(
            onTap: () {
              navigateTo(context, Notifications());
            },
            child: CircleAvatar(
              radius: 15,
              backgroundColor: Colors.green[50],
              backgroundImage: AssetImage("assets/images/notification.png"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerRow() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(radius: 25, backgroundColor: Colors.white),
            SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(width: 150, height: 15, color: Colors.white),
                SizedBox(height: 5),
                Container(width: 100, height: 15, color: Colors.white),
              ],
            ),
            Spacer(),
            CircleAvatar(radius: 15, backgroundColor: Colors.white),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField(context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: () {
          navigateTo(
              context,
              Search(
                productList: FruitAppCubit.get(context).productsList,
              ));
        },
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white, // Background color for the container
                borderRadius:
                    BorderRadius.circular(0), // Rounded corners (optional)
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.05), // Shadow color
                    spreadRadius: 1, // Spread radius
                    blurRadius: 5, // Blur radius
                    offset: Offset(0, 3), // Offset in x and y direction
                  ),
                ],
              ),
              padding:
                  EdgeInsets.all(8), // Optional padding inside the container
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    child: Image(
                      image: AssetImage("assets/images/searchnormal.png"),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "ابحث عن ...",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[400],
                    ),
                  ),
                  Spacer(),
                  Image(
                    image: AssetImage("assets/images/setting-4.jpg"),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Widget _buildCarouselSlider(BuildContext context, Object? state) {
    if (state is FruitAppGetUserDataLoading) {
      return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: double.infinity,
          height: 150,
          color: Colors.white,
        ),
      );
    }

    return SizedBox(
      height: 150,
      width: double.infinity,
      child: CarouselSlider(
        options: CarouselOptions(
          height: 150,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
          enableInfiniteScroll: true,
          pauseAutoPlayOnTouch: true,
        ),
        items: [
          "assets/images/offer.png",
          "assets/images/offer.png",
          "assets/images/offer.png",
          "assets/images/offer.png",
        ].map((imagePath) {
          return Builder(
            builder: (BuildContext context) {
              return Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
              );
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSectionHeader(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Text(
            "الأكثر مبيعًا",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Spacer(),
          TextButton(
            onPressed: () {
              navigateTo(context, MostSeller());
            },
            child: Text(
              "المزيد",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                  fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFruitGrid(BuildContext context, Object? state) {
    final productsList = FruitAppCubit.get(context).productsList;

    if (state is FruitAppGetProductsDataLoading ||
        productsList == null ||
        productsList.isEmpty) {
      return Expanded(
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 10,
            children: List.generate(
              6,
              (index) => Container(
                height: 400,
                width: double.infinity,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
    }

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 10, top: 10),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 10,
          ),
          itemCount: productsList.length,
          itemBuilder: (context, index) {
            final product = productsList[index];
            final cart = FruitAppCubit.get(context).streamList;
            return buildFruitItem(context, product);
          },
        ),
      ),
    );
  }
}
