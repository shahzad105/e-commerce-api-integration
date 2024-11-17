import 'package:flutter/material.dart';
import 'package:max_cart/service/data_provider.dart'; // Correct path for DataProvider
import 'package:max_cart/screens/model/item_model.dart'; // Correct path for Item model

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          "Max Mart",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.white24,
            ),
            child:
                const Icon(Icons.shopping_cart, size: 25, color: Colors.white),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextField(
                onSubmitted: (query) {
                  print("Searching for: $query");
                },
                style: const TextStyle(fontSize: 16),
                decoration: const InputDecoration(
                  hintText: 'Search for products...',
                  prefixIcon: Icon(Icons.search, size: 30),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(15),
                ),
              ),
            ),
            const SizedBox(height: 5),
            // Banner Image
            Container(
              height: 160,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(offset: Offset(0, 1))],
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  image: AssetImage("images/shopping.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 5),
            // FutureBuilder to fetch products
            FutureBuilder<List<Item>>(
              future: DataProvider().fetchProducts(16), // Fetch 16 products
              builder:
                  (BuildContext context, AsyncSnapshot<List<Item>> snapshot) {
                // Show loading indicator while fetching data
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                // If there was an error, handle it gracefully
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      snapshot.error?.toString() ??
                          'An error occurred', // Safely handle null errors
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                }

                // If data is fetched successfully
                if (snapshot.hasData) {
                  List<Item> products = snapshot.data!;

                  // Display the list of products
                  return Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        Item product = products[index];
                        return Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                product.thumbnail, // Use thumbnail here
                                height: 120,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  product.title, // Use title here
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text('\$${product.price}',
                                    style: TextStyle(color: Colors.green)),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }

                // Fallback if no data
                return Center(child: Text('No products available.'));
              },
            ),
          ],
        ),
      ),
    );
  }
}
