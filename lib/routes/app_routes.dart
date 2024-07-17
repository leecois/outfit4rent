import 'package:get/get.dart';
import 'package:outfit4rent/features/authentication/screens/login/login_screen.dart';
import 'package:outfit4rent/features/authentication/screens/on_boarding/onboarding.dart';
import 'package:outfit4rent/features/authentication/screens/password_configuration/forgot_password_screen.dart';
import 'package:outfit4rent/features/authentication/screens/signup/signup_screen.dart';
import 'package:outfit4rent/features/authentication/screens/signup/verify_email_screen.dart';
import 'package:outfit4rent/features/personalization/screens/profile/profile_screen.dart';
import 'package:outfit4rent/features/personalization/screens/settings/setting_screen.dart';
import 'package:outfit4rent/features/personalization/screens/wallet/wallet_screen.dart';
import 'package:outfit4rent/features/shop/screens/cart/cart_screen.dart';
import 'package:outfit4rent/features/shop/screens/checkout/checkout_screen.dart';
import 'package:outfit4rent/features/shop/screens/home/home_screen.dart';
import 'package:outfit4rent/features/shop/screens/order/order_screen.dart';
import 'package:outfit4rent/features/shop/screens/store/store_screen.dart';
import 'package:outfit4rent/features/shop/screens/wishlist/wishlist_screen.dart';
import 'package:outfit4rent/routes/routes.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: TRoutes.home, page: () => const HomeScreen()),
    GetPage(name: TRoutes.store, page: () => const StoreScreen()),
    GetPage(name: TRoutes.favorites, page: () => const FavoriteScreen()),
    GetPage(name: TRoutes.settings, page: () => const SettingScreen()),
    GetPage(name: TRoutes.order, page: () => const OrderScreen()),
    GetPage(name: TRoutes.checkout, page: () => const CheckoutScreen()),
    GetPage(name: TRoutes.cart, page: () => const CartScreen()),
    GetPage(name: TRoutes.userProfile, page: () => const ProfileScreen()),
    GetPage(name: TRoutes.userWallet, page: () => const UserWalletScreen()),
    GetPage(name: TRoutes.signup, page: () => const SignupScreen()),
    GetPage(name: TRoutes.verifyEmail, page: () => const VerifyEmailScreen()),
    GetPage(name: TRoutes.signIn, page: () => const LoginScreen()),
    GetPage(name: TRoutes.forgetPassword, page: () => const ForgotPasswordScreen()),
    GetPage(name: TRoutes.onBoarding, page: () => const OnboardingScreen()),
    GetPage(name: TRoutes.payment, page: () => const OrderScreen()),
  ];
}
