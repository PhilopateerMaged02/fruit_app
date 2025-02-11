import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_app/Service/DioHelper.dart';
import 'package:fruit_app/main.dart';
import 'package:fruit_app/models/CartModel/cart_model.dart';
import 'package:fruit_app/models/FavouritesModel/favourites_model.dart';
import 'package:fruit_app/models/OrdersModel/orders_model.dart';
import 'package:fruit_app/models/PaymentCreditCardModel/payment_credit_card_model.dart';
import 'package:fruit_app/models/ProductsModel/products_model.dart';
import 'package:fruit_app/models/ReviewsModel/reviews_model.dart';
import 'package:fruit_app/models/UserModel/user_model.dart';
import 'package:fruit_app/modules/Cart/cart.dart';
import 'package:fruit_app/modules/HomeWidgets/Home/home.dart';
import 'package:fruit_app/modules/AuthunticationWidgets/Login/login_screen.dart';
import 'package:fruit_app/modules/MyAccountWidgets/MyAccount/myaccount.dart';
import 'package:fruit_app/modules/ProductsWidgets/Products/products.dart';
import 'package:fruit_app/shared/components.dart';
import 'package:fruit_app/shared/constants.dart';
import 'package:fruit_app/shared/cubit/states.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FruitAppCubit extends Cubit<FruitAppStates> {
  FruitAppCubit() : super(FruitAppInitialStates()) {
    _loadFavorites();
  }
  static FruitAppCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;
  ProductsModel? productsModel;
  CartModel? cartModel;
  ReviewsModel? reviewsModel;
  bool fruitItemIsClicked = false;
  int currentIndex = 0;
  String refrenceCode = '';
  String address = "";
  String city = "";
  String floorApart = "";
  File? profileImage;
  String emailForForgetPass = "";
  ImagePicker picker = ImagePicker();
  bool isPaymentSuccess = false;
  //bool isEnabled1 = false;
  //bool isEnabled2 = false;
  List<Widget> Screens = [Home(), Products(), Cart(), MyAccount()];
  // List<String> Titles = [
  //   "Home",
  //   "Products",
  //   "Cart",
  //   "MyAccount",
  // ];
  bool? x = true, y, w, z;
  bool? pay1 = false;
  bool? pay2 = false;
  // bool? address = false;
  // bool? payment = false;
  // bool? review = false;
  bool? saveAddress = false;
  bool? creditCard = false;
  bool? visa = false;
  bool? mastercard = false;
  bool? paypal = false;
  bool? applepay = false;
  bool radio1 = false, radio2 = false, radio3 = false;
  bool star1 = false,
      star2 = false,
      star3 = false,
      star4 = false,
      star5 = false;
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

  void changeRadioPay1() {
    pay1 = true;
    pay2 = false;
    emit(FruitAppChangeRadioState());
  }

  void changeRadioPay2() {
    pay1 = false;
    pay2 = true;
    emit(FruitAppChangeRadioState());
  }

  void changeSaveAddress() {
    saveAddress = !saveAddress!;
    emit(FruitAppChangeSwitchState());
  }

  void changeCheckBox() {
    creditCard = !creditCard!;
    emit(FruitAppChangeCheckBoxState());
  }

  void changePaymentMethodToVisa() {
    visa = true;
    mastercard = false;
    paypal = false;
    applepay = false;
    emit(FruitAppChangePaymentMethodState());
  }

  void changePaymentMethodToMastercard() {
    visa = false;
    mastercard = true;
    paypal = false;
    applepay = false;
    emit(FruitAppChangePaymentMethodState());
  }

  void changePaymentMethodToPaypal() {
    visa = false;
    mastercard = false;
    paypal = true;
    applepay = false;
    emit(FruitAppChangePaymentMethodState());
  }

  void changePaymentMethodToApplepay() {
    visa = false;
    mastercard = false;
    paypal = false;
    applepay = true;
    emit(FruitAppChangePaymentMethodState());
  }

  // void changeTextEditing1() {
  //   isEnabled1 = !isEnabled1;
  //   emit(FruitAppChangeTextEditingState());
  // }

  // void changeTextEditing2() {
  //   isEnabled2 = !isEnabled2;
  //   emit(FruitAppChangeTextEditingState());
  // }
  // void changeRadioAddress() {
  //   address = true;
  //   emit(FruitAppChangeRadioState());
  // }

  // void changeRadioPayment() {
  //   payment = true;
  //   emit(FruitAppChangeRadioState());
  // }

  // void changeRadioReview() {
  //   review = true;
  //   emit(FruitAppChangeRadioState());
  // }

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

  bool visibility1 = true;
  bool visibility2 = true;
  bool visibility3 = true;
  bool visibility4 = true;
  bool visibility5 = true;
  IconData suffix1 = Icons.visibility_outlined;
  IconData suffix2 = Icons.visibility_outlined;
  IconData suffix3 = Icons.visibility_outlined;
  IconData suffix4 = Icons.visibility_outlined;
  IconData suffix5 = Icons.visibility_outlined;
  void changeVisibility1() {
    visibility1 = !visibility1;
    suffix1 =
        visibility1 ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(FruitAppChangePasswordVisibilityState());
  }

  void changeVisibility2() {
    visibility2 = !visibility2;
    suffix2 =
        visibility2 ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(FruitAppChangePasswordVisibilityState());
  }

  void changeVisibility3() {
    visibility3 = !visibility3;
    suffix3 =
        visibility3 ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(FruitAppChangePasswordVisibilityState());
  }

  void changeVisibility4() {
    visibility4 = !visibility4;
    suffix4 =
        visibility4 ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(FruitAppChangePasswordVisibilityState());
  }

/*************  ✨ Codeium Command ⭐  *************/
  /// Change the visibility of the password field in the login screen
  ///
  /// This function toggles the visibility of the password field in the login
  /// screen. When the visibility is set to true, the password field is visible
  /// and the suffix of the text field is set to [Icons.visibility_outlined]. When
  /// the visibility is set to false, the password field is obscured and the
  /// suffix of the text field is set to [Icons.visibility_off_outlined].
  ///
  /// After changing the visibility, this function emits a
  /// [FruitAppChangePasswordVisibilityState] event to notify the UI to update
  /// the password field according to the new visibility state.
/******  7eb39b3d-98de-4b1d-a981-d4a8d8fb5c43  *******/ void
      changeVisibility5() {
    visibility5 = !visibility5;
    suffix5 =
        visibility5 ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(FruitAppChangePasswordVisibilityState());
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
      await supabase.from("favourites").delete().eq('uId', uId!);
      final prefs = await SharedPreferences.getInstance();
      prefs.remove('uId');
      prefs.remove('favItems');
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

  Stream<List<Map<String, dynamic>>> get streamList {
    return supabase
        .from('cart')
        .stream(primaryKey: ['id'])
        .eq('uId', uId!)
        .map((data) {
          print("Stream data updated: $data");
          return data;
        });
  }

  void removeCart() async {
    await supabase.from('cart').delete().eq('uId', uId!);
  }

  void getCartItems() async {
    try {
      //emit(FruitAppGetCartDataLoading());
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
        //emit(FruitAppGetCartDataSuccess());
        finalPrice = 0.0;
        cartItems.forEach((element) {
          print("Quantity: ${element.quantity}");
          print("Price: ${element.price}");
          finalPrice += element.price * element.quantity;
        });
        print('Fetched ${cartItems} products.');
        print('Fetched ${cartItems.length} products.');
      } else {
        //emit(FruitAppGetCartDataError());
        print('No products found in the cart.');
      }
    } catch (e) {
      //emit(FruitAppGetCartDataError());
      print('Error fetching products: $e');
    }
  }

  double finalPrice = 0.0;
  Future<void> removeFromCart(
      int cartItemId, int quantity, int productId) async {
    emit(FruitAppRemoveFromCartLoading());
    final response = await supabase
        .from('products')
        .select('quantity')
        .eq('id', productId)
        .maybeSingle();

    if (response != null) {
      // Update product quantity in the 'products' table
      await supabase.from('products').update({
        "quantity": response['quantity'] + quantity,
      }).eq("id", productId);
      await supabase.from('cart').delete().eq('id', cartItemId);

      emit(FruitAppRemoveFromCartSuccess());
    } else {
      emit(FruitAppRemoveFromCartError());
    }
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
        print('Fetched ${cartItems} products.');
        print('Fetched ${cartItems.length} products.');
        emit(FruitAppAddToCartSuccess());
        getCartItems();
      } else {
        emit(FruitAppAddToCartError());
        String error = "Error: Insufficient quantity available";
        print("Error: Insufficient quantity available.");
        if (error.toString().contains("Insufficient quantity")) {
          showToust(message: "لا يوجد كمية كافية", state: ToastStates.ERROR);
        }
      }
    } catch (error) {
      print("Error in adding to cart: $error");
      emit(FruitAppAddToCartError());
    }
  }

  void increaseItemInCart(int productId, int quantity, String name,
      String image, double price, int CartId) async {
    //emit(FruitAppAddToCartLoading());
    try {
      // Fetch the product from the products table
      final response = await supabase
          .from('products')
          .select('quantity')
          .eq('id', productId)
          .maybeSingle(); // Use maybeSingle() to avoid errors when no rows are returned

      if (response == null) {
        //emit(FruitAppAddToCartError());
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
        finalPrice += price;
        print(finalPrice);
        //emit(FruitAppAddToCartSuccess());
        //getCartItems();
      } else {
        //emit(FruitAppAddToCartError());
        print("Error: Insufficient quantity available.");
      }
    } catch (error) {
      print("Error in adding to cart: $error");
      //emit(FruitAppAddToCartError());
    }
  }

  void decreaseItemInCart(int productId, int quantity, String name,
      String image, double price, int CartId) async {
    //emit(FruitAppRemoveFromCartLoading());
    try {
      // Fetch the product from the products table
      final response = await supabase
          .from('products')
          .select('quantity')
          .eq('id', productId)
          .maybeSingle();

      if (response == null) {
        //emit(FruitAppRemoveFromCartError());
        print("Error: Product not found.");
        return;
      }

      print("Database Quantity: ${response['quantity']}");
      print("Requested Quantity: $quantity");

      if (quantity >= 1) {
        await supabase.from('products').update({
          "quantity": response['quantity'] + 1,
        }).eq('id', productId);

        await supabase.from('cart').update({
          "quantity": quantity - 1,
        }).eq("id", CartId);
        finalPrice -= price;
        print(finalPrice);
        //emit(FruitAppRemoveFromCartSuccess());
        //getCartItems();
        print(cartItems.length);
      } else if (quantity <= 0) {
        await supabase.from('cart').delete().eq("id", CartId);
        finalPrice -= price;
        print(finalPrice);
        getCartItems();
        //emit(FruitAppRemoveFromCartSuccess());
      } else {
        //emit(FruitAppRemoveFromCartError());
        print("Error: Insufficient quantity available.");
        //getCartItems();
      }
    } catch (error) {
      print("Error in adding to cart: $error");
      //emit(FruitAppRemoveFromCartError());
    }
  }

  void changeFruitItemIcon(CartModel cart, productId) {
    if (cart.product_id == productId) {
      fruitItemIsClicked = !fruitItemIsClicked;
    }
    emit(FruitAppChangeFruitItemState());
  }

  void createReview({
    required String name,
    required String image,
    required String time,
    required String comment,
    required int rate,
    required int product_id,
  }) async {
    emit(FruitAppCreateReviewLoading());
    supabase.from('reviews').insert({
      "uId": uId,
      "name": name,
      "image": image,
      "product_id": product_id,
      "rate": rate,
      "comment": comment,
      "time": time,
    }).then((value) {
      emit(FruitAppCreateReviewSuccess());
    }).catchError((error) {
      emit(FruitAppCreateReviewError());
      print(error.toString());
    });
  }

  List<ReviewsModel> reviewsList = [];

  void getReviewsData({
    required int product_id,
  }) async {
    try {
      emit(FruitAppGetReviewsDataLoading());

      reviewsList.clear();
      final response =
          await supabase.from('reviews').select().eq("product_id", product_id);

      // Cast the response to a List of dynamic maps
      final List<dynamic> reviews = response as List<dynamic>;

      if (reviews.isNotEmpty) {
        //productsList.clear();

        for (final review in reviews) {
          final reviewModel = ReviewsModel(
            id: review['id'] ?? 0,
            name: review['name'] ?? '',
            image: review['image'] ?? '',
            comment: review['comment'] ?? '',
            product_id: review['product_id'] ?? 0,
            rate: review['rate'] ?? 0,
            time: review['time'] ?? '',
            uId: review['uId'] ?? '',
          );
          reviewsList.add(reviewModel);
        }

        emit(FruitAppGetReviewsDataSuccess());
        print('Fetched ${reviewsList.length} products.');
      } else {
        emit(FruitAppGetReviewsDataError());
        print('No products found in the database.');
      }
    } catch (e) {
      emit(FruitAppGetReviewsDataError());
      print('Error fetching products: $e');
    }
  }

  Future<void> getAuthToken() async {
    emit(FruitAppGetAuthTokenLoading());
    Diohelper.postDataDio(url: ApiContest.getAuthToken, data: {
      "api_key": ApiContest.paymentApiKey,
    }).then((value) {
      ApiContest.paymentFirstToken = value.data['token'];
      print("the token is : " + ApiContest.paymentFirstToken);
      emit(FruitAppGetAuthTokenSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(FruitAppGetAuthTokenError());
    });
  }

  Future<void> getOrderRegisterationId({
    required String firstName,
    required String email,
    required String price,
  }) async {
    emit(FruitAppGetOrderRegisterationIdLoading());
    Diohelper.postDataDio(url: ApiContest.getOrderId, data: {
      "auth_token": ApiContest.paymentFirstToken,
      "amount_cents": price,
    }).then((value) {
      ApiContest.paymentOrderId = value.data['id'].toString();
      print("the payment order id token is : " + ApiContest.paymentOrderId);
      getPaymentRequest(firstName: firstName, email: email, price: price);
      emit(FruitAppGetOrderRegisterationIdSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(FruitAppGetOrderRegisterationIdError());
    });
  }

  Future<void> getPaymentRequest({
    required String firstName,
    required String email,
    required String price,
  }) async {
    emit(FruitAppGetPaymentRequestLoading());
    Diohelper.postDataDio(url: ApiContest.getPaymentId, data: {
      "auth_token": ApiContest.paymentFirstToken,
      "amount_cents": price,
      "expiration": "3600",
      "order_id": ApiContest.paymentOrderId,
      "billing_data": {
        "apartment": "NA",
        "first_name": firstName,
        "last_name": "NA",
        "street": "NA",
        "building": "NA",
        "phone_number": "NA",
        "city": "NA",
        "country": "NA",
        "email": email,
        "floor": "NA",
        "state": "NA"
      },
      "currency": "EGP",
      "integration_id": ApiContest.integrationIdCard,
      "lock_order_when_paid": "false"
    }).then((value) {
      ApiContest.finalToken = value.data['token'];
      print("the final token is : " + ApiContest.finalToken);
      ApiContest.visaUrl = "";
      ApiContest.visaUrl =
          "${ApiContest.baseUrl}/acceptance/iframes/896181?payment_token=${value.data['token']}";
      print(ApiContest.visaUrl);
      emit(FruitAppGetPaymentRequestSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(FruitAppGetPaymentRequestError());
    });
  }

  Future<void> getRefCode() async {
    emit(FruitAppGetRefCodeLoading());
    Diohelper.postDataDio(url: ApiContest.getRefCode, data: {
      "source": {"identifier": "AGGREGATOR", "subtype": "AGGREGATOR"},
      "payment_token": ApiContest.finalToken
    }).then((value) {
      ApiContest.refCode = value.data['id'].toString();
      refrenceCode = ApiContest.refCode;
      print("the ref num is : " + ApiContest.refCode);
      emit(FruitAppGetRefCodeSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(FruitAppGetRefCodeError());
    });
  }

  Future<void> getTransactionDetails() async {
    emit(FruitAppGetTransactionDetailsLoading());
    final response = await Diohelper.getDataDio(url: ApiContest.transactionUrl);

    if (response.statusCode == 200) {
      print(response.data['results']);
      if (response.data['results'] != null &&
          response.data['results'].isNotEmpty) {
        var success = response.data['results'][0]['success'];
        isPaymentSuccess = success;
        if (success) {
          print("Payment was approved!");
          emit(FruitAppGetTransactionDetailsSuccess());
        } else {
          print("Payment was not approved.");
          emit(FruitAppGetTransactionDetailsError());
        }
      } else {
        print("No transaction data found.");
        emit(FruitAppGetTransactionDetailsError());
      }
    }
  }

  void creatOrder({
    required String name,
    required String price,
    required String email,
    required String address,
    required String city,
    required String floorApart,
    required int quantity,
    required String payment_method,
    required String status,
    required String date,
  }) async {
    emit(FruitAppCreateOrderLoading());
    await supabase.from('orders').insert({
      "name": name,
      "price": price,
      "email": email,
      "address": address,
      "city": city,
      "uId": uId,
      "floorApart": floorApart,
      "quantity": quantity,
      "payment_method": payment_method,
      "status": status,
      "date": date,
    }).then((value) {
      emit(FruitAppCreateOrderSuccess());
    }).catchError((error) {
      emit(FruitAppCreateOrderError());
    });
  }

  Future<void> getProfileImage() async {
    try {
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        profileImage = File(pickedFile.path);
        print('image selected');
        uploadProfileImageFile();
        // emit(SocialAppPickedProfileImageSuccessState());
      } else {
        print('No image selected');
        // emit(SocialAppPickedProfileImageErrorState());
        //return null;
      }
    } catch (e) {
      print('Error selecting image: $e');
      // emit(SocialAppPickedProfileImageErrorState());
      //return null;
    }
  }

  void uploadProfileImageFile() async {
    try {
      emit(FruitAppUploadImageLoading());
      final avatarFile = File(profileImage!.path);
      final String fileName = Uri.file(avatarFile.path).pathSegments.last;

      final uploadResponse = await supabase.storage.from('fruithub_app').upload(
            'users/profile_image/$fileName',
            avatarFile,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: true),
          );

      final String profileImageUrl =
          supabase.storage.from('fruithub_app').getPublicUrl(
                'users/profile_image/$fileName',
              );

      print('Profile Image URL: $profileImageUrl');

      final UserResponse res = await supabase.auth.updateUser(
        UserAttributes(data: {
          'profile_image': profileImageUrl,
        }),
      );
      await supabase
          .from('users')
          .update({"profile_image": profileImageUrl}).eq('uId', uId!);
      emit(FruitAppUploadImageSuccess());
    } catch (error) {
      print('Error uploading cover image: $error');
      emit(FruitAppUploadImageError());
    }
  }

  final user = supabase.auth.currentUser;
  void updatePassword({
    required String currentPass,
    required String newPass,
    required String repeatNewPass,
  }) async {
    try {
      final user = supabase.auth.currentUser;

      if (user == null) {
        showToust(message: "يرجى تسجيل الدخول أولاً", state: ToastStates.ERROR);
        return;
      }

      if (newPass != repeatNewPass) {
        showToust(
            message: "كلمتا المرور غير متطابقتين", state: ToastStates.ERROR);
        return;
      }

      final res = await supabase.auth.signInWithPassword(
        email: user.email!,
        password: currentPass,
      );

      print("Reauthenticated User ID: ${res.user?.id}");

      if (res.user == null) {
        throw Exception("كلمة السر الحالية غير صحيحة");
      }

      // Update the password
      await supabase.auth.updateUser(
        UserAttributes(password: newPass),
      );

      showToust(
          message: "تم تغيير كلمة المرور بنجاح", state: ToastStates.SUCCESS);
    } catch (e) {
      print("Error: $e");

      // Handle specific authentication errors
      if (e.toString().contains("invalid_credentials")) {
        showToust(
            message: "كلمة السر الحالية غير صحيحة", state: ToastStates.ERROR);
      } else if (e.toString().contains("Auth session missing")) {
        showToust(
            message: "يرجى تسجيل الدخول مجدداً", state: ToastStates.ERROR);
      } else {
        showToust(
            message: "حدث خطأ أثناء تحديث كلمة المرور",
            state: ToastStates.ERROR);
      }
    }
  }

  void updatePasswordForForget({
    required String newPass,
    required String repeatNewPass,
    context,
  }) async {
    emit(FruitAppChangePasswordLoading());
    try {
      // final user = supabase.auth.currentUser;

      // if (user == null) {
      //   showToust(message: "يرجى تسجيل الدخول أولاً", state: ToastStates.ERROR);
      //   return;
      // }
      if (newPass != repeatNewPass) {
        showToust(
            message: "كلمتا المرور غير متطابقتين", state: ToastStates.ERROR);
        emit(FruitAppChangePasswordError());
        return;
      }
      await supabase.auth.updateUser(
        UserAttributes(password: newPass),
      );
      showToust(
          message: "تم تغيير كلمة المرور بنجاح", state: ToastStates.SUCCESS);
      emit(FruitAppChangePasswordSuccess());
      //navigateToandKill(context, LoginScreen());
    } catch (e) {
      print("Error: $e");
      if (e.toString().contains("invalid_credentials")) {
        showToust(
            message: "كلمة السر الحالية غير صحيحة", state: ToastStates.ERROR);
        emit(FruitAppChangePasswordError());
      } else if (e.toString().contains("Auth session missing")) {
        showToust(
            message: "الجلسة منتهية، يرجى تسجيل الدخول مجدداً",
            state: ToastStates.ERROR);
        emit(FruitAppChangePasswordError());
      } else {
        showToust(
            message: "حدث خطأ أثناء تحديث كلمة المرور",
            state: ToastStates.ERROR);
        emit(FruitAppChangePasswordError());
      }
    }
  }

  void updateName({required String newName}) async {
    try {
      await supabase.auth.updateUser(UserAttributes(data: {
        "Display name": newName,
      }));
      await supabase.from('users').update({"name": newName}).eq('uId', uId!);
      showToust(message: "تم تغيير الاسم بنجاح", state: ToastStates.SUCCESS);
    } catch (error) {
      print("error : " + error.toString());
    }
  }

  void updateEmail({required String newEmail}) async {
    try {
      await supabase.auth.updateUser(UserAttributes(data: {
        "email": newEmail,
      }));
      await supabase.from('users').update({"email": newEmail}).eq('uId', uId!);
      showToust(
          message: "تم تغيير البريد الالكتروني بنجاح",
          state: ToastStates.SUCCESS);
    } catch (error) {
      print("error : " + error.toString());
    }
  }

  void updateNameAndEmail(
      {required String newName, required String newEmail}) async {
    try {
      await supabase.auth.updateUser(UserAttributes(data: {
        "Display name": newName,
        "email": newEmail,
      }));
      await supabase
          .from('users')
          .update({"name": newName, "email": newEmail}).eq('uId', uId!);
      showToust(
          message: "تم تغيير الاسم و البريد الالكتروني بنجاح",
          state: ToastStates.SUCCESS);
    } catch (error) {
      print("error : " + error.toString());
    }
  }

  List<OrdersModel> ordersList = [];
  void getOrdersData() async {
    try {
      emit(FruitAppGetOrdersDataLoading());

      ordersList.clear();
      final response = await supabase.from('orders').select().eq("uId", uId!);

      // Cast the response to a List of dynamic maps
      final List<dynamic> orders = response as List<dynamic>;

      if (orders.isNotEmpty) {
        //productsList.clear();

        for (final order in orders) {
          final orderModel = OrdersModel(
            id: order['id'] ?? 0,
            name: order['name'] ?? '',
            email: order['email'] ?? '',
            address: order['address'] ?? '',
            city: order['city'] ?? '',
            date: order['date'] ?? '',
            floorApart: order['floorApart'] ?? '',
            payment_method: order['payment_method'] ?? '',
            status: order['status'] ?? '',
            quantity: order['quantity'] ?? 0,
            price: order['price'] ?? '',
          );
          ordersList.add(orderModel);
        }

        emit(FruitAppGetOrdersDataSuccess());
        print('Fetched ${ordersList.length} products.');
      } else {
        emit(FruitAppGetOrdersDataError());
        print('No products found in the database.');
      }
    } catch (e) {
      emit(FruitAppGetOrdersDataError());
      print('Error fetching products: $e');
    }
  }

  void addPaymentCard({
    required String name,
    required String card_no,
    required String cvv,
    required String expiry_date,
  }) async {
    emit(FruitAppAddPaymentMethodLoading());
    await supabase.from("payment_cards").insert({
      "uId": uId,
      "name": name,
      "card_no": card_no,
      "cvv": cvv,
      "expiry_date": expiry_date,
    }).then((value) {
      emit(FruitAppAddPaymentMethodSuccess());
    }).catchError((error) {
      emit(FruitAppAddPaymentMethodError());
    });
  }

  List<PaymentCreditCardModel> paymentCreditCardList = [];

  void getPaymentCreditCardData() async {
    try {
      emit(FruitAppGetPaymentCreditCardDataLoading());

      paymentCreditCardList.clear();
      final response =
          await supabase.from('payment_cards').select().eq("uId", uId!);

      final List<dynamic> paymentCreditCards = response as List<dynamic>;

      if (paymentCreditCards.isNotEmpty) {
        //productsList.clear();

        for (final paymentCreditCard in paymentCreditCards) {
          final paymentCreditCardModel = PaymentCreditCardModel(
            id: paymentCreditCard['id'] ?? 0,
            name: paymentCreditCard['name'] ?? '',
            expiry_date: paymentCreditCard['expiray_date'] ?? '',
            cvv: paymentCreditCard['cvv'] ?? '',
            card_no: paymentCreditCard['card_no'] ?? '',
          );
          paymentCreditCardList.add(paymentCreditCardModel);
        }

        emit(FruitAppGetPaymentCreditCardDataSuccess());
        print('Fetched ${paymentCreditCardList.length} products.');
      } else {
        emit(FruitAppGetPaymentCreditCardDataError());
        print('No Cards found in the database.');
      }
    } catch (e) {
      emit(FruitAppGetPaymentCreditCardDataError());
      print('Error fetching products: $e');
    }
  }

  void addToFav({required int product_id}) async {
    emit(FruitAppAddToFavouritesLoading());
    await supabase
        .from('favourites')
        .insert({"uId": uId, "product_id": product_id}).then((value) {
      emit(FruitAppAddToFavouritesSuccess());
    }).catchError((error) {
      emit(FruitAppAddToFavouritesError());
    });
  }

  void removeFromFav({required int product_id}) async {
    emit(FruitAppRemoveToFavouritesLoading());
    await supabase
        .from('favourites')
        .delete()
        .eq("product_id", product_id)
        .then((value) {
      emit(FruitAppRemoveToFavouritesSuccess());
    }).catchError((error) {
      emit(FruitAppRemoveToFavouritesError());
    });
  }

  Set<int> favItems = {};

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? favIds = prefs.getStringList('favItems');
    if (favIds != null) {
      favItems = favIds.map((id) => int.parse(id)).toSet();
    }
    emit(FruitAppUpdateFavoritesState());
  }

  // Save the favorites to SharedPreferences
  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favIds = favItems.map((id) => id.toString()).toList();
    await prefs.setStringList('favItems', favIds);
  }

  void toggleFavorite(int productId) {
    if (favItems.contains(productId)) {
      favItems.remove(productId);
      removeFromFav(product_id: productId);
    } else {
      favItems.add(productId);
      addToFav(product_id: productId);
    }

    // Save the updated favorites to SharedPreferences
    _saveFavorites();

    // Refresh the favorites data
    getFavouritesData();

    emit(FruitAppUpdateFavoritesState());
  }

  List<ProductsModel> favList = [];
  void getFavouritesData() async {
    try {
      emit(FruitAppGetFavouritesDataLoading());

      favList.clear();
      final favResponse = await supabase
          .from('favourites')
          .select('product_id')
          .eq('uId', uId!);

      if (favResponse.isEmpty) {
        print('No favorites found.');
        emit(FruitAppGetFavouritesDataSuccess());
        return;
      }

      print('Fetched favorites: $favResponse');
      List<int> favProductIds =
          (favResponse as List).map((fav) => fav['product_id'] as int).toList();

      final productResponse = await supabase
          .from('products')
          .select('*')
          .filter('id', 'in', favProductIds);

      if (productResponse.isEmpty) {
        print('No matching products found.');
        emit(FruitAppGetFavouritesDataSuccess());
        return;
      }
      print('Fetched products: $productResponse');
      favList = (productResponse as List).map((product) {
        return ProductsModel(
          id: product['id'] ?? 0,
          name: product['name'] ?? '',
          price: (product['price'] is int)
              ? (product['price'] as int).toDouble()
              : (product['price'] ?? 0.0),
          image: product['image'] ?? '',
          quantity: (product['quantity'] as num).toInt(),
        );
      }).toList();

      emit(FruitAppGetFavouritesDataSuccess());
      print('Fetched ${favList.length} favorite products.');
    } catch (e) {
      emit(FruitAppGetFavouritesDataError());
      print('Error fetching products: $e');
    }
  }

  Future<void> sendPasswordResetEmail(
      BuildContext context, String email) async {
    try {
      await Supabase.instance.client.auth.resetPasswordForEmail(
        email,
        redirectTo: "myapp://password-reset",
      );
      emailForForgetPass = email;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password reset email sent! Check your inbox.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
      print('Error: ${e.toString()}');
    }
  }
}
