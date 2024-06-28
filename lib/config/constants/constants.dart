//fonts
const String fontGilroy = 'Gilroy';
const String fontPeaceSans = 'PeaceSans';

//icons
const String homeIcon = 'assets/icons/home.svg';
const String homeBoldIcon = 'assets/icons/homeBold.svg';
const String categoryIcon = 'assets/icons/category.svg';
const String categoryBoldIcon = 'assets/icons/categoryBold.svg';
const String shopIcon = 'assets/icons/shop.svg';
const String shopBoldIcon = 'assets/icons/shopBold.svg';
const String heartIcon = 'assets/icons/heart.svg';
const String heartBoldIcon = 'assets/icons/heartBold.svg';
const String userIcon = 'assets/icons/user.svg';
const String userBoldIcon = 'assets/icons/userBold.svg';
const String mapPinIcon = 'assets/icons/mapPin.svg';
const String arrowRightIcon = 'assets/icons/arrowRight.svg';
const String searchIcon = 'assets/icons/search.svg';
//images
const String bannerImage = 'assets/images/banner.png';
const String banner1Image = 'assets/images/banner1.png';

//products
const String sale1Image = 'assets/products/sale1.png';
const String sale2Image = 'assets/products/sale2.png';
const String sale3Image = 'assets/products/sale3.png';
const String veg1Image = 'assets/products/veg1.png';
const String veg2Image = 'assets/products/veg2.png';
const String veg3Image = 'assets/products/veg3.png';
const String milk1Image = 'assets/products/milk1.png';
const String milk2Image = 'assets/products/milk2.png';
const String meat1Image = 'assets/products/meat1.png';

List<Map<String, dynamic>> bottomNavBarItems = [
  {
    'icon': homeIcon,
    'iconBold': homeBoldIcon,
  },
  {
    'icon': categoryIcon,
    'iconBold': categoryBoldIcon,
  },
  {
    'icon': shopIcon,
    'iconBold': shopBoldIcon,
  },
  {
    'icon': heartIcon,
    'iconBold': heartBoldIcon,
  },
  {
    'icon': userIcon,
    'iconBold': userBoldIcon,
  }
];
//tabbar names
List<Map<String, dynamic>> tabbarName = [
  {'name': 'Скидки'},
  {'name': 'Овощи и фрукты'},
  {'name': 'Мясо'},
  {'name': 'Молочка'},
  {'name': 'Касметика'},
  {'name': 'Гигиена'},
  {'name': 'Дом'},
  {'name': 'Детям'},
  {'name': 'Концелярия'},
  {'name': 'Зоотовары'},
];
List<Map<String, dynamic>> saleProducts = [
  {
    'name': 'Органические яблоки',
    'image': sale1Image,
    'price': '11.20',
    'prev_price': '15.40',
    'discount': '-12%',
    'desc': 'Сочные и сладкие яблоки.',
  },
  {
    'name': 'Авокадо Хасс',
    'image': sale2Image,
    'price': '21.50',
    'prev_price': '29.40',
    'discount': '-5%',
    'desc': 'Сочные и сладкие яблоки.',
  },
  {
    'name': 'Свежие помидоры',
    'image': sale3Image,
    'price': '11.20',
    'prev_price': '13.40',
    'discount': '-2%',
    'desc': 'Сочные и сладкие яблоки.',
  },
  {
    'name': 'Авокадо Хасс',
    'image': sale2Image,
    'price': '21.50',
    'prev_price': '29.40',
    'discount': '-5%',
    'desc': 'Сочные и сладкие яблоки.',
  },
  {
    'name': 'Свежие помидоры',
    'image': sale3Image,
    'price': '11.20',
    'prev_price': '13.40',
    'discount': '-2%',
    'desc': 'Сочные и сладкие яблоки.',
  },
];
List<Map<String, dynamic>> vegProducts = [
  {
    'name': 'Зелень салата',
    'image': veg1Image,
    'price': '2.20',
    'prev_price': null,
    'discount': null,
    'desc': 'Сочные и сладкие яблоки.',
  },
  {
    'name': 'Клубника свежая 1 ланчик',
    'image': veg2Image,
    'price': '18.70',
    'prev_price': '22.40',
    'discount': '-20%',
    'desc': 'Сочные и сладкие яблоки.',
  },
  {
    'name': 'Бананы 6 шт',
    'image': veg3Image,
    'price': '5.20',
    'prev_price': '9.80',
    'discount': '-4%',
    'desc': 'Сочные и сладкие яблоки.',
  },
  {
    'name': 'Картофель',
    'image': sale2Image,
    'price': '4.50',
    'prev_price': null,
    'discount': null,
    'desc': 'Сочные и сладкие яблоки.',
  },
];
List<Map<String, dynamic>> meatProducts = [
  {
    'name': 'Куринное филе грудк',
    'image': meat1Image,
    'price': '40.00',
    'prev_price': '45.00',
    'discount': '-10%',
    'desc': 'Сочные и сладкие яблоки.',
  },
  {
    'name': 'Авокадо Хасс',
    'image': sale2Image,
    'price': '21.50',
    'prev_price': '29.40',
    'discount': '-5%',
    'desc': 'Сочные и сладкие яблоки.',
  },
  {
    'name': 'Свежие помидоры',
    'image': sale3Image,
    'price': '11.20',
    'prev_price': '13.40',
    'discount': '-2%',
    'desc': 'Сочные и сладкие яблоки.',
  },
];
List<Map<String, dynamic>> milkProducts = [
  {
    'name': 'Органические яблоки',
    'image': milk1Image,
    'price': '11.20',
    'prev_price': '15.40',
    'discount': '-12%',
    'desc': 'Сочные и сладкие яблоки.',
  },
  {
    'name': 'огурт клубничный',
    'image': milk2Image,
    'price': '21.50',
    'prev_price': '15.40',
    'discount': '-12%',
    'desc': 'Сочные и сладкие яблоки.',
  },
  {
    'name': 'Свежие помидоры',
    'image': sale3Image,
    'price': '11.20',
    'prev_price': '15.40',
    'discount': '-12%',
    'desc': 'Сочные и сладкие яблоки.',
  },
];
List<Map<String, dynamic>> cosmeticsProducts = [
  {
    'name': 'Органические яблоки',
    'image': sale1Image,
    'price': '11.20',
    'prev_price': '15.40',
    'discount': '-12%',
    'desc': 'Сочные и сладкие яблоки.',
  },
  {
    'name': 'Авокадо Хасс',
    'image': sale2Image,
    'price': '21.50',
    'prev_price': '29.40',
    'discount': '-5%',
    'desc': 'Сочные и сладкие яблоки.',
  },
  {
    'name': 'Свежие помидоры',
    'image': sale3Image,
    'price': '11.20',
    'prev_price': '13.40',
    'discount': '-2%',
    'desc': 'Сочные и сладкие яблоки.',
  },
  {
    'name': 'Авокадо Хасс',
    'image': sale2Image,
    'price': '21.50',
    'prev_price': '29.40',
    'discount': '-5%',
    'desc': 'Сочные и сладкие яблоки.',
  },
];
List<Map<String, dynamic>> hygieneProducts = [
  {
    'name': 'Органические яблоки',
    'image': sale1Image,
    'price': '11.20',
    'prev_price': '15.40',
    'discount': '-12%',
    'desc': 'Сочные и сладкие яблоки.',
  },
  {
    'name': 'Авокадо Хасс',
    'image': sale2Image,
    'price': '21.50',
    'prev_price': '29.40',
    'discount': '-5%',
    'desc': 'Сочные и сладкие яблоки.',
  },
  {
    'name': 'Свежие помидоры',
    'image': sale3Image,
    'price': '11.20',
    'prev_price': '13.40',
    'discount': '-2%',
    'desc': 'Сочные и сладкие яблоки.',
  },
  {
    'name': 'Авокадо Хасс',
    'image': sale2Image,
    'price': '21.50',
    'prev_price': '29.40',
    'discount': '-5%',
    'desc': 'Сочные и сладкие яблоки.',
  },
];
List<Map<String, dynamic>> houseProducts = [
  {
    'name': 'Органические яблоки',
    'image': sale1Image,
    'price': '11.20',
    'prev_price': '15.40',
    'discount': '-12%',
    'desc': 'Сочные и сладкие яблоки.',
  },
  {
    'name': 'Авокадо Хасс',
    'image': sale2Image,
    'price': '21.50',
    'prev_price': '29.40',
    'discount': '-5%',
    'desc': 'Сочные и сладкие яблоки.',
  },
  {
    'name': 'Свежие помидоры',
    'image': sale3Image,
    'price': '11.20',
    'prev_price': '13.40',
    'discount': '-2%',
    'desc': 'Сочные и сладкие яблоки.',
  },
  {
    'name': 'Авокадо Хасс',
    'image': sale2Image,
    'price': '21.50',
    'prev_price': '29.40',
    'discount': '-5%',
    'desc': 'Сочные и сладкие яблоки.',
  },
];
List<Map<String, dynamic>> childProducts = [
  {
    'name': 'Органические яблоки',
    'image': sale1Image,
    'price': '11.20',
    'prev_price': '15.40',
    'discount': '-12%',
    'desc': 'Сочные и сладкие яблоки.',
  },
  {
    'name': 'Авокадо Хасс',
    'image': sale2Image,
    'price': '21.50',
    'prev_price': '29.40',
    'discount': '-5%',
    'desc': 'Сочные и сладкие яблоки.',
  },
  {
    'name': 'Свежие помидоры',
    'image': sale3Image,
    'price': '11.20',
    'prev_price': '13.40',
    'discount': '-2%',
    'desc': 'Сочные и сладкие яблоки.',
  },
  {
    'name': 'Авокадо Хасс',
    'image': sale2Image,
    'price': '21.50',
    'prev_price': '29.40',
    'discount': '-5%',
    'desc': 'Сочные и сладкие яблоки.',
  },
];
List<Map<String, dynamic>> chanceryProducts = [
  {
    'name': 'Органические яблоки',
    'image': sale1Image,
    'price': '11.20',
    'prev_price': '15.40',
    'discount': '-12%',
    'desc': 'Сочные и сладкие яблоки.',
  },
  {
    'name': 'Авокадо Хасс',
    'image': sale2Image,
    'price': '21.50',
    'prev_price': '29.40',
    'discount': '-5%',
    'desc': 'Сочные и сладкие яблоки.',
  },
  {
    'name': 'Свежие помидоры',
    'image': sale3Image,
    'price': '11.20',
    'prev_price': '13.40',
    'discount': '-2%',
    'desc': 'Сочные и сладкие яблоки.',
  },
  {
    'name': 'Авокадо Хасс',
    'image': sale2Image,
    'price': '21.50',
    'prev_price': '29.40',
    'discount': '-5%',
    'desc': 'Сочные и сладкие яблоки.',
  },
];
List<Map<String, dynamic>> zooProducts = [
  {
    'name': 'Органические яблоки',
    'image': sale1Image,
    'price': '11.20',
    'prev_price': '15.40',
    'discount': '-12%',
    'desc': 'Сочные и сладкие яблоки.',
  },
  {
    'name': 'Авокадо Хасс',
    'image': sale2Image,
    'price': '21.50',
    'prev_price': '29.40',
    'discount': '-5%',
    'desc': 'Сочные и сладкие яблоки.',
  },
  {
    'name': 'Свежие помидоры',
    'image': sale3Image,
    'price': '11.20',
    'prev_price': '13.40',
    'discount': '-2%',
    'desc': 'Сочные и сладкие яблоки.',
  },
  {
    'name': 'Авокадо Хасс',
    'image': sale2Image,
    'price': '21.50',
    'prev_price': '29.40',
    'discount': '-5%',
    'desc': 'Сочные и сладкие яблоки.',
  },
];
