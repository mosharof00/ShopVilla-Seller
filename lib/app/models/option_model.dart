import '../../gen/assets.gen.dart';

class OptionItem {
  final String? title;
  final String? value;

  OptionItem({this.title, this.value});
}

List<OptionItem> optionItem = [
  OptionItem(
    title: 'Recent Orders',
    value: Assets.images.recentorder,
  ),
  OptionItem(
    title: 'Sales Summary',
    value: Assets.images.salesSummary,
  ),
  OptionItem(
    title: 'My Order',
    value: Assets.icons.myOrdersIcon,
  ),
  OptionItem(
    title: 'Stocks',
    value: Assets.icons.stocks,
  ),
  OptionItem(
    title: 'Add Product',
    value: Assets.icons.addProduct,
  ),
  OptionItem(
    title: 'Products',
    value: Assets.images.allproduct,
  ),
  OptionItem(
    title: 'Category',
    value: Assets.images.category,
  ),
  OptionItem(
      title: 'Brand',
      value: Assets.images.brands
  ),
OptionItem(
    title: 'Customers',
    value: Assets.images.customers,
  ),
  OptionItem(
    title: 'Supplier',
    value: Assets.images.supplier,
  ),
  OptionItem(
    title: 'Support',
    value: Assets.icons.customerSupport,
  ),

];
