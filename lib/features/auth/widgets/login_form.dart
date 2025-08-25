import 'package:flutter/material.dart';
import '../../../shared/widgets/custom_text_field.dart';
import '../../../utils/validators.dart';

/// Form component untuk login screen
class LoginForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool obscurePassword;
  final VoidCallback onTogglePassword;

  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.obscurePassword,
    required this.onTogglePassword,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          controller: emailController,
          labelText: 'Email',
          hintText: 'Masukkan email Anda',
          keyboardType: TextInputType.emailAddress,
          validator: Validators.validateEmail,
          prefixIcon: _buildGradientIcon(Icons.email_outlined),
        ),
        const SizedBox(height: 20),
        CustomTextField(
          controller: passwordController,
          labelText: 'Password',
          hintText: 'Masukkan password Anda',
          obscureText: obscurePassword,
          validator: Validators.validatePassword,
          prefixIcon: _buildGradientIcon(Icons.lock_outlined),
          suffixIcon: IconButton(
            icon: Icon(
              obscurePassword
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: const Color(0xFF667eea),
            ),
            onPressed: onTogglePassword,
          ),
        ),
      ],
    );
  }

  Widget _buildGradientIcon(IconData icon) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF667eea), Color(0xFF764ba2)],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 20,
      ),
    );
  }
}