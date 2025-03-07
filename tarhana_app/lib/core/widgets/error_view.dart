import 'package:flutter/material.dart';
import 'package:tarhana_app/core/theme/app_theme.dart';
import 'package:tarhana_app/core/widgets/custom_button.dart';

class ErrorView extends StatelessWidget {
  final String message;
  final String? title;
  final IconData icon;
  final VoidCallback? onRetry;
  final String? retryText;
  final bool withScaffold;

  const ErrorView({
    super.key,
    required this.message,
    this.title,
    this.icon = Icons.error_outline,
    this.onRetry,
    this.retryText,
    this.withScaffold = false,
  });

  @override
  Widget build(BuildContext context) {
    final content = Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 64,
              color: AppTheme.errorColor,
            ),
            const SizedBox(height: 16),
            if (title != null) ...[
              Text(
                title!,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
            ],
            Text(
              message,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              CustomButton(
                text: retryText ?? 'Tekrar Dene',
                onPressed: onRetry,
                type: ButtonType.primary,
                icon: Icons.refresh,
              ),
            ],
          ],
        ),
      ),
    );

    if (withScaffold) {
      return Scaffold(
        body: content,
      );
    }

    return content;
  }
}

class NetworkErrorView extends StatelessWidget {
  final VoidCallback? onRetry;
  final bool withScaffold;

  const NetworkErrorView({
    super.key,
    this.onRetry,
    this.withScaffold = false,
  });

  @override
  Widget build(BuildContext context) {
    return ErrorView(
      title: 'Bağlantı Hatası',
      message: 'İnternet bağlantınızı kontrol edip tekrar deneyiniz.',
      icon: Icons.wifi_off,
      onRetry: onRetry,
      withScaffold: withScaffold,
    );
  }
}

class EmptyView extends StatelessWidget {
  final String message;
  final String? title;
  final IconData icon;
  final VoidCallback? onAction;
  final String? actionText;
  final bool withScaffold;

  const EmptyView({
    super.key,
    required this.message,
    this.title,
    this.icon = Icons.inbox,
    this.onAction,
    this.actionText,
    this.withScaffold = false,
  });

  @override
  Widget build(BuildContext context) {
    final content = Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            if (title != null) ...[
              Text(
                title!,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
            ],
            Text(
              message,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            if (onAction != null) ...[
              const SizedBox(height: 24),
              CustomButton(
                text: actionText ?? 'Ekle',
                onPressed: onAction,
                type: ButtonType.primary,
                icon: Icons.add,
              ),
            ],
          ],
        ),
      ),
    );

    if (withScaffold) {
      return Scaffold(
        body: content,
      );
    }

    return content;
  }
} 