import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:library_management_app/services/apis/transaction_api.dart';
import '../models/transaction.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  final _trancactionApi = TransactionApi();
  List<Transaction> _transactions = [];
  bool _isLoading = false;
  bool _showActiveOnly = true;

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  Future<void> _loadTransactions() async {
    setState(() => _isLoading = true);
    try {
      final transactions = _showActiveOnly
          ? await _trancactionApi.getActiveTransactions()
          : await _trancactionApi.getTransactions();
      setState(() {
        _transactions = transactions;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading transactions: $e')),
        );
      }
    }
  }

  Future<void> _returnBook(int transactionId) async {
    try {
      await _trancactionApi.returnBook(transactionId);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Book returned successfully!')),
        );
      }
      _loadTransactions();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error returning book: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
        actions: [
          IconButton(
            icon: Icon(_showActiveOnly ? Icons.list : Icons.check_circle),
            onPressed: () {
              setState(() {
                _showActiveOnly = !_showActiveOnly;
              });
              _loadTransactions();
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadTransactions,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _transactions.isEmpty
              ? Center(
                  child: Text(
                    _showActiveOnly
                        ? 'No active transactions'
                        : 'No transactions yet!',
                  ),
                )
              : ListView.builder(
                  itemCount: _transactions.length,
                  itemBuilder: (context, index) {
                    final transaction = _transactions[index];
                    final dateFormat = DateFormat('MMM dd, yyyy');
                    final isOverdue = transaction.status == 'borrowed' &&
                        transaction.dueDate.isBefore(DateTime.now());

                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: transaction.status == 'returned'
                              ? Colors.green
                              : isOverdue
                                  ? Colors.red
                                  : Colors.orange,
                          child: Icon(
                            transaction.status == 'returned'
                                ? Icons.check
                                : Icons.book,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(
                          transaction.bookTitle ?? 'Unknown Book',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Member: ${transaction.memberName ?? "Unknown"}'),
                            Text(
                                'Borrowed: ${dateFormat.format(transaction.borrowDate)}'),
                            Text(
                                'Due: ${dateFormat.format(transaction.dueDate)}'),
                            if (transaction.returnDate != null)
                              Text(
                                  'Returned: ${dateFormat.format(transaction.returnDate!)}'),
                            if (transaction.fine > 0)
                              Text(
                                'Fine: \$${transaction.fine.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                          ],
                        ),
                        isThreeLine: true,
                        trailing: transaction.status == 'borrowed'
                            ? ElevatedButton(
                                onPressed: () => _returnBook(transaction.id),
                                child: const Text('Return'),
                              )
                            : Chip(
                                label: Text(transaction.status.toUpperCase()),
                                backgroundColor: Colors.green.shade100,
                              ),
                      ),
                    );
                  },
                ),
    );
  }
}
