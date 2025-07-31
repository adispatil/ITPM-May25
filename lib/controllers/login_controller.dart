import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/auth_service.dart';
import '../screens/success_screen.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  
  final AuthService _authService = AuthService();
  
  // Observable variables
  final RxBool isLoading = false.obs;
  final RxString emailError = ''.obs;
  final RxString passwordError = ''.obs;
  
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
  
  void clearForm() {
    emailController.clear();
    passwordController.clear();
    emailError.value = '';
    passwordError.value = '';
  }
  
  bool _validateForm() {
    bool isValid = true;
    
    // Email validation
    if (emailController.text.isEmpty) {
      emailError.value = 'Email is required';
      isValid = false;
    } else if (!GetUtils.isEmail(emailController.text)) {
      emailError.value = 'Please enter a valid email';
      isValid = false;
    } else {
      emailError.value = '';
    }
    
    // Password validation
    if (passwordController.text.isEmpty) {
      passwordError.value = 'Password is required';
      isValid = false;
    } else if (passwordController.text.length < 6) {
      passwordError.value = 'Password must be at least 6 characters';
      isValid = false;
    } else {
      passwordError.value = '';
    }
    
    return isValid;
  }
  
  Future<void> login() async {
    if (!_validateForm()) {
      return;
    }
    
    isLoading.value = true;
    
    try {
      final response = await _authService.login(
        email: emailController.text,
        password: passwordController.text,
      );
      
      if (response['success']) {
        // Show success message
        Get.snackbar(
          'Success!',
          'Login successful! Welcome ${response['user']['name']}',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
        
        // Navigate to success page
        await Future.delayed(const Duration(seconds: 2));
        Get.off(() => SuccessScreen(userData: response['user']));
        
      } else {
        // Show error message
        Get.snackbar(
          'Error!',
          response['message'] ?? 'Login failed. Please try again.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error!',
        'Network error. Please check your connection.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
    }
  }
} 