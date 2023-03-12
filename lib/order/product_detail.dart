import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:order_management/order/orderpage.dart';

class ProductDetail extends StatefulWidget {
  final String rate, dimension, productname, uuid;
  final area;
  final name;
  const ProductDetail(
      {super.key,
      required this.area,
      required this.name,
      required this.dimension,
      required this.uuid,
      //  this.pcs,
      required this.productname,
      required this.rate});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.purple,
        title: Text("Product Detail"),
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            "assets/splash.png",
            height: 300,
          ),
          Center(
            child: Card(
              elevation: 5,
              child: Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.white,
                    offset: const Offset(
                      2.0,
                      2.0,
                    ),
                    blurRadius: 1.0,
                    spreadRadius: 2.0,
                  ), //BoxShadow
                ]),
                width: 250,
                height: 250,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Product Name:' + widget.productname,
                      style: TextStyle(color: Colors.black, fontSize: 17),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Product Dimensions:' + widget.dimension,
                      style: TextStyle(color: Colors.black, fontSize: 17),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // Text(
                    //   'Product Pcs:' + widget.pcs,
                    //   style: TextStyle(color: Colors.black, fontSize: 17),
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    Text(
                      'Product Rate:' + widget.rate,
                      style: TextStyle(color: Colors.black, fontSize: 17),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          ElevatedButton(
            onPressed: () {
              print(widget.area);
              print(widget.uuid);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (builder) => OrderPage(
                            area: widget.area,
                            name: widget.name,
                            uuid: widget.uuid,
                            dimension: widget.dimension,
                            // pcs: widget.pcs,
                            productname: widget.productname,
                            rate: widget.rate,
                          )));
            },
            child: Text("Order"),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                fixedSize: Size(250, 50),
                shape: StadiumBorder()),
          )
        ],
      ),
    );
  }
}
