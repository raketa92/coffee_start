import 'dart:async';

import 'package:coffee_start/core/utils/formatters.dart';
import 'package:coffee_start/core/widgets/cart_product_list.dart';
import 'package:coffee_start/features/orders/domain/entities/order.dart';
import 'package:coffee_start/features/orders/presentation/bloc/remote/orders/remote_orders_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class OrderDetails extends StatefulWidget {
  final OrderEntity order;

  const OrderDetails({super.key, required this.order});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails>
    with TickerProviderStateMixin {
  late OrderEntity order;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  bool _isTipVisible = false;

  @override
  void initState() {
    super.initState();
    order = widget.order;

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(10.0, 5.0),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _isTipVisible = true;
        });
        _animationController.forward();
      }
    });

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            setState(() {
              _isTipVisible = false;
            });
          }
        });
      }
    });

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted && _isTipVisible) {
        _animationController.reverse(); // Slide the tip back to the right
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    if (mounted) {
      setState(() {
        _isTipVisible = false;
      });
    }

    context.read<RemoteOrdersBloc>().add(GetOrder(order.orderNumber!));

    await Future.delayed(const Duration(seconds: 1));

    // if (mounted) {
    //   setState(() {
    //     // order = order.copy
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('dd.MM.yyyy – kk:mm').format(DateTime.now());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
        centerTitle: true,
      ),
      body: BlocConsumer<RemoteOrdersBloc, RemoteOrdersState>(
          listener: (context, state) {
        if (state is RemoteOrderLoaded) {
          setState(() {
            order = state.order;
          });
        } else if (state is RemoteOrderError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error.message!)));
        }
      }, builder: (context, state) {
        return Stack(children: [
          RefreshIndicator(
            onRefresh: _onRefresh,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Order Number: ${order.orderNumber}',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text('Order Date: $formattedDate',
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 10),
                  Text('Total Price: ${order.totalPrice} TMT',
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 10),
                  Text('Status: ${getOrderStatus(order.status)}',
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 20),
                  const Text('Order Items:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Expanded(
                      child: CartProductList(
                    products: widget.order.products,
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: 320,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: OutlinedButton(
                              onPressed: () {},
                              child: const Text(
                                "Cancel Order",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ))),
                    ],
                  )
                ],
              ),
            ),
          ),
          if (_isTipVisible)
            Positioned(
              top: 150,
              right: 16,
              child: SlideTransition(
                position: _slideAnimation,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Pull down to update status',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ),
            )
        ]);
      }),
    );
  }
}
