import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../config/theme.dart';
import 'dart:developer' as developer;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    developer.log(authService.toString(), name: 'HomeScreen');
    final user = authService.userModel;
    developer.log(user.toString(), name: 'HomeScreen');

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppTheme.backgroundColor1, AppTheme.backgroundColor2],
          ),
        ),
        child:
            user == null
                ? Center(child: CircularProgressIndicator())
                : SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/profile');
                              },
                              child: CircleAvatar(
                                backgroundColor: AppTheme.primaryColor
                                    .withOpacity(0.2),
                                child: Icon(
                                  Icons.person,
                                  color: AppTheme.primaryColor,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.logout, color: Colors.black54),
                              onPressed: () async {
                                await authService.logout();
                                // ignore: use_build_context_synchronously
                                Navigator.pushReplacementNamed(
                                  context,
                                  '/login',
                                );
                              },
                            ),
                          ],
                        ),

                        const SizedBox(height: 60.0),

                        // Welcome message
                        Center(
                          child: ShaderMask(
                            shaderCallback:
                                (bounds) => LinearGradient(
                                  colors: [
                                    AppTheme.primaryColor,
                                    AppTheme.secondaryColor,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ).createShader(bounds),
                            child: Text(
                              'Welcome, ${user.name}!',
                              style: TextStyle(
                                fontSize: 32.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 16.0),

                        Text(
                          'to Waste 2 Way',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
      ),
    );
  }
}
