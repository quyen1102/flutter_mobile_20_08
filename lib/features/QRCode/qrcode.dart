import 'package:flutter/material.dart';
import 'package:flutter_mobile_20_08/common/theme.dart';
import 'package:flutter_mobile_20_08/features/products/listProduct.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../store/models/luxuryProduct.dart';
import '../../util/toast.dart';
import '../products/detailProductScreen.dart';

class QRCodeScreen extends StatefulWidget {
  const QRCodeScreen({super.key});

  @override
  State<QRCodeScreen> createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen> {
  MobileScannerController cameraController = MobileScannerController();

  // Barcode? result;
  // QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool flash_click = false;
  bool play_click = true;
  bool status = false;

  bool isLoading = false;
  // _QRViewScreenState(this.status);

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _renderMobile();
  }

  _renderMobile() {
    var width = MediaQuery.of(context).size.width;
    double textSize = width <= 415 ? 12 : 15;

    var color = Colors.black.withOpacity(0.6);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'Quét mã QR',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: Stack(
            children: [
              _buildQrViewType2(context),
              Column(
                children: [
                  // _myContainer(color),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      color: color,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/logoQ.jpg'))),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            // child: Text('Đưa mã QR vào trung tâm của camera',
                            child: Text('Quét mã QR để xem sản phẩm',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: textSize,
                                  color: Colors.white,
                                )),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 270,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _myContainer(color),
                        Container(
                          height: 270,
                          width: 270,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 0.1,
                                  color: Colors.white,
                                  style: BorderStyle.solid)),
                        ),
                        _myContainer(color),
                      ],
                    ),
                  ),
                  _myContainer(color)
                ],
              ),
              Positioned(
                left: 0.0,
                right: 0.0,
                bottom: 0.0,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Colors.black12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          icon: const Icon(
                            Icons.flip_camera_ios,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () async {
                            await cameraController.switchCamera();
                          }),
                      // IconButton(
                      //   icon: Icon(
                      //       (play_click == true)
                      //           ? Icons.play_arrow
                      //           : Icons.pause,
                      //       size: 35,
                      //       color: Colors.white),
                      //   onPressed: () {
                      //     setState(() {
                      //       cameraController.start();
                      //       // _buildQrViewType2(context);
                      //       // play_click = !play_click;
                      //     });
                      //   },
                      // ),
                      IconButton(
                        color: Colors.white,
                        icon: ValueListenableBuilder(
                          valueListenable: cameraController.torchState,
                          builder: (context, state, child) {
                            switch (state as TorchState) {
                              case TorchState.off:
                                return const Icon(Icons.flash_off,
                                    color: Colors.white54);
                              case TorchState.on:
                                return const Icon(Icons.flash_on,
                                    color: Colors.yellow);
                            }
                          },
                        ),
                        iconSize: 32.0,
                        onPressed: () => cameraController.toggleTorch(),
                      ),
                      IconButton(
                          icon: const Icon(
                            Icons.photo_library,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () async {
                            imgscan();
                          }),
                    ],
                  ),
                ),
              ),
              // _renderLoadingIndicator(),
            ],
          )),
        ],
      ),
    );
  }

  Widget _buildQrViewType2(BuildContext context) {
    // bool status = true;
    String result;
    return MobileScanner(
        allowDuplicates: true,
        controller: cameraController,
        onDetect: (barcode, args) {
          result = barcode.rawValue.toString();

          if (result.contains("MyQR_TTQ")) {
            String id = result.split(':').elementAt(2);
            print("id ${id}");
            LuxuryProduct product = LuxuryProduct(
              id: id,
              name: "",
              brandName: "",
              image: "",
              currentPrice: 22.99,
              lastPrice: 49.99,
              description:
                  "Retinol 0.5 from SkinCeuticals is a potent nighttime treatment that's powered by encapsulated retinol and botanical extracts. \n This retinol cream promotes cellular turnover to exfoliate skin and reduce the appearance of blemishes while soothing bisabolol helps alleviate irritation and inflammation.\nSkinCeuticals' H.A. Intensifier is a multi-beneficial corrective serum proven to amplify skin’s hyaluronic acid levels. This unique formulation contains a high concentration of pure hyaluronic acid, proxylane™, \nand botanical extracts of licorice root and purple rice to support skin’s hyaluronic\n acid levels and deliver surface hydration, helping improve the visible appearance of firmness, smoothness, and facial plumpness. \nThis hyaluronic acid serum may be used as part of a home skincare regimen after dermal fillers; \nalways consult with your physician for individual at-home advice.SkinCeuticals'",
              useType:
                  " Triple Lipid Restore 2:4:2 is an anti-aging cream formulated to restore essential skin lipids and\n improve the appearance of aging skin. Aging skin is more susceptible to lipid depletion resulting in visible signs of aging including a loss of facial fullness, an uneven \ntexture and the appearance of fine lines and wrinkles. Featuring the optimal and patented lipid ratio of 2% pure ceramides 1 and 3, 4% natural cholesterol,\n and 2% fatty acids, this unique lipid correction cream helps nourish aging skin for improvement in the visible\n appearance of skin smoothness, laxity, pores, and overall radiance.",
              scent: "coconut",
              liquidVolume: 100,
              rateStar: 4.5,
              quantityPurchased: 2,
              isLiked: false,
              quantity: ValueNotifier(0),
            );
            setState(() {
              _gotoProductDetailScreen(product);
            });
          }
          // else {
          //   toast('Mã QR code không đúng,');
          //   setState(() {
          //     _isGotoRegisterFollowAble = false;
          //   });
          // }
        });
  }

  bool _isGotoRegisterFollowAble = true;
  _gotoProductDetailScreen(product) async {
    if (!_isGotoRegisterFollowAble) {
      return;
    }

    _isGotoRegisterFollowAble = false;
    Future.delayed(Duration(milliseconds: 2000), () {
      _isGotoRegisterFollowAble = true;
    });
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailProductScreen(
                  luxuryProduct: product,
                )));
  }

  Future imgscan() async {
    try {
      // setState(() {
      //   isLoading = true;
      // });

      var image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        // toast('Chưa chọn ảnh');
        _showMySnackBar('Chưa chọn ảnh');
        return;
      }

      // _startScanImage(image.path);
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      toast('Có lỗi xảy ra');
    }
  }

  //   _startScanImage(String path) async {
  //   try {
  //     String? barcode = await BarcodeFinder.scanFile(
  //       path: path,
  //     );

  //     setState(() {
  //       isLoading = false;
  //     });

  //     if (barcode == null || barcode.isEmpty) {
  //       // toast('Không quét được QR từ ảnh đã chọn');
  //       _showMySnackBar('Không quét được QR từ ảnh đã chọn');
  //       setState(() {
  //         isLoading = false;
  //       });
  //       return;
  //     }
  //     if (widget.status == true) {
  //       Navigator.pop(context, barcode);
  //     } else {
  //       Navigator.pop(context);

  //       Future.delayed(Duration(milliseconds: 100), () { // image scan
  //         Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //                 builder: ((context) => ListProductScreen())));
  //       });

  //     }
  //   } catch (_) {
  //     setState(() {
  //       isLoading = false;
  //     });
  //     // toast('Có lỗi xảy ra khi quét QR từ ảnh đã chọn');
  //     _showMySnackBar('Có lỗi xảy ra khi quét QR từ ảnh đã chọn');
  //   }
  // }

  _showMySnackBar(text) {
    var mySnackBar = SnackBar(
      content: Text(text),
      duration: const Duration(seconds: 3),
      backgroundColor: primaryOrangeColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(mySnackBar);
  }

  _myContainer(color) {
    return Expanded(
      child: Container(
        color: color,
      ),
    );
  }
}
