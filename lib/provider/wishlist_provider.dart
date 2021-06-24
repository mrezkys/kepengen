import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kepengen/model/helper/value_checker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

class WishlistProvider extends ChangeNotifier {
  bool _resetFilter = false;
  get resetFilter => _resetFilter;
  set resetFilter(value) {
    _resetFilter = value;
    notifyListeners();
  }

  bool _isCompleted = false;
  get isCompleted => _isCompleted;
  set isCompleted(value) {
    _isCompleted = value;
    if (isCompleted == true) {
      isInCompleted = false;
    }
    notifyListeners();
  }

  bool _isInCompleted = false;
  get isInCompleted => _isInCompleted;
  set isInCompleted(value) {
    _isInCompleted = value;
    if (isInCompleted == true) {
      isCompleted = false;
    }
    notifyListeners();
  }

  bool _filterTerdekat = false;
  get filterTerdekat => _filterTerdekat;
  set filterTerdekat(value) {
    _filterTerdekat = value;
    notifyListeners();
  }

  bool _filterTerpengen = false;
  get filterTerpengen => _filterTerpengen;
  set filterTerpengen(value) {
    _filterTerpengen = value;
    notifyListeners();
  }

  bool _filterTermurah = false;
  get filterTermurah => _filterTermurah;
  set filterTermurah(value) {
    _filterTermurah = value;
    notifyListeners();
  }

  bool _filterTermahal = false;
  get filterTermahal => _filterTermahal;
  set filterTermahal(value) {
    _filterTermahal = value;
    notifyListeners();
  }

  void formReset() {
    _wishlistName = null;
    _wishlistLink = null;
    _wishlistPrice = null;
    _wishlistDeadlineDate = null;
    _wishlistDeadlineTime = null;
    _wishlistPriority = 1;
    _wishlistNotification = false;
    _wishlistPickedPhoto = null;
  }

  bool formChecker() {
    if (ValueChecker.isNullOrEmpty(_wishlistName) ||
        ValueChecker.isNullOrEmpty(_wishlistPrice) ||
        ValueChecker.isNullOrEmpty(_wishlistDeadlineDate) ||
        ValueChecker.isNullOrEmpty(_wishlistDeadlineTime)) {
      return false;
    } else {
      return true;
    }
  }

  String _wishlistName;
  get wishlistName => _wishlistName;
  set wishlistName(value) {
    _wishlistName = value;
    notifyListeners();
  }

  String _wishlistLink;
  get wishlistLink => _wishlistLink;
  set wishlistLink(value) {
    _wishlistLink = value;
    notifyListeners();
  }

  int _wishlistPrice;
  get wishlistPrice => _wishlistPrice;
  set wishlistPrice(value) {
    _wishlistPrice = value;
    notifyListeners();
  }

  String _wishlistDeadlineDate;
  get wishlistDeadlineDate => _wishlistDeadlineDate;
  set wishlistDeadlineDate(value) {
    _wishlistDeadlineDate = value;
    notifyListeners();
  }

  String _wishlistDeadlineTime;
  get wishlistDeadlineTime => _wishlistDeadlineTime;
  set wishlistDeadlineTime(value) {
    _wishlistDeadlineTime = value;
    notifyListeners();
  }

  double _wishlistPriority = 1;
  get wishlistPriority => _wishlistPriority;
  set wishlistPriority(value) {
    _wishlistPriority = value;
    notifyListeners();
  }

  bool _wishlistNotification = false; // just save the state
  get wishlistNotification => _wishlistNotification;
  // set the notification based on the state value
  set wishlistNotification(value) {
    _wishlistNotification = value;

    notifyListeners();
  }

  File _wishlistPickedPhoto;
  get wishlistPickedPhoto => _wishlistPickedPhoto;

  Future<File> wishlistPhotoPicker() async {
    File _image;
    final picker = ImagePicker();
    var pickedImage = await picker.getImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      _image = File(pickedImage.path); //get image from path
      return _image;
    } else {
      return null;
    }
  }

  Future<String> saveWishlistPhoto(File photo) async {
    if (photo != null) {
      var appDocumentDirectory = await pathProvider.getApplicationDocumentsDirectory();
      var path = appDocumentDirectory.path;
      var imageName = basename(photo.path);
      File _newPhoto = await photo.copy('$path/$imageName');
      return _newPhoto.path;
    } else {
      return null;
    }
  }

  set wishlistPickedPhoto(value) {
    if (value != null) {
      _wishlistPickedPhoto = value;
      print(_wishlistPickedPhoto.path);
      notifyListeners();
    } else {
      _wishlistPickedPhoto = value;
      notifyListeners();
    }
  }

  String _wishlistPhotoPath;
  get wishlistPhotoPath => _wishlistPhotoPath;
  set wishlistPhotoPath(value) {
    _wishlistPhotoPath = value;
    notifyListeners();
  }
}
