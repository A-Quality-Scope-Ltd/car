import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../comment_model.dart';
import '../data_information/seller_registration_info.dart';

class FirebaseAppHelper {
//start methods to  set data from firebase by cloud fireStore
  setDataSeller(
      {required String phone, required Map<String, dynamic> setData}) async {
    CollectionReference set = FirebaseFirestore.instance.collection('Sellers');

    set.doc(phone).set(setData);
  }

//start methods to  set data from firebase by cloud fireStore
  setDataProduct({required Map<String, dynamic> setData}) async {
    CollectionReference set = FirebaseFirestore.instance.collection('Products');

    set.doc().set(setData);
  }

  // set user data
  setUserData({String? phone, Map<String, dynamic>? setUser}) async {
    var set = FirebaseFirestore.instance.collection('Users');
    set.doc(phone).set(setUser!);
  }

  setOrderData({Map<String, dynamic>? setOrder}) async {
    var set = FirebaseFirestore.instance.collection('Orders');
    set.doc().set(setOrder!);
  }

  setRequestData({Map<String, dynamic>? setOrder}) async {
    var set = FirebaseFirestore.instance.collection('Requests');
    set.doc().set(setOrder!);
  }

  setOrderReturnsData({String? id, Map<String, dynamic>? setOrder}) async {
    var set = FirebaseFirestore.instance.collection('OrderReturns');
    set.doc(id).set(setOrder!);
  }
//end methods to  set data from firebase by cloud fireStore

//start methods to  set data from firebase by storage
  uploadImage({
    required String phoneProduct,
    required String nameImage,
    required File imagePath,
  }) async {
    var storage = FirebaseStorage.instance;
    await storage.ref('Sellers/$phoneProduct/$nameImage').putFile(imagePath);
  }
  // set  Image to storage

//end methods to  set data from firebase by storage

//start methods to get data from firebase by cloud fireStore
  Future getAdmin() async {
    var phone;
    await FirebaseFirestore.instance
        .collection('Admin')
        .doc('admins')
        .get()
        .then((value) {
      phone = value;
    });
    return phone;
  }

  //get seller data
  Future getSellerData({
    String? phone,
  }) async {
    var data;
    await FirebaseFirestore.instance
        .collection('Sellers')
        .doc(phone)
        .get()
        .then((value) {
      data = value;
    });
    return data;
  }

  //get user data
  Future getUserData({
    String? phone,
  }) async {
    SellerRegistrationInfo data = SellerRegistrationInfo();
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(phone)
        .get()
        .then((value) {
      data = SellerRegistrationInfo.fromJson(value as Map<String, String>);
    });
    return data;
  }

  // download  logo from Storage
  Future storage({
    required String image,
  }) async {
    var storage =
        await FirebaseStorage.instance.ref().child(image).getDownloadURL();
    return storage;
  }
  // download  logo from Storage

  // get new data

//end methods to get data from firebase by cloud fireStore

//start update data from firebase by cloud fireStore
  updateUsers({String? phone, Map<String, dynamic>? setUpdate}) async {
    var update = FirebaseFirestore.instance.collection('Users');
    update.doc(phone).update(setUpdate!);
  }

  updateSellerData({String? phone, Map<String, dynamic>? updateData}) async {
    var update = FirebaseFirestore.instance.collection('Sellers');
    update.doc(phone).update(updateData!);
  }

  updateProductData({String? id, Map<String, dynamic>? updateData}) async {
    var update = FirebaseFirestore.instance.collection('Products');
    update.doc(id).update(updateData!);
  }

  updateOrderData({String? id, Map<String, dynamic>? updateData}) async {
    var update = FirebaseFirestore.instance.collection('Orders');
    update.doc(id).update(updateData!);
  }

  updateRequestData({String? id, Map<String, dynamic>? updateData}) async {
    var update = FirebaseFirestore.instance.collection('Requests');
    update.doc(id).update(updateData!);
  }

  updateOrderReturnsData({String? id, Map<String, dynamic>? updateData}) async {
    var update = FirebaseFirestore.instance.collection('OrderReturns');
    update.doc(id).update(updateData!);
  }
//end update data from firebase by cloud fireStore

//start methods delete data from firebase by cloud fireStore
  // delete sellers data from firebase by cloud fireStore
  deleteSeller({
    String? phone,
  }) async {
    var delete = FirebaseFirestore.instance.collection('Sellers');
    delete.doc(phone).delete();
  }

  deleteProduct({
    String? id,
  }) async {
    var delete = FirebaseFirestore.instance.collection('Products');
    delete.doc(id).delete();
  }

  deleteOrder({
    String? id,
  }) async {
    var delete = FirebaseFirestore.instance.collection('Orders');
    delete.doc(id).delete();
  }

  deleteRequest({
    String? id,
  }) async {
    var delete = FirebaseFirestore.instance.collection('Requests');
    delete.doc(id).delete();
  }

  deleteOrderReturns({
    String? id,
  }) async {
    var delete = FirebaseFirestore.instance.collection('OrderReturns');
    delete.doc(id).delete();
  }
  // delete  data

  // delete comment data
  deleteComment(String id, CommentModel commentModel, double assess) async {
    CollectionReference delete =
        FirebaseFirestore.instance.collection('Products');
    delete
        .doc(
      id,
    )
        .update({
      'comment': FieldValue.arrayRemove([commentModel.toMap()]),
      'assess': assess - commentModel.ratingCharity,
    });
  }
  // delete comment data

  // delete user data
  deleteUserData(String phone) async {
    CollectionReference delete = FirebaseFirestore.instance.collection('Users');
    await delete.doc(phone).delete();
  }

  deleteImage({
    required String image,
  }) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    await storage.ref('Seller/$image').delete();
  }
  //delete logo from firebase

//end methods delete data from firebase by cloud fireStore
}
