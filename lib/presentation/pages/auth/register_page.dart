import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hubline/config/app_theme.dart';
import 'package:hubline/presentation/controllers/auth_controller.dart';
import 'package:hubline/presentation/widgets/custom_text_field.dart';
import 'package:hubline/presentation/widgets/custom_button.dart';
import 'package:hubline/presentation/widgets/google_sign_in_button.dart';
import 'package:hubline/routes/app_routes.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Scrollbar(
          thumbVisibility: true,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const SizedBox(height: 40),

                  // Header with back button
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_rounded,
                            size: 20,
                            color: AppTheme.secondaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Logo and Title
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.hub_rounded,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'create_account'.tr,
                    style: GoogleFonts.urbanist(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'join_professional_network'.tr,
                    style: GoogleFonts.urbanist(
                      fontSize: 14,
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Register Form
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Google Sign Up Button
                        GoogleSignInButton(
                          text: 'continue_with_google'.tr,
                          onPressed: () => authController.signInWithGoogle(),
                        ),

                        const SizedBox(height: 24),

                        // Divider
                        Row(
                          children: [
                            const Expanded(
                              child: Divider(color: Color(0xFFE5E7EB)),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Text(
                                'or'.tr,
                                style: GoogleFonts.urbanist(
                                  fontSize: 14,
                                  color: const Color(0xFF6B7280),
                                ),
                              ),
                            ),
                            const Expanded(
                              child: Divider(color: Color(0xFFE5E7EB)),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // Name Field
                        CustomTextField(
                          controller: nameController,
                          labelText: 'full_name'.tr,
                          prefixIcon: Icons.person_outline,
                        ),

                        const SizedBox(height: 16),

                        // Email Field
                        CustomTextField(
                          controller: emailController,
                          labelText: 'email'.tr,
                          prefixIcon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                        ),

                        const SizedBox(height: 16),

                        // Password Field
                        CustomTextField(
                          controller: passwordController,
                          labelText: 'password'.tr,
                          prefixIcon: Icons.lock_outline,
                          obscureText: true,
                        ),

                        const SizedBox(height: 16),

                        // Confirm Password Field
                        CustomTextField(
                          controller: confirmPasswordController,
                          labelText: 'confirm_password'.tr,
                          prefixIcon: Icons.lock_outline,
                          obscureText: true,
                        ),

                        const SizedBox(height: 24),

                        // Sign Up Button
                        Obx(
                          () => CustomButton(
                            text: 'create_account_button'.tr,
                            isLoading: authController.isLoading.value,
                            onPressed: () {
                              if (_validateForm(
                                nameController.text,
                                emailController.text,
                                passwordController.text,
                                confirmPasswordController.text,
                              )) {
                                authController.register(
                                  emailController.text.trim(),
                                  passwordController.text,
                                  nameController.text.trim(),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Sign In Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: GoogleFonts.urbanist(
                          fontSize: 14,
                          color: const Color(0xFF6B7280),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Text(
                          'Sign In',
                          style: GoogleFonts.urbanist(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _validateForm(
    String name,
    String email,
    String password,
    String confirmPassword,
  ) {
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      Get.snackbar('error'.tr, 'Todos los campos son obligatorios');
      return false;
    }

    if (password != confirmPassword) {
      Get.snackbar('error'.tr, 'Las contraseñas no coinciden');
      return false;
    }

    return true;
  }
}
