import 'package:kepengen/model/core/wishlist.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await initDB();
      return _database;
    }
  }

  initDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'kepengen.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE wishlist (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            link TEXT,
            price BIGINT,
            deadline DATETIME,
            photo TEXT,
            priority DOUBLE,
            status INT,
            notification BOOLEAN
          )
          ''');
      },
    );
  }

  addWishlist(Wishlist wishlistData) async {
    final db = await database;
    await db.insert('wishlist', wishlistData.toMap());
    return true;
  }

  deleteWishlist(int id) async {
    final db = await database;
    await db.rawDelete("DELETE FROM  wishlist WHERE ID=" + id.toString());
  }

  Future<List<Wishlist>> getNotificationWishlist() async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM wishlist WHERE NOTIFICATION=true");
    try {
      return res.map((e) => Wishlist.fromJson(e)).toList();
    } catch (e) {
      return e;
    }
  }

  Future<List<Wishlist>> getAllWishlist({String filter = 'all'}) async {
    if (filter == 'completed') {
      final db = await database;
      var res = await db.rawQuery("SELECT * FROM wishlist WHERE STATUS=1");
      try {
        return res.map((e) => Wishlist.fromJson(e)).toList();
      } catch (e) {
        return e;
      }
    } else if (filter == 'incompleted') {
      final db = await database;
      var res = await db.rawQuery("SELECT * FROM wishlist WHERE STATUS IS NOT 1");
      try {
        return res.map((e) => Wishlist.fromJson(e)).toList();
      } catch (e) {
        return e;
      }
    }

    //  Terdekat ---------------------------------------------------------------------------
    else if (filter == 'terdekat') {
      final db = await database;
      var res = await db.rawQuery("SELECT * FROM WISHLIST ORDER BY deadline");
      try {
        print('terdekat');
        return res.map((e) => Wishlist.fromJson(e)).toList();
      } catch (e) {
        return e;
      }
    } else if (filter == 'terdekat & Completed') {
      final db = await database;
      var res = await db.rawQuery("SELECT * FROM WISHLIST WHERE STATUS=1 ORDER BY deadline");
      try {
        print('terdekat & Completed');
        return res.map((e) => Wishlist.fromJson(e)).toList();
      } catch (e) {
        print(e);
      }
    } else if (filter == 'terdekat & inCompleted') {
      final db = await database;
      var res = await db.rawQuery("SELECT * FROM WISHLIST WHERE STATUS=0 ORDER BY deadline");
      try {
        print('terdekat & inCompleted');
        return res.map((e) => Wishlist.fromJson(e)).toList();
      } catch (e) {
        print(e);
      }
    }
    //  ----------------------------------------------------------------------------------

    //  Terpengen ---------------------------------------------------------------------------
    else if (filter == 'terpengen') {
      final db = await database;
      var res = await db.rawQuery("SELECT * FROM WISHLIST ORDER BY priority DESC");
      try {
        print('terpengen');
        return res.map((e) => Wishlist.fromJson(e)).toList();
      } catch (e) {
        print(e);
      }
    } else if (filter == 'terpengen & Completed') {
      final db = await database;
      var res = await db.rawQuery("SELECT * FROM WISHLIST WHERE STATUS=1 ORDER BY priority DESC");
      try {
        print('terpengen & Completed');
        return res.map((e) => Wishlist.fromJson(e)).toList();
      } catch (e) {
        print(e);
      }
    } else if (filter == 'terpengen & inCompleted') {
      final db = await database;
      var res = await db.rawQuery("SELECT * FROM WISHLIST WHERE STATUS=0 ORDER BY priority DESC");
      try {
        print('terpengen & inCompleted');
        return res.map((e) => Wishlist.fromJson(e)).toList();
      } catch (e) {
        print(e);
      }
    }
    //  ----------------------------------------------------------------------------------

    //  Termurah ---------------------------------------------------------------------------
    else if (filter == 'termurah') {
      final db = await database;
      var res = await db.rawQuery("SELECT * FROM WISHLIST ORDER BY price");
      try {
        print('termurah');
        return res.map((e) => Wishlist.fromJson(e)).toList();
      } catch (e) {
        print(e);
      }
    } else if (filter == 'termurah & Completed') {
      final db = await database;
      var res = await db.rawQuery("SELECT * FROM WISHLIST WHERE STATUS=1 ORDER BY price");
      try {
        print('termurah & Completed');
        return res.map((e) => Wishlist.fromJson(e)).toList();
      } catch (e) {
        print(e);
      }
    } else if (filter == 'termurah & inCompleted') {
      final db = await database;
      var res = await db.rawQuery("SELECT * FROM WISHLIST WHERE STATUS=0 ORDER BY price");
      try {
        print('termurah & inCompleted');
        return res.map((e) => Wishlist.fromJson(e)).toList();
      } catch (e) {
        print(e);
      }
    }
    //  ----------------------------------------------------------------------------------

    //  Termahal ---------------------------------------------------------------------------
    else if (filter == 'termahal') {
      final db = await database;
      var res = await db.rawQuery("SELECT * FROM WISHLIST ORDER BY price DESC");
      try {
        print('termahal');
        return res.map((e) => Wishlist.fromJson(e)).toList();
      } catch (e) {
        print(e);
      }
    } else if (filter == 'termahal & Completed') {
      final db = await database;
      var res = await db.rawQuery("SELECT * FROM WISHLIST WHERE STATUS=1 ORDER BY price DESC");
      try {
        print('termahal & Completed');
        return res.map((e) => Wishlist.fromJson(e)).toList();
      } catch (e) {
        print(e);
      }
    } else if (filter == 'termahal & inCompleted') {
      final db = await database;
      var res = await db.rawQuery("SELECT * FROM WISHLIST WHERE STATUS=0 ORDER BY price DESC");
      try {
        print('termahal & inCompleted');
        return res.map((e) => Wishlist.fromJson(e)).toList();
      } catch (e) {
        print(e);
      }
    }
    //  ----------------------------------------------------------------------------------

    else if (filter == 'all') {
      final db = await database;
      var res = await db.query("wishlist");
      try {
        return res.map((e) => Wishlist.fromJson(e)).toList();
      } catch (e) {
        print(e);
        return [];
      }
    }
  }

  Future<List<Wishlist>> getFiveRandomWishlist() async {
    // TODO: make error handler
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM wishlist ORDER BY RANDOM() Limit 5");
    if (res.length != 0) {
      return res.map((e) => Wishlist.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<Wishlist> getWishlist(int id) async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM WISHLIST WHERE ID='" + id.toString() + "'", null);
    return Wishlist.fromJson(res[0]);
  }

  Future<Wishlist> getFeaturedWishlist(String type) async {
    final db = await database;
    if (type == 'terdekat') {
      var res = await db.rawQuery("SELECT * FROM WISHLIST ORDER BY deadline Limit 1");
      try {
        return Wishlist.fromJson(res[0]);
      } catch (e) {
        print(e);
      }
    }
    if (type == 'terpengen') {
      var res = await db.rawQuery("SELECT * FROM WISHLIST ORDER BY priority DESC Limit 1");
      try {
        return Wishlist.fromJson(res[0]);
      } catch (e) {
        print(e);
      }
    }
    if (type == 'termurah') {
      var res = await db.rawQuery("SELECT * FROM WISHLIST ORDER BY price Limit 1");
      try {
        return Wishlist.fromJson(res[0]);
      } catch (e) {
        print(e);
      }
    }
    if (type == 'termahal') {
      // kayanya res harus dimasukin ke try
      var res = await db.rawQuery("SELECT * FROM WISHLIST ORDER BY price DESC Limit 1");
      try {
        return Wishlist.fromJson(res[0]);
      } catch (e) {
        print(e);
      }
    }
  }

  Future<dynamic> getWishlistTotalPrice() async {
    final db = await database;
    var res = await db.rawQuery("SELECT SUM(price) as total_wishlist_price FROM WISHLIST");
    var total = res[0]['total_wishlist_price'];
    if (total != null) {
      return total;
    }
    return 0;
  }

  Future<dynamic> getWishlistTotalSpending() async {
    final db = await database;
    var res = await db.rawQuery("SELECT SUM(price) as total_wishlist_spending FROM WISHLIST WHERE status = 1");
    var total = res[0]['total_wishlist_spending'];
    if (total != null) {
      return total;
    }
    return 0;
  }

  Future<dynamic> setCompletedWishlist(int id) async {
    final db = await database;
    var res = await db.rawQuery("UPDATE WISHLIST SET status=1 WHERE id=" + id.toString());
    if (res.isEmpty) {
      return 'Success!';
    } else {
      return 'Error';
    }
  }
}
