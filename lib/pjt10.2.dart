import 'package:flutter/material.dart';
import 'package:flutter_w/Colors.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  int stepIndex = 0;

  // Controllers
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  // Stored Final Values (fix for infinite rebuild)
  String finalName = "";
  String finalPhone = "";
  String finalAddress = "";
  String finalPayment = "Cash on Delivery";
  String finalDelivery = "Home Delivery";

  // Payment Options
  final List<String> paymentOptions = [
    "Cash on Delivery",
    "Online Payment",
    "POS on Delivery"
  ];

  // Delivery Methods & cost
  final Map<String, double> deliveryPrice = {
    "Home Delivery": 11.0,
    "Store Pickup": 0.0,
    "Express Delivery": 15.0,
  };

  // Order Items (example)
  final List<Map<String, dynamic>> cartItems = [
    {"name": "Aloe Vera", "price": 15.0, "qty": 1},
    {"name": "Snake Plant", "price": 20.0, "qty": 2},
  ];

  // Subtotal calculator
  double getSubtotal() {
    double total = 0;
    for (var item in cartItems) {
      total += item["price"] * item["qty"];
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        centerTitle: true,
        backgroundColor: MainColor,
      ),

      body: Stepper(
        currentStep: stepIndex,
        onStepContinue: () {
          // Save values on step change
          if (stepIndex == 0) {
            finalName = nameController.text;
            finalPhone = phoneController.text;
          }

          if (stepIndex == 1) {
            finalAddress = addressController.text;
          }

          if (stepIndex < 3) {
            setState(() => stepIndex++);
          } else {
            _showSuccessDialog();
          }
        },

        onStepCancel: () {
          if (stepIndex > 0) {
            setState(() => stepIndex--);
          }
        },

        steps: [
          // ================= STEP 1 =================
          Step(
            title: const Text("Personal Info"),
            isActive: stepIndex >= 0,
            content: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: "Full Name"),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(labelText: "Phone Number"),
                  keyboardType: TextInputType.phone,
                ),
              ],
            ),
          ),

          // ================= STEP 2 =================
          Step(
            title: const Text("Payment Method"),
            isActive: stepIndex >= 1,
            content: Column(
              children: [
                for (var p in paymentOptions)
                  RadioListTile(
                    title: Text(p),
                    value: p,
                    groupValue: finalPayment,
                    onChanged: (value) {
                      setState(() => finalPayment = value.toString());
                    },
                  ),

                const SizedBox(height: 10),
                const Text(
                  "We accept:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Text("Bkash, Nagad, Rocket, VISA, MasterCard, PayPal"),
              ],
            ),
          ),

          // ================= STEP 3 =================
          Step(
            title: const Text("Delivery Method"),
            isActive: stepIndex >= 2,
            content: Column(
              children: [
                for (var d in deliveryPrice.keys)
                  RadioListTile(
                    title: Text("$d - \$${deliveryPrice[d]}"),
                    value: d,
                    groupValue: finalDelivery,
                    onChanged: (value) {
                      setState(() => finalDelivery = value.toString());
                    },
                  ),
              ],
            ),
          ),

          // ================= STEP 4 =================
          Step(
            title: const Text("Order Overview"),
            isActive: stepIndex >= 3,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Name: $finalName"),
                Text("Phone: $finalPhone"),
                Text("Address: $finalAddress"),
                Text("Payment Method: $finalPayment"),
                Text("Delivery Method: $finalDelivery"),
                const SizedBox(height: 20),

                // Order Table
                const Text(
                  "Order Items:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 10),

                Table(
                  border: TableBorder.all(),
                  children: [
                    const TableRow(children: [
                      Padding(padding: EdgeInsets.all(8), child: Text("Item")),
                      Padding(padding: EdgeInsets.all(8), child: Text("Qty")),
                      Padding(padding: EdgeInsets.all(8), child: Text("Price")),
                    ]),
                    for (var item in cartItems)
                      TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(item["name"]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text("${item["qty"]}"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text("\$${item["price"]}"),
                        ),
                      ])
                  ],
                ),

                const SizedBox(height: 20),
                Text("Subtotal: \$${getSubtotal().toStringAsFixed(2)}"),
                Text(
                    "Delivery Charge: \$${deliveryPrice[finalDelivery]!.toStringAsFixed(2)}"),
                const Divider(),

                Text(
                  "Total: \$${(getSubtotal() + deliveryPrice[finalDelivery]!).toStringAsFixed(2)}",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ORDER SUCCESS DIALOG
  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Order Confirmed!"),
        content: const Text("Your order has been placed successfully."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          )
        ],
      ),
    );
  }
}
