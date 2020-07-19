class Setting {
  final int id;
  final String title, description, image;

  Setting({this.id, this.title, this.description, this.image});
}


List<Setting> settings = [
  Setting(
    id: 1,
    title: "基本设置",
    image: "assets/images/item_1.png",
    description:
        "Hello Dear",
  ),
  Setting(
    id: 4,
    title: "页面设置",
    image: "assets/images/item_2.png",
    description:
        "Hello Dear",
  ),
  Setting(
    id: 9,
    title: "账号管理",
    image: "assets/images/item_3.png",
    description:
        "Hello Dear",
  ),
];
