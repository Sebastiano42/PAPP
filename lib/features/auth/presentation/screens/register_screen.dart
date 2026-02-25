import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_widgets.dart';
import '../../../../app/router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    // TODO: implementare registrazione con Supabase Auth
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);
    if (mounted) context.go(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go(AppRoutes.login),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 24),

                const Text(
                  'CREATE\nACCOUNT',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamily,
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.0,
                    height: 1.1,
                    color: AppColors.darkTextPrimary,
                  ),
                ).animate().fadeIn(duration: 600.ms),
                const SizedBox(height: 8),
                Text(
                  'Join the HybridCrew community.',
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamily,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.darkTextSecondary,
                  ),
                ).animate().fadeIn(duration: 600.ms, delay: 200.ms),

                const SizedBox(height: 40),

                // Nome
                TextFormField(
                  controller: _nameController,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  style: const TextStyle(
                    fontFamily: AppTypography.fontFamily,
                    color: AppColors.darkTextPrimary,
                    fontSize: 16,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Nome e Cognome',
                    prefixIcon: Icon(
                      Icons.person_outline,
                      color: AppColors.darkTextSecondary,
                      size: 20,
                    ),
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Inserisci il tuo nome';
                    return null;
                  },
                ).animate().fadeIn(duration: 500.ms, delay: 300.ms),
                const SizedBox(height: 16),

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
                  onFieldSubmitted: (_) => _register(),
                  style: const TextStyle(
                    fontFamily: AppTypography.fontFamily,
                    color: AppColors.darkTextPrimary,
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Password',
                    helperText: 'Minimo 6 caratteri',
                    helperStyle: const TextStyle(
                      color: AppColors.darkTextTertiary,
                      fontSize: 12,
                    ),
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

                const SizedBox(height: 32),

                PrimaryButton(
                  label: 'REGISTRATI',
                  onPressed: _register,
                  isLoading: _isLoading,
                ).animate().fadeIn(duration: 500.ms, delay: 600.ms),

                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Hai già un account? ',
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamily,
                        fontSize: 14,
                        color: AppColors.darkTextSecondary,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => context.go(AppRoutes.login),
                      child: const Text(
                        'Accedi',
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
    );
  }
}
