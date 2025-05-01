import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mf_profile/src/presentation/store/profile_store.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileStore _profileStore = GetIt.instance<ProfileStore>();

  @override
  void initState() {
    super.initState();
    _profileStore.refreshUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (_) {
          if (_profileStore.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (!_profileStore.isLoggedIn) {
            return const Center(
              child: Text('Por favor inicia sesión para ver tu perfil'),
            );
          }
          
          final user = _profileStore.currentUser;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.account_circle,
                  size: 100,
                  color: Colors.blue,
                ),
                const SizedBox(height: 24),
                Text(
                  'Hola, ${user?.name ?? "Usuario"}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  '${user?.email ?? "No disponible"}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 16),
                Card(
                  margin: const EdgeInsets.all(16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Información de la cuenta',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        _buildInfoRow('ID:', user?.id ?? 'No disponible'),
                        const SizedBox(height: 8),
                        _buildInfoRow('Correo:', user?.email ?? 'No disponible'),
                        const SizedBox(height: 8),
                        _buildInfoRow('Nombre:', user?.name ?? 'No disponible'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
  
  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(value),
        ),
      ],
    );
  }
} 