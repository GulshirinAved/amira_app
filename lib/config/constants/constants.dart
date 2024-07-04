//fonts
import 'package:amira_app/data/models/products_model.dart';

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
const String arrowLeftIcon = 'assets/icons/arrowLeft.svg';
const String searchIcon = 'assets/icons/search.svg';
const String filterIcon = 'assets/icons/filter.svg';
const String settingsIcon = 'assets/icons/settings.svg';
const String trashIcon = 'assets/icons/trash.svg';
const String loginIcon = 'assets/icons/login.svg';

//images
const String bannerImage = 'assets/images/banner.png';
const String banner1Image = 'assets/images/banner1.png';
const String logo1Image = 'assets/images/logo1.png';
const String ruFlagImage = 'assets/images/ruFlag.png';
const String tmFlagImage = 'assets/images/tmFlag.png';

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
const String vegCat1Image = 'assets/products/vegCat1.png';
const String vegCat2Image = 'assets/products/vegCat2.png';
const String vegCat3Image = 'assets/products/vegCat3.png';
const String vegCat4Image = 'assets/products/vegCat4.png';
const String vegCat5Image = 'assets/products/vegCat5.png';
const String meatCat1Image = 'assets/products/meatCat1.png';
const String meatCat2Image = 'assets/products/meatCat2.png';
const String meatCat3Image = 'assets/products/meatCat3.png';
const String milkCat1Image = 'assets/products/milkCat1.png';
const String milkCat2Image = 'assets/products/milkCat2.png';
const String milkCat3Image = 'assets/products/milkCat3.png';
const String milkCat4Image = 'assets/products/milkCat4.png';
const String milkCat5Image = 'assets/products/milkCat5.png';
const String milkCat6Image = 'assets/products/milkCat6.png';
const String appleImage = 'assets/products/apple.png';

//urls
const String url = 'https://kip.tm/magaz/';

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
List<ProductsModel> saleProducts = [
  ProductsModel(
    id: 1,
    name: 'Органические яблоки',
    image: sale1Image,
    price: '11.20',
    prevPrice: '15.40',
    discount: '-12%',
    desc: 'Сочные и сладкие яблоки.',
  ),
  ProductsModel(
    id: 2,
    name: 'Авокадо Хасс',
    image: sale2Image,
    price: '21.50',
    prevPrice: '29.40',
    discount: '-5%',
    desc: 'Сочные и сладкие яблоки.',
  ),
  ProductsModel(
    id: 3,
    name: 'Свежие помидоры',
    image: sale3Image,
    price: '11.20',
    prevPrice: '13.40',
    discount: '-2%',
    desc: 'Сочные и сладкие яблоки.',
  ),
  ProductsModel(
    id: 4,
    name: 'Авокадо Хасс',
    image: sale2Image,
    price: '21.50',
    prevPrice: '29.40',
    discount: '-5%',
    desc: 'Сочные и сладкие яблоки.',
  ),
  ProductsModel(
    id: 5,
    name: 'Свежие помидоры',
    image: sale3Image,
    price: '11.20',
    prevPrice: '13.40',
    discount: '-2%',
    desc: 'Сочные и сладкие яблоки.',
  ),
];
List<ProductsModel> vegProducts = [
  ProductsModel(
    id: 6,
    name: 'Зелень салата',
    image: veg1Image,
    price: '2.20',
    prevPrice: null,
    discount: null,
    desc: 'Сочные и сладкие яблоки.',
  ),
  ProductsModel(
    id: 7,
    name: 'Клубника свежая 1 ланчик',
    image: veg2Image,
    price: '18.70',
    prevPrice: '22.40',
    discount: '-20%',
    desc: 'Сочные и сладкие яблоки.',
  ),
  ProductsModel(
    id: 8,
    name: 'Бананы 6 шт',
    image: veg3Image,
    price: '5.20',
    prevPrice: '9.80',
    discount: '-4%',
    desc: 'Сочные и сладкие яблоки.',
  ),
  ProductsModel(
    id: 9,
    name: 'Картофель',
    image: sale2Image,
    price: '4.50',
    prevPrice: null,
    discount: null,
    desc: 'Сочные и сладкие яблоки.',
  ),
];
List<ProductsModel> meatProducts = [
  ProductsModel(
    id: 10,
    name: 'Куринное филе грудк',
    image: meat1Image,
    price: '40.00',
    prevPrice: '45.00',
    discount: '-10%',
    desc: 'Сочные и сладкие яблоки.',
  ),
  ProductsModel(
    id: 11,
    name: 'Авокадо Хасс',
    image: sale2Image,
    price: '21.50',
    prevPrice: '29.40',
    discount: '-5%',
    desc: 'Сочные и сладкие яблоки.',
  ),
  ProductsModel(
    id: 12,
    name: 'Свежие помидоры',
    image: sale3Image,
    price: '11.20',
    prevPrice: '13.40',
    discount: '-2%',
    desc: 'Сочные и сладкие яблоки.',
  ),
];
List<ProductsModel> milkProducts = [
  ProductsModel(
    id: 13,
    name: 'Органические яблоки',
    image: milk1Image,
    price: '11.20',
    prevPrice: '15.40',
    discount: '-12%',
    desc: 'Сочные и сладкие яблоки.',
  ),
  ProductsModel(
    id: 14,
    name: 'огурт клубничный',
    image: milk2Image,
    price: '21.50',
    prevPrice: '15.40',
    discount: '-12%',
    desc: 'Сочные и сладкие яблоки.',
  ),
  ProductsModel(
    id: 15,
    name: 'Свежие помидоры',
    image: sale3Image,
    price: '11.20',
    prevPrice: '15.40',
    discount: '-12%',
    desc: 'Сочные и сладкие яблоки.',
  ),
];
List<ProductsModel> cosmeticsProducts = [
  ProductsModel(
    id: 16,
    name: 'Органические яблоки',
    image: sale1Image,
    price: '11.20',
    prevPrice: '15.40',
    discount: '-12%',
    desc: 'Сочные и сладкие яблоки.',
  ),
  ProductsModel(
    id: 17,
    name: 'Авокадо Хасс',
    image: sale2Image,
    price: '21.50',
    prevPrice: '29.40',
    discount: '-12%',
    desc: 'Сочные и сладкие яблоки.',
  ),
  ProductsModel(
    id: 18,
    name: 'Свежие помидоры',
    image: sale3Image,
    price: '11.20',
    prevPrice: '15.40',
    discount: '-12%',
    desc: 'Сочные и сладкие яблоки.',
  ),
  ProductsModel(
    id: 19,
    name: 'Авокадо Хасс',
    image: sale2Image,
    price: '21.50',
    prevPrice: '29.40',
    discount: '-5%',
    desc: 'Сочные и сладкие яблоки.',
  ),
  ProductsModel(
    id: 20,
    name: 'Свежие помидоры',
    image: sale3Image,
    price: '11.20',
    prevPrice: '13.40',
    discount: '-2%',
    desc: 'Сочные и сладкие яблоки.',
  ),
  ProductsModel(
    id: 21,
    name: 'Авокадо Хасс',
    image: sale2Image,
    price: '21.50',
    prevPrice: '29.40',
    discount: '-5%',
    desc: 'Сочные и сладкие яблоки.',
  ),
];
List<ProductsModel> hygieneProducts = [
  ProductsModel(
    id: 22,
    name: 'Органические яблоки',
    image: sale1Image,
    price: '11.20',
    prevPrice: '15.40',
    discount: '-12%',
    desc: 'Сочные и сладкие яблоки.',
  ),
  ProductsModel(
    id: 23,
    name: 'Авокадо Хасс',
    image: sale2Image,
    price: '21.50',
    prevPrice: '29.40',
    discount: '-12%',
    desc: 'Сочные и сладкие яблоки.',
  ),
  ProductsModel(
    id: 24,
    name: 'Свежие помидоры',
    image: sale3Image,
    price: '11.20',
    prevPrice: '15.40',
    discount: '-12%',
    desc: 'Сочные и сладкие яблоки.',
  ),
  ProductsModel(
    id: 25,
    name: 'Авокадо Хасс',
    image: sale2Image,
    price: '21.50',
    prevPrice: '29.40',
    discount: '-5%',
    desc: 'Сочные и сладкие яблоки.',
  ),
  ProductsModel(
    id: 26,
    name: 'Свежие помидоры',
    image: sale3Image,
    price: '11.20',
    prevPrice: '13.40',
    discount: '-2%',
    desc: 'Сочные и сладкие яблоки.',
  ),
  ProductsModel(
    id: 27,
    name: 'Авокадо Хасс',
    image: sale2Image,
    price: '21.50',
    prevPrice: '29.40',
    discount: '-5%',
    desc: 'Сочные и сладкие яблоки.',
  ),
];
List<ProductsModel> houseProducts = [
  ProductsModel(
    id: 28,
    name: 'Органические яблоки',
    image: sale1Image,
    price: '11.20',
    prevPrice: '15.40',
    discount: '-12%',
    desc: 'Сочные и сладкие яблоки.',
  ),
  ProductsModel(
    id: 29,
    name: 'Авокадо Хасс',
    image: sale2Image,
    price: '21.50',
    prevPrice: '29.40',
    discount: '-12%',
    desc: 'Сочные и сладкие яблоки.',
  ),
  ProductsModel(
    id: 30,
    name: 'Свежие помидоры',
    image: sale3Image,
    price: '11.20',
    prevPrice: '15.40',
    discount: '-12%',
    desc: 'Сочные и сладкие яблоки.',
  ),
];
List<ProductsModel> childProducts = [
  ProductsModel(
    id: 31,
    name: 'Органические яблоки',
    image: sale1Image,
    price: '11.20',
    prevPrice: '15.40',
    discount: '-12%',
    desc: 'Сочные и сладкие яблоки.',
  ),
  ProductsModel(
    id: 32,
    name: 'Авокадо Хасс',
    image: sale2Image,
    price: '21.50',
    prevPrice: '29.40',
    discount: '-12%',
    desc: 'Сочные и сладкие яблоки.',
  ),
  ProductsModel(
    id: 33,
    name: 'Свежие помидоры',
    image: sale3Image,
    price: '11.20',
    prevPrice: '15.40',
    discount: '-12%',
    desc: 'Сочные и сладкие яблоки.',
  ),
  ProductsModel(
    id: 34,
    name: 'Авокадо Хасс',
    image: sale2Image,
    price: '21.50',
    prevPrice: '29.40',
    discount: '-5%',
    desc: 'Сочные и сладкие яблоки.',
  ),
  ProductsModel(
    id: 35,
    name: 'Свежие помидоры',
    image: sale3Image,
    price: '11.20',
    prevPrice: '13.40',
    discount: '-2%',
    desc: 'Сочные и сладкие яблоки.',
  ),
  ProductsModel(
    id: 36,
    name: 'Авокадо Хасс',
    image: sale2Image,
    price: '21.50',
    prevPrice: '29.40',
    discount: '-5%',
    desc: 'Сочные и сладкие яблоки.',
  ),
];
List<ProductsModel> chanceryProducts = [
  ProductsModel(
    id: 37,
    name: 'Органические яблоки',
    image: sale1Image,
    price: '11.20',
    prevPrice: '15.40',
    discount: '-12%',
    desc: 'Сочные и сладкие яблоки.',
  ),
  ProductsModel(
    id: 38,
    name: 'Авокадо Хасс',
    image: sale2Image,
    price: '21.50',
    prevPrice: '29.40',
    discount: '-12%',
    desc: 'Сочные и сладкие яблоки.',
  ),
  ProductsModel(
    id: 39,
    name: 'Свежие помидоры',
    image: sale3Image,
    price: '11.20',
    prevPrice: '15.40',
    discount: '-12%',
    desc: 'Сочные и сладкие яблоки.',
  ),
  ProductsModel(
    id: 40,
    name: 'Авокадо Хасс',
    image: sale2Image,
    price: '21.50',
    prevPrice: '29.40',
    discount: '-5%',
    desc: 'Сочные и сладкие яблоки.',
  ),
  ProductsModel(
    id: 41,
    name: 'Свежие помидоры',
    image: sale3Image,
    price: '11.20',
    prevPrice: '13.40',
    discount: '-2%',
    desc: 'Сочные и сладкие яблоки.',
  ),
  ProductsModel(
    id: 42,
    name: 'Авокадо Хасс',
    image: sale2Image,
    price: '21.50',
    prevPrice: '29.40',
    discount: '-5%',
    desc: 'Сочные и сладкие яблоки.',
  ),
];
List<ProductsModel> zooProducts = [
  ProductsModel(
    id: 43,
    name: 'Органические яблоки',
    image: sale1Image,
    price: '11.20',
    prevPrice: '15.40',
    discount: '-12%',
    desc: 'Сочные и сладкие яблоки.',
  ),
  ProductsModel(
    id: 44,
    name: 'Авокадо Хасс',
    image: sale2Image,
    price: '21.50',
    prevPrice: '29.40',
    discount: '-12%',
    desc: 'Сочные и сладкие яблоки.',
  ),
  ProductsModel(
    id: 45,
    name: 'Свежие помидоры',
    image: sale3Image,
    price: '11.20',
    prevPrice: '15.40',
    discount: '-12%',
    desc: 'Сочные и сладкие яблоки.',
  ),
  ProductsModel(
    id: 46,
    name: 'Авокадо Хасс',
    image: sale2Image,
    price: '21.50',
    prevPrice: '29.40',
    discount: '-5%',
    desc: 'Сочные и сладкие яблоки.',
  ),
];

final List filtername = ['Овощи и фрукты', 'Бренд', 'Цена'];
// veg category
List<Map<String, dynamic>> vegCategory = [
  {
    'name': 'Овощи',
    'image': vegCat1Image,
  },
  {
    'name': 'Фрукты',
    'image': vegCat2Image,
  },
  {
    'name': 'Зелень',
    'image': vegCat3Image,
  },
  {
    'name': 'Грибы',
    'image': vegCat4Image,
  },
  {
    'name': 'Замороженное',
    'image': vegCat5Image,
  },
];
//meat category
List<Map<String, dynamic>> meatCategory = [
  {
    'name': 'Птица',
    'image': meatCat1Image,
  },
  {
    'name': 'Мясо',
    'image': meatCat2Image,
  },
  {
    'name': 'Рыба',
    'image': meatCat3Image,
  },
];
//milk category
List<Map<String, dynamic>> milkCategory = [
  {
    'name': 'Молоко',
    'image': milkCat1Image,
  },
  {
    'name': 'Сыр',
    'image': milkCat2Image,
  },
  {
    'name': 'Йогурт',
    'image': milkCat3Image,
  },
  {
    'name': 'Сметана',
    'image': milkCat4Image,
  },
  {
    'name': 'Сливки',
    'image': milkCat5Image,
  },
  {
    'name': 'Масло',
    'image': milkCat6Image,
  },
];
//costemtics
List<Map<String, dynamic>> cosmeticsCategory = [
  {
    'name': 'Молоко',
    'image': milkCat1Image,
  },
  {
    'name': 'Сыр',
    'image': milkCat2Image,
  },
  {
    'name': 'Йогурт',
    'image': milkCat3Image,
  },
];
//filter categories
List filterCatgeories = ['Овощи и фрукты', 'Овощи', 'Фрукты'];
//brands
List brands = [
  'Alma production',
  'Тукрмен алма',
  'Яшыл алма',
  'Гызыл алма',
  'Яблоко',
  'Зеленое яблоко',
];
//filter price range
List priceRange = ['до 15', '30-40', '50 и дороже'];
//images for product profile
List productProfileImage = [
  appleImage,
  appleImage,
  appleImage,
  appleImage,
  appleImage,
  appleImage,
  appleImage,
  appleImage,
];
//profile cards name
final List<Map<String, dynamic>> profileCardName = [
  {
    'name': 'Избранное',
    'icon': heartBoldIcon,
    'amount': '6 товаров',
  },
  {
    'name': 'Покупки',
    'icon': shopBoldIcon,
    'amount': '6 товаров',
  },
  {
    'name': 'Настройки',
    'icon': settingsIcon,
    'amount': null,
  },
];
//profile help tiles
final List helpTiles = [
  'Часто задаваемые вопросы',
  'Помощь и приложение',
  'Политика конфиденциальности',
];
final List settingHinTexts = [
  '+993 61 31 24 54',
  'Введите почту',
  'Дату рождения',
];
final List paymentMethod = ['Картой', 'Наличными'];
//languages
List<Map<String, dynamic>> languageList = [
  {
    'image': tmFlagImage,
    'title': 'Türkmençe',
  },
  {
    'image': ruFlagImage,
    'title': 'Русский',
  }
];
