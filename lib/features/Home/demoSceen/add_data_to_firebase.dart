import 'package:flutter/material.dart';

import '../../../common/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../store/models/luxuryProduct.dart';

class AddDataToFireBase extends StatefulWidget {
  const AddDataToFireBase({super.key});

  @override
  State<AddDataToFireBase> createState() => _AddDataToFireBaseState();
}

enum isLiked { like, dislike }

class _AddDataToFireBaseState extends State<AddDataToFireBase> {
  TextEditingController? nameEditingController;
  TextEditingController? brandNameEditingController;
  TextEditingController? imageEditingController;
  TextEditingController? currentPriceEditingController;
  TextEditingController? lastPriceEditingController;
  TextEditingController? descriptionEditingController;
  TextEditingController? useTypeEditingController;
  TextEditingController? scentEditingController;
  TextEditingController? liquidVolumeEditingController;
  TextEditingController? rateStarEditingController;
  TextEditingController? quantityPurchasedEditingController;
  TextEditingController? numberCountProductEditingController;
  isLiked _isLike = isLiked.like;

  // final luxuryProductRef = FirebaseFirestore.instance
  //     .collection('luxuryProduct')
  //     .withConverter<LuxuryProduct>(
  //       fromFirestore: (snapshots,_) =>
  //           LuxuryProduct.fromJson(snapshots.data()!),
  //       toFirestore: (product,_) => product.toJson(),
  //     );
        final luxuryProductRef = FirebaseFirestore.instance
      .collection('luxuryProduct')
      .doc();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameEditingController = TextEditingController();
    brandNameEditingController = TextEditingController();
    imageEditingController = TextEditingController();
    currentPriceEditingController = TextEditingController();
    lastPriceEditingController = TextEditingController();
    descriptionEditingController = TextEditingController();
    useTypeEditingController = TextEditingController();
    scentEditingController = TextEditingController();
    liquidVolumeEditingController = TextEditingController();
    rateStarEditingController = TextEditingController();
    quantityPurchasedEditingController = TextEditingController();
    numberCountProductEditingController = TextEditingController();
  }

    @override
  void dispose() {
    super.dispose();
    nameEditingController?.dispose();
    brandNameEditingController?.dispose();
    imageEditingController?.dispose();
    currentPriceEditingController?.dispose();
    lastPriceEditingController?.dispose();
    descriptionEditingController?.dispose();
    useTypeEditingController?.dispose();
    scentEditingController?.dispose();
    liquidVolumeEditingController?.dispose();
    rateStarEditingController?.dispose();
    quantityPurchasedEditingController?.dispose();
    numberCountProductEditingController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
// id
// name
// brandName
// image
// currentPrice
// lastPrice
// description
// useType
// scent
// liquidVolume
// rateStar
// quantityPurchased
// isLiked
// numberCountProduct
    return Scaffold(
        backgroundColor: primaryLightColor,
        appBar: AppBar(
            title: const Text("ADD"),
            centerTitle: true,
            backgroundColor: primaryColor
            // leading:Icon(Icons.arrow_back_ios_new),
            ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text("Create a new Product",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                ),
                _renderTextInput(
                    controller: nameEditingController,
                    keyboardType: TextInputType.text,
                    autoCorrect: false,
                    labelText: "name",
                    obscureText: false,
                    enableSuggestions: false,
                    valid: null),
                _renderTextInput(
                    controller: brandNameEditingController,
                    keyboardType: TextInputType.text,
                    autoCorrect: false,
                    labelText: "brandName",
                    obscureText: false,
                    enableSuggestions: false,
                    valid: null),
                _renderTextInput(
                    controller: imageEditingController,
                    keyboardType: TextInputType.text,
                    autoCorrect: false,
                    labelText: "image",
                    obscureText: false,
                    enableSuggestions: false,
                    valid: null),
                _renderTextInput(
                    controller: currentPriceEditingController,
                    keyboardType: TextInputType.text,
                    autoCorrect: false,
                    labelText: "currentPrice",
                    obscureText: false,
                    enableSuggestions: false,
                    valid: null),
                _renderTextInput(
                    controller: lastPriceEditingController,
                    keyboardType: TextInputType.text,
                    autoCorrect: false,
                    labelText: "lastPrice",
                    obscureText: false,
                    enableSuggestions: false,
                    valid: null),
                _renderTextInput(
                    controller: descriptionEditingController,
                    keyboardType: TextInputType.text,
                    autoCorrect: false,
                    labelText: "description",
                    obscureText: false,
                    enableSuggestions: false,
                    valid: null),
                _renderTextInput(
                    controller: useTypeEditingController,
                    keyboardType: TextInputType.text,
                    autoCorrect: false,
                    labelText: "useType",
                    obscureText: false,
                    enableSuggestions: false,
                    valid: null),
                _renderTextInput(
                    controller: scentEditingController,
                    keyboardType: TextInputType.text,
                    autoCorrect: false,
                    labelText: "scent",
                    obscureText: false,
                    enableSuggestions: false,
                    valid: null),
                _renderTextInput(
                    controller: liquidVolumeEditingController,
                    keyboardType: TextInputType.text,
                    autoCorrect: false,
                    labelText: "liquidVolume",
                    obscureText: false,
                    enableSuggestions: false,
                    valid: null),
                _renderTextInput(
                    controller: rateStarEditingController,
                    keyboardType: TextInputType.text,
                    autoCorrect: false,
                    labelText: "rateStar",
                    obscureText: false,
                    enableSuggestions: false,
                    valid: null),
                _renderTextInput(
                    controller: quantityPurchasedEditingController,
                    keyboardType: TextInputType.text,
                    autoCorrect: false,
                    labelText: "quantityPurchased",
                    obscureText: false,
                    enableSuggestions: false,
                    valid: null),
                _renderTextInput(
                    controller: numberCountProductEditingController,
                    keyboardType: TextInputType.text,
                    autoCorrect: false,
                    labelText: "numberCountProduct",
                    obscureText: false,
                    enableSuggestions: false,
                    valid: null),
                Row(
                  children: [
                    const SizedBox(width: 40),
                    Text("Like: "),
                    Radio<isLiked>(
                        value: isLiked.like,
                        groupValue: _isLike,
                        onChanged: (isLiked? value) {
                          setState(() {
                            _isLike = value!;
                          });
                        }),
                    const SizedBox(width: 40),
                    const Text("Disslike: "),
                    Radio<isLiked>(
                        value: isLiked.dislike,
                        groupValue: _isLike,
                        onChanged: (isLiked? value) {
                          setState(() {
                            _isLike = value!;
                          });
                        }),
                  ],
                ),
                ElevatedButton(
                  onPressed: onPressedCreateData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 50),
                    elevation: 8,
                    onPrimary: Colors.white,
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  child: const Text("Create"),
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ));
  }

  _renderTextInput(
      {controller,
      keyboardType,
      autoCorrect,
      labelText,
      obscureText,
      enableSuggestions,
      valid}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: TextFormField(
        controller: controller,
        enableSuggestions: enableSuggestions,
        obscureText: obscureText,
        keyboardType: keyboardType,
        autocorrect: autoCorrect,
        cursorColor: Colors.black87,
        decoration: InputDecoration(
          // labelText: labelText,
          // labelStyle: const TextStyle(color: Colors.black54),
          hintStyle: const TextStyle(fontSize: 14),
          hintText: labelText,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          focusColor: primaryLightColor,
          fillColor: Colors.white,
          filled: true,
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(8)),
            gapPadding: 1.0,
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(8)),
            gapPadding: 4.0,
          ),
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: valid,
      ),
    );
  }

  void onPressedCreateData() {
    LuxuryProduct luxuryProduct = LuxuryProduct(
      id: luxuryProductRef.id,
      name: nameEditingController?.text as String,
      brandName: brandNameEditingController?.text as String,
      image: imageEditingController?.text as String,
      currentPrice: double.parse(currentPriceEditingController?.text as String),
      lastPrice: double.parse(lastPriceEditingController?.text as String),
      description: descriptionEditingController?.text as String,
      useType: useTypeEditingController?.text as String,
      scent: scentEditingController?.text as String,
      liquidVolume: int.parse(liquidVolumeEditingController?.text as String),
      rateStar: double.parse(rateStarEditingController?.text as String),
      quantityPurchased: int.parse(quantityPurchasedEditingController?.text as String),
      isLiked: (_isLike == isLiked.like) ? true : false,
      numberCountProduct: int.parse(numberCountProductEditingController?.text as String),
    );
    final json = luxuryProduct.toJson();
    // print(json.runtimeType);
    createProduct(luxuryProduct: luxuryProduct);
  }

  // Future createProduct({  luxuryProduct}) async {
  //   return luxuryProductRef
  //       . add(luxuryProduct)
  //       .then((value) => print("Product Added"))
  //       .catchError((error) => print("Failed to add product: $error"));
  // }
   Future createProduct({  luxuryProduct}) async {
    return luxuryProductRef
        . set(luxuryProduct.toJson(), SetOptions(merge: true) )
        .then((value) => print("Product Added"))
        .catchError((error) => print("Failed to add product: $error"));
  }
}
