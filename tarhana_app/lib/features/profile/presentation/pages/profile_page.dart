import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tarhana_app/core/router/app_router.dart';
import 'package:tarhana_app/core/theme/app_theme.dart';

@RoutePage()
class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: Implement profile controller
    final user = _getMockUser();
    final userTarhanaCount = 5; // Mock data
    final favoriteCount = 12; // Mock data

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              context.router.push(const SettingsRoute());
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profil Başlığı
            _buildProfileHeader(context, user),
            
            const SizedBox(height: 16),
            
            // İstatistikler
            _buildStatistics(context, userTarhanaCount, favoriteCount),
            
            const SizedBox(height: 16),
            
            // Kullanıcı Tarhanaları
            _buildUserTarhanaList(context),
            
            const SizedBox(height: 16),
            
            // Favoriler
            _buildFavoritesList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, Map<String, dynamic> user) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Profil Resmi
          CircleAvatar(
            radius: 50,
            backgroundImage: user['profileImage'] != null
                ? NetworkImage(user['profileImage'])
                : null,
            child: user['profileImage'] == null
                ? const Icon(Icons.person, size: 50)
                : null,
          ),
          const SizedBox(height: 16),
          
          // Kullanıcı Adı
          Text(
            user['name'],
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 4),
          
          // E-posta
          Text(
            user['email'],
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          
          // Profil Düzenle Butonu
          OutlinedButton.icon(
            onPressed: () {
              // TODO: Navigate to edit profile page
            },
            icon: const Icon(Icons.edit),
            label: const Text('Profili Düzenle'),
          ),
        ],
      ),
    );
  }

  Widget _buildStatistics(BuildContext context, int userTarhanaCount, int favoriteCount) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              context,
              'Tariflerim',
              userTarhanaCount.toString(),
              Icons.restaurant,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildStatCard(
              context,
              'Favorilerim',
              favoriteCount.toString(),
              Icons.favorite,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String count,
    IconData icon,
  ) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(
              icon,
              color: AppTheme.primaryColor,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              count,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserTarhanaList(BuildContext context) {
    // TODO: Implement user tarhana list from controller
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tariflerim',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              TextButton(
                onPressed: () {
                  // TODO: Navigate to user tarhana list page
                },
                child: const Text('Tümünü Gör'),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: 5, // Mock data
            itemBuilder: (context, index) {
              return _buildTarhanaCard(context);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFavoritesList(BuildContext context) {
    // TODO: Implement favorites list from controller
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Favorilerim',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              TextButton(
                onPressed: () {
                  // TODO: Navigate to favorites page
                },
                child: const Text('Tümünü Gör'),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: 5, // Mock data
            itemBuilder: (context, index) {
              return _buildTarhanaCard(context);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTarhanaCard(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 16),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tarhana Resmi
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                'https://via.placeholder.com/300x200',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(Icons.image_not_supported, size: 40),
                    ),
                  );
                },
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tarhana Tarifi',
                    style: Theme.of(context).textTheme.titleSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Geleneksel tarhana tarifi',
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Mock user data
  Map<String, dynamic> _getMockUser() {
    return {
      'id': '1',
      'name': 'Ahmet Yılmaz',
      'email': 'ahmet@example.com',
      'profileImage': 'https://via.placeholder.com/150',
    };
  }
} 