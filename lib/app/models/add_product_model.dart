import 'package:image_picker/image_picker.dart';

class AddProduct {
  String collectionName;
  String productName;
  String productDetails;
  String categoryName;
  List<XFile> addProductFile;
  List<String> sizes;
  List<String> prices;
  List<String> pieces;

  AddProduct({
    required this.collectionName,
    required this.productName,
    required this.productDetails,
    required this.categoryName,
    required this.addProductFile,
    required this.sizes,
    required this.prices,
    required this.pieces,
  });
}
