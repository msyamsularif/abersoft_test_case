import 'package:abersoft_test_case/presentation/bloc/product/product_cubit.dart';
import 'package:abersoft_test_case/presentation/pages/create_product_page.dart';
import 'package:abersoft_test_case/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductPage extends StatefulWidget {
  static const routName = '/product';
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late final ProductCubit _productCubit;

  @override
  void initState() {
    _productCubit = context.read<ProductCubit>();
    _productCubit.getListProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Our Portfolio',
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, CreateProductPage.routName),
            iconSize: 24,
            splashRadius: 20,
            icon: const Icon(
              Icons.add_circle,
              color: Colors.blueAccent,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16).copyWith(bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Best Product',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 35),
            SizedBox(
              height: 162,
              child: BlocBuilder<ProductCubit, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.blueAccent,
                      ),
                    );
                  } else if (state is GetProductSuccess) {
                    return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: state.bestProducts.length,
                      itemBuilder: (context, index) {
                        final product = state.bestProducts[index];

                        return Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: ProductCard(
                            title: product.name,
                            desc: product.desc,
                            imageProvider: NetworkImage(
                              product.imageUrl,
                            ),
                          ),
                        );
                      },
                    );
                  }

                  return const Center(
                    child: Text(
                      'No Data Available',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 28),
            const Text(
              'Best Product',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 35),
            Expanded(
              child: BlocBuilder<ProductCubit, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.blueAccent,
                      ),
                    );
                  } else if (state is GetProductSuccess) {
                    return GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 66,
                        mainAxisSpacing: 27,
                        mainAxisExtent: 162,
                      ),
                      itemCount: state.allProducts.length,
                      itemBuilder: (context, index) {
                        final product = state.allProducts[index];

                        return ProductCard(
                          title: product.name,
                          desc: product.desc,
                          imageProvider: NetworkImage(
                            product.imageUrl,
                          ),
                        );
                      },
                    );
                  }

                  return const Center(
                    child: Text(
                      'No Data Available',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
