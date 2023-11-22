import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:movieapp/Features/HomeScreen/data/models/PopularModel.dart';
import 'package:movieapp/Features/HomeScreen/domain/entities/PopularEntity.dart';

class MoviesLocalDsImp {
   static CollectionReference<ResultsEntity>? getTasksCollection() {
    return FirebaseFirestore.instance
        .collection("MovieList")
        .withConverter<Results>(
      fromFirestore: (snapshot, options) {
        return Results.fromJson(snapshot.data()!);
      },
      toFirestore: (value, options) {
        return value.toJson();
      },
    );
  }

  //نوعها Future<void> لان ال set(taskModel) نوعها كدا

   static Future<void> AddMovie(ResultsEntity resultsMovie) {
    var collection = getTasksCollection();
    var documentRef = collection?.doc();
    resultsMovie.movieId = documentRef?.id;
    return documentRef!.set(resultsMovie);
  }

  static Stream<QuerySnapshot<ResultsEntity>> ?getMovies() {
     try {

       return
         getTasksCollection()
             ?.where("select", isEqualTo: true).snapshots();

     } catch (e) {
      throw(e);
     }

   }

   static void deletemovie(String id) {
     getTasksCollection()?.doc(id).delete();
   }


}