import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tarhana_app/core/theme/app_theme.dart';
import 'package:tarhana_app/core/utils/validators.dart';
import 'package:tarhana_app/core/widgets/custom_button.dart';
import 'package:tarhana_app/core/widgets/custom_text_field.dart';
import 'package:tarhana_app/features/home/domain/entities/tarhana.dart';
import 'package:tarhana_app/features/home/presentation/controllers/home_controller.dart';

@RoutePage()
class AddTarhanaPage extends ConsumerStatefulWidget {
  const AddTarhanaPage({super.key});

  @override
  ConsumerState<AddTarhanaPage> createState() => _AddTarhanaPageState();
}

class _AddTarhanaPageState extends ConsumerState<AddTarhanaPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageUrlController = TextEditingController();
  
  final List<String> _ingredients = [];
  final List<String> _steps = [];
  
  final _ingredientController = TextEditingController();
  final _stepController = TextEditingController();
  
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    _ingredientController.dispose();
    _stepController.dispose();
    super.dispose();
  }

  void _addIngredient() {
    final ingredient = _ingredientController.text.trim();
    if (ingredient.isNotEmpty) {
      setState(() {
        _ingredients.add(ingredient);
        _ingredientController.clear();
      });
    }
  }

  void _removeIngredient(int index) {
    setState(() {
      _ingredients.removeAt(index);
    });
  }

  void _addStep() {
    final step = _stepController.text.trim();
    if (step.isNotEmpty) {
      setState(() {
        _steps.add(step);
        _stepController.clear();
      });
    }
  }

  void _removeStep(int index) {
    setState(() {
      _steps.removeAt(index);
    });
  }

  Future<void> _saveTarhana() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_ingredients.isEmpty) {
        _showSnackBar('En az bir malzeme eklemelisiniz');
        return;
      }
      
      if (_steps.isEmpty) {
        _showSnackBar('En az bir adım eklemelisiniz');
        return;
      }
      
      setState(() {
        _isLoading = true;
      });
      
      try {
        final tarhana = Tarhana(
          id: DateTime.now().millisecondsSinceEpoch.toString(), // Mock ID
          name: _nameController.text,
          description: _descriptionController.text,
          ingredients: _ingredients,
          steps: _steps,
          imageUrl: _imageUrlController.text.isEmpty
              ? 'https://via.placeholder.com/300x200?text=Tarhana'
              : _imageUrlController.text,
          authorId: 'user1', // Mock user ID
          createdAt: DateTime.now(),
          likes: 0,
          isFavorite: false,
        );
        
        // Add tarhana using controller
        await ref.read(homeControllerProvider.notifier).addTarhana(tarhana);
        
        if (mounted) {
          _showSnackBar('Tarhana başarıyla eklendi', isError: false);
          context.router.pop();
        }
      } catch (e) {
        if (mounted) {
          _showSnackBar('Tarhana eklenirken hata oluştu: $e');
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  void _showSnackBar(String message, {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? AppTheme.errorColor : AppTheme.secondaryColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarhana Ekle'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Tarhana Adı
            CustomTextField(
              label: 'Tarhana Adı',
              hint: 'Örn: Domates Tarhana',
              controller: _nameController,
              prefixIcon: Icons.title,
              validator: Validators.required,
            ),
            const SizedBox(height: 16),
            
            // Tarhana Açıklaması
            CustomTextField(
              label: 'Açıklama',
              hint: 'Tarhana hakkında kısa bir açıklama',
              controller: _descriptionController,
              prefixIcon: Icons.description,
              maxLines: 3,
              validator: Validators.required,
            ),
            const SizedBox(height: 16),
            
            // Resim URL
            CustomTextField(
              label: 'Resim URL (İsteğe Bağlı)',
              hint: 'Tarhana resmi için URL',
              controller: _imageUrlController,
              prefixIcon: Icons.image,
              keyboardType: TextInputType.url,
            ),
            const SizedBox(height: 24),
            
            // Malzemeler
            _buildSectionHeader('Malzemeler'),
            const SizedBox(height: 8),
            
            // Malzeme Listesi
            _buildIngredientsList(),
            const SizedBox(height: 8),
            
            // Malzeme Ekleme
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    label: 'Malzeme',
                    hint: 'Örn: 2 yemek kaşığı un',
                    controller: _ingredientController,
                    prefixIcon: Icons.shopping_cart,
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: _addIngredient,
                  icon: const Icon(Icons.add_circle),
                  color: AppTheme.primaryColor,
                  tooltip: 'Malzeme Ekle',
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Hazırlama Adımları
            _buildSectionHeader('Hazırlama Adımları'),
            const SizedBox(height: 8),
            
            // Adım Listesi
            _buildStepsList(),
            const SizedBox(height: 8),
            
            // Adım Ekleme
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    label: 'Adım',
                    hint: 'Hazırlama adımını yazın',
                    controller: _stepController,
                    prefixIcon: Icons.format_list_numbered,
                    maxLines: 2,
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: _addStep,
                  icon: const Icon(Icons.add_circle),
                  color: AppTheme.primaryColor,
                  tooltip: 'Adım Ekle',
                ),
              ],
            ),
            const SizedBox(height: 32),
            
            // Kaydet Butonu
            CustomButton(
              text: 'Tarhana Ekle',
              onPressed: _isLoading ? null : _saveTarhana,
              isLoading: _isLoading,
              type: ButtonType.primary,
              isFullWidth: true,
              size: ButtonSize.large,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(width: 8),
        const Expanded(
          child: Divider(),
        ),
      ],
    );
  }

  Widget _buildIngredientsList() {
    if (_ingredients.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Text('Henüz malzeme eklenmedi'),
      );
    }
    
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _ingredients.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: const Icon(Icons.shopping_cart_outlined),
            title: Text(_ingredients[index]),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: AppTheme.errorColor),
              onPressed: () => _removeIngredient(index),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStepsList() {
    if (_steps.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Text('Henüz adım eklenmedi'),
      );
    }
    
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _steps.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: AppTheme.primaryColor,
              child: Text(
                '${index + 1}',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text(_steps[index]),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: AppTheme.errorColor),
              onPressed: () => _removeStep(index),
            ),
          ),
        );
      },
    );
  }
} 