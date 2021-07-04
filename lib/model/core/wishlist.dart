class Wishlist {
  int id;
  String name;
  String link;
  int price;
  String deadline;
  String photo;
  double priority;
  int status;
  bool notification;

  Wishlist({this.name, this.link, this.price, this.deadline, this.photo, this.priority, this.status, this.notification, this.id});

  Map<String, Object> toMap() {
    return {
      'id': id,
      'name': name,
      'link': link,
      'price': price,
      'deadline': deadline,
      'photo': photo,
      'priority': priority,
      'status': status,
      'notification': notification,
    };
  }

  factory Wishlist.fromJson(Map<String, Object> json) => Wishlist(
        id: json['id'],
        name: json['name'],
        link: json['link'],
        deadline: json['deadline'],
        notification: (json['notification'] == 0) ? false : true,
        photo: json['photo'],
        price: json['price'],
        priority: json['priority'],
        status: json['status'],
      );

  @override
  String toString() {
    // TODO: implement toString
    return 'Wishlist(id : $id, name : $name, link : $link, deadline : $deadline, notification : $notification, photo : $photo, price : $price, priority : $priority, status : $status';
  }
}
