import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_app/main.dart';
import 'package:fruit_app/models/CartModel/cart_model.dart';
import 'package:fruit_app/models/ProductsModel/products_model.dart';
import 'package:fruit_app/models/UserModel/user_model.dart';
import 'package:fruit_app/modules/Cart/cart.dart';
import 'package:fruit_app/modules/Home/home.dart';
import 'package:fruit_app/modules/Login/login_screen.dart';
import 'package:fruit_app/modules/MyAccount/myaccount.dart';
import 'package:fruit_app/modules/Products/products.dart';
import 'package:fruit_app/shared/components.dart';
import 'package:fruit_app/shared/constants.dart';
import 'package:fruit_app/shared/cubit/states.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FruitAppCubit extends Cubit<FruitAppStates> {
  FruitAppCubit() : super(FruitAppInitialStates());
  static FruitAppCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;
  ProductsModel? productsModel;

  int currentIndex = 0;
  List<Widget> Screens = [Home(), Products(), Cart(), MyAccount()];
  // List<String> Titles = [
  //   "Home",
  //   "Products",
  //   "Cart",
  //   "MyAccount",
  // ];
  bool? x = true, y, w, z;
  bool radio1 = false, radio2 = false, radio3 = false;
  void changeRadio1() {
    radio1 = true;
    radio2 = false;
    radio3 = false;
    emit(FruitAppChangeRadioState());
  }

  void changeRadio2() {
    radio1 = false;
    radio2 = true;
    radio3 = false;
    emit(FruitAppChangeRadioState());
  }

  void changeRadio3() {
    radio1 = false;
    radio2 = false;
    radio3 = true;
    emit(FruitAppChangeRadioState());
  }

  void changeIndex(int index) {
    currentIndex = index;
    if (currentIndex == 0) {
      x = true;
      y = false;
      w = false;
      z = false;
    } else if (currentIndex == 1) {
      y = true;
      x = false;
      w = false;
      z = false;
    } else if (currentIndex == 2) {
      w = true;
      x = false;
      y = false;
      z = false;
    } else if (currentIndex == 3) {
      z = true;
      x = false;
      y = false;
      w = false;
    }
    emit(FruitAppChangeBottomNavStates());
  }

  void getUserData() async {
    emit(FruitAppGetUserDataLoading());
    final response = await supabase.auth.getUser();
    final user = response.user;

    if (user != null) {
      emit(FruitAppGetUserDataSuccess());
      final userMetadata = user.userMetadata;
      userModel = UserModel(
        uId: user.id,
        email: user.email!,
        name: userMetadata?['Display name'] ?? '',
        phone: userMetadata?['Phone'] ?? '',
        profile_image: userMetadata?['profile_image'] ?? '',
      );
      print('Email: ${user.email}');
      print('Name: ${userModel!.name}');
      print('Phone: ${userModel!.phone}');
      print('Profile_IMAGE: ${userModel!.profile_image}');
    } else {
      emit(FruitAppGetUserDataError());
      print('No user is logged in');
    }
  }

  List<ProductsModel> productsList = [];

  void getProductsData() async {
    try {
      emit(FruitAppGetProductsDataLoading());

      final response = await supabase.from('products').select();
      final List<dynamic> products = response as List<dynamic>;

      if (products.isNotEmpty) {
        productsList.clear();
        for (final product in products) {
          final productModel = ProductsModel(
            id: product['id'],
            name: product['name'],
            price: product['price'],
            image: product['image'],
            quantity: product['quantity'],
          );
          productsList.add(productModel);
        }
        emit(FruitAppGetProductsDataSuccess());
        print('Fetched ${productsList.length} products.');
      } else {
        emit(FruitAppGetProductsDataError());
        print('No products found in the database.');
      }
    } catch (e) {
      emit(FruitAppGetProductsDataError());
      print('Error fetching products: $e');
    }
  }

  ////////////////////////////////////////////////////
  Future<void> sendOtp(String emailOrPhone) async {
    try {
      await supabase.auth.signInWithOtp(
        email: emailOrPhone, // Replace with phone number if needed
        emailRedirectTo:
            'com.example.app://reset-callback', // Use a custom URL for email-based resets
      );
      print('OTP sent successfully.');
    } catch (error) {
      print('Error sending OTP: $error');
    }
  }

  Future<void> sendOtpToPhone(String phoneNumber) async {
    try {
      await Supabase.instance.client.auth.signInWithOtp(
        phone: phoneNumber,
      );
      print('OTP sent to $phoneNumber');
    } catch (error) {
      print('Error sending OTP: $error');
    }
  }

  void signOut(context) async {
    await supabase.auth.signOut();
    uId = null;
    navigateToandKill(context, LoginScreen());
    print(uId);
  }

  void signOutt(BuildContext context) async {
    try {
      await supabase.auth.signOut();
      await supabase.removeAllChannels();
      final prefs = await SharedPreferences.getInstance();
      prefs.remove('uId');
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => MyApp(
                  startWidget: LoginScreen(),
                )),
        (Route<dynamic> route) => false,
      );
    } catch (error) {
      print('Error signing out: $error');
    }
  }

////////////////////////////////////////////////////////////

  List<CartModel> cartItems = [];

  void getCartItems() async {
    try {
      emit(FruitAppGetCartDataLoading());

      final response =
          await supabase.from('cart').select('*, products(*)').eq('uId', uId!);
      final List<dynamic> cart = response as List<dynamic>;

      if (cart.isNotEmpty) {
        productsList.clear();
        for (final product in cart) {
          final cartModel = CartModel(
            id: product['id'],
            name: product['name'],
            image: product['image'],
            quantity: product['quantity'],
            product_id: product['product_id'],
          );
          cartItems.add(cartModel);
        }
        emit(FruitAppGetCartDataSuccess());
        print('Fetched ${cartItems.length} products.');
      } else {
        emit(FruitAppGetCartDataError());
        print('No products found in the cart.');
      }
    } catch (e) {
      emit(FruitAppGetCartDataError());
      print('Error fetching products: $e');
    }
  }

  Future<void> removeFromCart(String cartItemId) async {
    await Supabase.instance.client.from('cart').delete().eq('id', cartItemId);
  }

  void addtocart(int productId, int quantity, String name, String image) async {
    emit(FruitAppAddToCartLoading());
    try {
      // Step 1: Insert into the cart table
      await supabase.from('cart').insert({
        "product_id": productId,
        "uId": uId,
        "quantity": quantity,
        "name": name,
        "image": image,
      });

      // Step 2: Retrieve the current quantity from the products table
      final response = await supabase
          .from('products')
          .select('quantity')
          .eq('id', productId)
          .single();

      if (response != null && response['quantity'] >= quantity) {
        // Step 3: Decrement the quantity in the products table
        await supabase.from('products').update({
          "quantity": response['quantity'] - quantity,
        }).eq('id', productId);

        emit(FruitAppAddToCartSuccess());
      } else {
        emit(FruitAppAddToCartError());
        print("Error: Insufficient quantity available.");
      }
    } catch (error) {
      print("Error in adding to cart: $error");
      emit(FruitAppAddToCartError());
    }
  }
}
