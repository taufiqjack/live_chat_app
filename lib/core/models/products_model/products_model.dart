import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'products_model.freezed.dart';
part 'products_model.g.dart';

@freezed
class ProductsModel with _$ProductsModel {
  factory ProductsModel({
    int? id,
    String? name,
    int? price,
  }) = _ProductsModel;

  factory ProductsModel.fromJson(DocumentSnapshot json) =>
      _$ProductsModelFromJson(json as Map<String, dynamic>);
}
