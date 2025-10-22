import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/mpesa_provider.dart';

class MpesaPaymentScreen extends StatefulWidget {
  final double amount;
  final String accountReference;
  final String description;

  const MpesaPaymentScreen({
    super.key,
    required this.amount,
    required this.accountReference,
    this.description = 'Payment',
  });

  @override
  State<MpesaPaymentScreen> createState() => _MpesaPaymentScreenState();
}

class _MpesaPaymentScreenState extends State<MpesaPaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  bool _isProcessing = false;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _initiatePayment() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isProcessing = true;
    });

    final mpesaProvider = Provider.of<MpesaProvider>(context, listen: false);

    // Initiate payment
    final success = await mpesaProvider.initiatePayment(
      phoneNumber: _phoneController.text.trim(),
      amount: widget.amount,
      accountReference: widget.accountReference,
      description: widget.description,
    );

    if (!mounted) return;

    if (success && mpesaProvider.lastPushResponse != null) {
      // Show waiting dialog
      _showWaitingDialog(mpesaProvider.lastPushResponse!.checkoutRequestId);
    } else {
      setState(() {
        _isProcessing = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(mpesaProvider.error ?? 'Failed to initiate payment'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showWaitingDialog(String checkoutRequestId) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => _WaitingForPaymentDialog(
        checkoutRequestId: checkoutRequestId,
        amount: widget.amount,
        phoneNumber: _phoneController.text.trim(),
      ),
    );
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }

    final cleaned = value.replaceAll(RegExp(r'[\s\-]'), '');

    if (!RegExp(r'^(254|0)[17]\d{8}$').hasMatch(cleaned)) {
      return 'Enter a valid M-Pesa number (e.g., 0712345678)';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('M-Pesa Payment'),
        backgroundColor: Colors.green[700],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // M-Pesa logo area
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.phone_android,
                      size: 64,
                      color: Colors.green[700],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'M-PESA',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[700],
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Lipa Na M-PESA Online',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Amount display
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Amount to Pay:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'KES ${widget.amount.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Phone number input
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'M-Pesa Phone Number',
                  hintText: '0712345678',
                  prefixIcon: const Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  helperText: 'Enter the number to receive the payment prompt',
                ),
                validator: _validatePhone,
                enabled: !_isProcessing,
              ),

              const SizedBox(height: 24),

              // Payment instructions
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.blue[700]),
                        const SizedBox(width: 8),
                        Text(
                          'How it works:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[700],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text('1. Enter your M-Pesa phone number'),
                    const SizedBox(height: 4),
                    const Text('2. Tap "Pay Now" button'),
                    const SizedBox(height: 4),
                    const Text('3. Enter your M-Pesa PIN on your phone'),
                    const SizedBox(height: 4),
                    const Text('4. Wait for confirmation'),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Pay button
              ElevatedButton(
                onPressed: _isProcessing ? null : _initiatePayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: _isProcessing
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        'Pay Now',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WaitingForPaymentDialog extends StatefulWidget {
  final String checkoutRequestId;
  final double amount;
  final String phoneNumber;

  const _WaitingForPaymentDialog({
    required this.checkoutRequestId,
    required this.amount,
    required this.phoneNumber,
  });

  @override
  State<_WaitingForPaymentDialog> createState() =>
      _WaitingForPaymentDialogState();
}

class _WaitingForPaymentDialogState extends State<_WaitingForPaymentDialog> {
  bool _isChecking = true;
  bool? _paymentSuccess;
  String? _message;

  @override
  void initState() {
    super.initState();
    _pollPaymentStatus();
  }

  Future<void> _pollPaymentStatus() async {
    final mpesaProvider = Provider.of<MpesaProvider>(context, listen: false);

    final success = await mpesaProvider.pollPaymentStatus(
      checkoutRequestId: widget.checkoutRequestId,
      maxAttempts: 30,
    );

    if (!mounted) return;

    setState(() {
      _isChecking = false;
      _paymentSuccess = success;

      if (success) {
        _message = 'Payment successful!';
      } else if (mpesaProvider.error != null) {
        _message = mpesaProvider.error;
      } else {
        _message = 'Payment failed or was cancelled';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        _isChecking ? 'Processing Payment' : (_paymentSuccess == true ? 'Success' : 'Failed'),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_isChecking) ...[
            const CircularProgressIndicator(
              color: Colors.green,
            ),
            const SizedBox(height: 24),
            Text(
              'Check your phone for the M-Pesa prompt',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 12),
            Text(
              'Waiting for payment confirmation...',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ] else ...[
            Icon(
              _paymentSuccess == true ? Icons.check_circle : Icons.error,
              size: 64,
              color: _paymentSuccess == true ? Colors.green : Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              _message ?? 'Unknown status',
              textAlign: TextAlign.center,
            ),
            if (_paymentSuccess == true) ...[
              const SizedBox(height: 16),
              Text(
                'Amount: KES ${widget.amount.toStringAsFixed(2)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ],
        ],
      ),
      actions: [
        if (!_isChecking)
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (_paymentSuccess == true) {
                // Go back to previous screen
                Navigator.of(context).pop(true);
              }
            },
            child: const Text('Close'),
          ),
      ],
    );
  }
}
