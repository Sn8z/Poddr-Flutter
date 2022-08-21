import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poddr/services/auth_service.dart';

final fireDbProvider = Provider<FirebaseFirestore?>(
  (ref) {
    final auth = ref.watch(userProvider);

    if (auth.asData?.value?.uid != null) {
      return FirebaseFirestore.instance;
    } else {
      return null;
    }
  },
);

final favouritesProvider = Provider<Favourites>(
  (ref) {
    return Favourites(ref.watch(fireDbProvider), ref.watch(userProvider).value);
  },
);

final favStreamProvider = StreamProvider.autoDispose<List<dynamic>>(
  (ref) {
    return ref.watch(favouritesProvider).favourites;
  },
);

class Favourites {
  final FirebaseFirestore? db;
  final User? user;

  Favourites(this.db, this.user);

  Future<void> addFavourite(
      {required String rss,
      required String title,
      required String image,
      List<String> categories = const []}) async {
    if (db != null && user != null) {
      try {
        await db
            ?.collection('users')
            .doc(user?.uid)
            .collection('favourites')
            .doc(Uri.encodeComponent(rss))
            .set({
          'title': title,
          'image': image,
          'rss': rss,
          'categories': categories
        });
        debugPrint('Added favourite');
      } on FirebaseException catch (e) {
        debugPrint(e.toString());
      }
    } else {
      debugPrint('Not logged in');
    }
  }

  Future<void>? removeFavourite(String rss) {
    return db
        ?.collection('users')
        .doc(user?.uid)
        .collection('favourites')
        .doc(Uri.encodeComponent(rss))
        .delete()
        .then((value) {
      debugPrint('Removed favourite $rss');
    }).catchError((e) {
      debugPrint(e.toString());
    });
  }

  Stream<List<dynamic>> get favourites {
    if (db != null && user != null) {
      final Stream stream = db!
          .collection('users')
          .doc(user?.uid)
          .collection('favourites')
          .snapshots();
      return stream
          .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
    } else {
      return Stream.error('Not logged in');
    }
  }
}
