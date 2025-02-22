import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:manisa_case/presentation/providers/auth_provider.dart';

Widget registerButton(BuildContext context, VoidCallback onPressed){
  return(
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          "Kayıt Ol",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onPrimary),
        ),
      )
  );
}

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _hidePassword = true;

  Future<void> register() async {
    final authNotifier = ref.read(authProvider.notifier);
    await authNotifier.login(_usernameController.text, _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: IconButton(
            onPressed: (){
              context.pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).colorScheme.onPrimary,
            )
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              SvgPicture.asset(
                "assets/images/unlock.svg",
                width: 120,
                height: 120,
              ),

              const SizedBox(height: 40),

              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  hintText: "Kullanıcı Adı",
                  hintStyle: TextStyle(
                      color: Theme.of(context).hintColor
                  ),
                  prefixIcon: Icon(Icons.person, color: Theme.of(context).primaryColor),
                  filled: true,
                  fillColor: Color(0xfff6f6f6),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              TextField(
                controller: _passwordController,
                obscureText: _hidePassword,
                decoration: InputDecoration(
                  hintText: "Şifre",
                  hintStyle: TextStyle(
                      color: Theme.of(context).hintColor
                  ),
                  prefixIcon: Icon(Icons.lock, color: Theme.of(context).primaryColor),
                  filled: true,
                  fillColor: Color(0xfff6f6f6),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _hidePassword ? Icons.visibility : Icons.visibility_off,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {
                      setState(() {
                        _hidePassword = !_hidePassword;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 24),

              authState.when(
                data: (user) => registerButton(context, register),
                loading: () => const CircularProgressIndicator(),
                error: (error, _) => Column(
                  children: [
                    Text(error.toString(), style: TextStyle(color: Theme.of(context).colorScheme.error)),
                    const SizedBox(height: 8),
                    registerButton(context, register),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              TextButton(
                  onPressed: () {
                    context.push('/register');
                  },
                  child: RichText(
                    text: TextSpan(
                        children: [
                          TextSpan(text: 'Hesabınız Yok mu ? ', style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
                          TextSpan(text: 'Kayıt Ol', style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
                        ]
                    ),
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}