import 'dart:ffi';

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
      getCartItems();
      print(cartItems.length);
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

      // Fetch products from the Supabase table
      final response = await supabase.from('products').select();

      // Cast the response to a List of dynamic maps
      final List<dynamic> products = response as List<dynamic>;

      if (products.isNotEmpty) {
        //productsList.clear();

        for (final product in products) {
          final productModel = ProductsModel(
            id: product['id'] ?? 0,
            name: product['name'] ?? '',
            price: _parsePrice(product['price']),
            image: product['image'] ?? '',
            quantity: product['quantity'] ?? 0,
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

// Helper method to parse the price field
  double _parsePrice(dynamic price) {
    if (price == null) {
      return 0.0; // Default to 0.0 if price is null
    } else if (price is int) {
      return price.toDouble(); // Convert int to double
    } else if (price is double) {
      return price; // Already a double
    } else if (price is String) {
      return double.tryParse(price) ?? 0.0; // Parse string to double
    } else {
      print('Unexpected price type: ${price.runtimeType}');
      return 0.0; // Fallback to 0.0 for unexpected types
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

      // Fetch cart items with related product data
      final response =
          await supabase.from('cart').select('*, products(*)').eq('uId', uId!);
      final List<dynamic> cart = response as List<dynamic>;

      if (cart.isNotEmpty) {
        cartItems.clear();

        for (final product in cart) {
          final cartModel = CartModel(
            id: product['id'] ?? 0,
            name: product['name'] ?? '',
            image: product['image'] ?? '',
            price: _parsePrice(product['price']),
            quantity: product['quantity'] ?? 0,
            product_id: product['product_id'] ?? 0,
          );
          cartItems.add(cartModel);
        }
        emit(FruitAppGetCartDataSuccess());
        finalPrice = 0.0;
        cartItems.forEach((element) {
          print("Quantity: ${element.quantity}");
          print("Price: ${element.price}");
          finalPrice += element.price * element.quantity;
        });
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

  double finalPrice = 0.0;
  Future<void> removeFromCart(
      int cartItemId, int quantity, int productId) async {
    final response = await supabase
        .from('products')
        .select('quantity')
        .eq(
          'id',
          productId,
        )
        .maybeSingle();
    await supabase.from('products').update({
      "quantity": response?['quantity'] + quantity,
    }).eq("id", productId);
    await Supabase.instance.client.from('cart').delete().eq('id', cartItemId);
    if (cartItems.length == 1) {
      cartItems.clear();
    }
    getCartItems();
  }

  void addtocart(int productId, int quantity, String name, String image,
      double price) async {
    emit(FruitAppAddToCartLoading());
    try {
      // Step 1: Insert into the cart table

      // Step 2: Retrieve the current quantity from the products table
      final response = await supabase
          .from('products')
          .select('quantity')
          .eq('id', productId)
          .single();

      if (response != null &&
          response['quantity'] >= quantity &&
          response['quantity'] > 0) {
        // Step 3: Decrement the quantity in the products table
        await supabase.from('products').update({
          "quantity": response['quantity'] - quantity,
        }).eq('id', productId);
        await supabase.from('cart').insert({
          "product_id": productId,
          "uId": uId,
          "quantity": quantity,
          "name": name,
          "image": image,
          "price": price
        });
        emit(FruitAppAddToCartSuccess());
        getCartItems();
      } else {
        emit(FruitAppAddToCartError());
        print("Error: Insufficient quantity available.");
      }
    } catch (error) {
      print("Error in adding to cart: $error");
      emit(FruitAppAddToCartError());
    }
  }

  void increaseItemInCart(int productId, int quantity, String name,
      String image, double price, int CartId) async {
    emit(FruitAppAddToCartLoading());
    try {
      // Fetch the product from the products table
      final response = await supabase
          .from('products')
          .select('quantity')
          .eq('id', productId)
          .maybeSingle(); // Use maybeSingle() to avoid errors when no rows are returned

      if (response == null) {
        emit(FruitAppAddToCartError());
        print("Error: Product not found.");
        return;
      }

      // Log the actual quantity from the database and requested quantity
      print("Database Quantity: ${response['quantity']}");
      print("Requested Quantity: $quantity");

      // Ensure there is enough quantity in stock
      if (response['quantity'] >= quantity &&
          response['quantity'] > 0 &&
          quantity > 0) {
        // Update the product quantity
        await supabase.from('products').update({
          "quantity": response['quantity'] - 1,
        }).eq('id', productId);

        // Update the cart quantity
        await supabase.from('cart').update({
          "quantity": quantity + 1,
        }).eq("id", CartId);

        emit(FruitAppAddToCartSuccess());
        getCartItems();
      } else {
        emit(FruitAppAddToCartError());
        print("Error: Insufficient quantity available.");
      }
    } catch (error) {
      print("Error in adding to cart: $error");
      emit(FruitAppAddToCartError());
    }
  }

  void decreaseItemInCart(int productId, int quantity, String name,
      String image, double price, int CartId) async {
    emit(FruitAppRemoveFromCartLoading());
    try {
      // Fetch the product from the products table
      final response = await supabase
          .from('products')
          .select('quantity')
          .eq('id', productId)
          .maybeSingle();

      if (response == null) {
        emit(FruitAppRemoveFromCartError());
        print("Error: Product not found.");
        return;
      }

      print("Database Quantity: ${response['quantity']}");
      print("Requested Quantity: $quantity");

      if (quantity > 0) {
        await supabase.from('products').update({
          "quantity": response['quantity'] + 1,
        }).eq('id', productId);

        await supabase.from('cart').update({
          "quantity": quantity - 1,
        }).eq("id", CartId);
        emit(FruitAppRemoveFromCartSuccess());
        getCartItems();
      } else if (quantity == 0) {
        await supabase.from('cart').delete().eq("id", CartId);
        cartItems.clear();
        getCartItems();
        emit(FruitAppRemoveFromCartSuccess());
      } else {
        emit(FruitAppRemoveFromCartError());
        print("Error: Insufficient quantity available.");
        getCartItems();
      }
    } catch (error) {
      print("Error in adding to cart: $error");
      emit(FruitAppRemoveFromCartError());
    }
  }
}
