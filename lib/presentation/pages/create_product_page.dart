import 'dart:io';

import 'package:abersoft_test_case/presentation/bloc/product/product_cubit.dart';
import 'package:abersoft_test_case/presentation/pages/product_page.dart';
import 'package:abersoft_test_case/presentation/widgets/ct_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class CreateProductPage extends StatefulWidget {
  static const routName = '/create-product';
  const CreateProductPage({super.key});

  @override
  State<CreateProductPage> createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage> {
  late final ProductCubit _productCubit;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final ValueNotifier<File?> _imageNotifier = ValueNotifier<File?>(null);
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _productCubit = context.read<ProductCubit>();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _imageNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Product',
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Material(
                type: MaterialType.transparency,
                borderRadius: BorderRadius.circular(16),
                child: InkWell(
                  onTap: () {
                    _showDialogUploadImage(context);
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: ValueListenableBuilder<File?>(
                    valueListenable: _imageNotifier,
                    builder: (context, image, _) {
                      return Container(
                        height: 156,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 2,
                          ),
                          image: image != null
                              ? DecorationImage(
                                  image: FileImage(image), fit: BoxFit.fitWidth)
                              : null,
                        ),
                        child: image == null
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.cloud_upload_outlined,
                                    size: 32,
                                    color: Colors.grey.shade400,
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Upload File',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  )
                                ],
                              )
                            : null,
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              CTTextField(
                controller: _nameController,
                labelText: 'Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name cannot be empty';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 8),
              CTTextField.area(
                controller: _descController,
                labelText: 'Description',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Description cannot be empty';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 16),
              BlocConsumer<ProductCubit, ProductState>(
                listener: (context, state) {
                  if (state is ProductFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red.shade400,
                        content: Text(state.message),
                      ),
                    );
                  } else if (state is CreateProductSuccess) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      ProductPage.routName,
                      (route) => false,
                    );
                  }
                },
                builder: (context, state) {
                  return ValueListenableBuilder<File?>(
                    valueListenable: _imageNotifier,
                    builder: (context, image, _) {
                      return ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (image != null) {
                              _productCubit.createProduct(
                                name: _nameController.text,
                                image: image,
                                desc: _descController.text,
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('image cannot be empty'),
                                ),
                              );
                            }
                          }
                        },
                        child: Builder(
                          builder: (context) {
                            if (state is ProductLoading) {
                              return const SizedBox(
                                width: 12,
                                height: 12,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              );
                            }

                            return const Text('Upload');
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _getImage(ImageSource imageSource) async {
    final image = await ImagePicker().pickImage(source: imageSource);

    if (image != null) {
      // convert Xfile into file
      File file = File(image.path);
      _imageNotifier.value = file;
    }
  }

  Future<void> _showDialogUploadImage(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Upload Image'),
          contentPadding: const EdgeInsets.all(8),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(
                  Icons.camera_alt_rounded,
                  color: Colors.black,
                  size: 24,
                ),
                minLeadingWidth: 8,
                title: const Text('Upload Image From Camera'),
                onTap: () {
                  _getImage(ImageSource.camera);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.image,
                  color: Colors.black,
                  size: 24,
                ),
                minLeadingWidth: 8,
                title: const Text('Upload Image From Gallery'),
                onTap: () {
                  _getImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
