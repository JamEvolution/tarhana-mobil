import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tarhana_app/core/router/app_router.dart';
import 'package:tarhana_app/core/widgets/error_view.dart';
import 'package:tarhana_app/core/widgets/loading_indicator.dart';
import 'package:tarhana_app/features/home/presentation/controllers/home_controller.dart';
import 'package:tarhana_app/features/home/presentation/widgets/tarhana_card.dart';

@RoutePage()
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeControllerProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarhana'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implement search
            },
          ),
        ],
      ),
      body: homeState.when(
        loading: () => const LoadingIndicator(),
        error: (error, stackTrace) => ErrorView(
          message: 'Hata: $error',
          onRetry: () => ref.refresh(homeControllerProvider),
        ),
        data: (tarhanaList) {
          if (tarhanaList.isEmpty) {
            return EmptyView(
              title: 'Henüz Tarhana Yok',
              message: 'Tarhana tarifleri ekleyerek başlayabilirsiniz.',
              icon: Icons.restaurant,
              onAction: () => context.router.push(const AddTarhanaRoute()),
              actionText: 'Tarhana Ekle',
            );
          }
          
          return RefreshIndicator(
            onRefresh: () => ref.refresh(homeControllerProvider.future),
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: tarhanaList.length,
              itemBuilder: (context, index) {
                final tarhana = tarhanaList[index];
                return TarhanaCard(
                  tarhana: tarhana,
                  onTap: () {
                    // TODO: Navigate to tarhana detail page
                  },
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.router.push(const AddTarhanaRoute());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
} 