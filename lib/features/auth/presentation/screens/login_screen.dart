import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_widgets.dart';
import '../../../../app/router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    // TODO: implementare login con Supabase Auth
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);
    if (mounted) context.go(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo / Brand
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'H',
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamily,
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                          color: AppColors.accent,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'HYBRIDCREW',
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamily,
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.0,
                          color: AppColors.darkTextPrimary,
                        ),
                      ),
                    ],
                  ).animate().fadeIn(duration: 600.ms),
                  const SizedBox(height: 8),
                  Text(
                    'Train with purpose.',
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamily,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.darkTextSecondary,
                    ),
                  ).animate().fadeIn(duration: 600.ms, delay: 200.ms),

                  const SizedBox(height: 40),

                  // Email
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    style: const TextStyle(
                      fontFamily: AppTypography.fontFamily,
                      color: AppColors.darkTextPrimary,
                      fontSize: 16,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      prefixIcon: Icon(
                        Icons.mail_outline,
                        color: AppColors.darkTextSecondary,
                        size: 20,
                      ),
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Inserisci la tua email';
                      if (!v.contains('@')) return 'Email non valida';
                      return null;
                    },
                  ).animate().fadeIn(duration: 500.ms, delay: 400.ms),
                  const SizedBox(height: 16),

                  // Password
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => _login(),
                    style: const TextStyle(
                      fontFamily: AppTypography.fontFamily,
                      color: AppColors.darkTextPrimary,
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        color: AppColors.darkTextSecondary,
                        size: 20,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: AppColors.darkTextSecondary,
                          size: 20,
                        ),
                        onPressed: () =>
                            setState(() => _obscurePassword = !_obscurePassword),
                      ),
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Inserisci la password';
                      if (v.length < 6) return 'Minimo 6 caratteri';
                      return null;
                    },
                  ).animate().fadeIn(duration: 500.ms, delay: 500.ms),

                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {}, // TODO: forgot password
                      child: Text(
                        'Password dimenticata?',
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamily,
                          fontSize: 14,
                          color: AppColors.darkTextSecondary,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Login button
                  PrimaryButton(
                    label: 'ACCEDI',
                    onPressed: _login,
                    isLoading: _isLoading,
                  ).animate().fadeIn(duration: 500.ms, delay: 600.ms),

                  const SizedBox(height: 32),

                  // Register link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Non hai un account? ',
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamily,
                          fontSize: 14,
                          color: AppColors.darkTextSecondary,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => context.go(AppRoutes.register),
                        child: const Text(
                          'Registrati',
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamily,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.darkTextPrimary,
                          ),
                        ),
                      ),
                    ],
                  ).animate().fadeIn(duration: 500.ms, delay: 700.ms),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
