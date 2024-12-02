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
const String arrowLeftIcon = 'assets/icons/arrowLeft.svg';
const String arrowDownIcon = 'assets/icons/arrowDown.svg';
const String arrowUpIcon = 'assets/icons/arrowUp.svg';
const String searchIcon = 'assets/icons/search.svg';
const String filterIcon = 'assets/icons/filter.svg';
const String settingsIcon = 'assets/icons/settings.svg';
const String trashIcon = 'assets/icons/trash.svg';
const String loginIcon = 'assets/icons/login.svg';
const String eyeIcon = 'assets/icons/eye.svg';
const String eyeOffIcon = 'assets/icons/eyeOff.svg';

//images
const String bannerImage = 'assets/images/banner.png';
const String banner1Image = 'assets/images/banner1.png';
const String appLogoImage = 'assets/images/appLogo.png';

//animation
const String emptyAnimation = 'assets/animation/empty.json';
const String loadingAnimation = 'assets/animation/loading.json';
const String nowifiAnimation = 'assets/animation/nowifi.json';

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
const String url = 'http://216.250.13.89:8091/magaz/';

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

final List filtername = ['Овощи и фрукты', 'Бренд', 'Цена'];

//profile help tiles
final List helpTiles = [
  {
    'title': 'faq',
    'path': '',
  },
  {
    'title': 'privacyPolicy',
    'path': 'http://216.250.13.89:8091/ru/static/privacy',
  },
  {
    'title': 'rewritePersonalData',
    'path': 'http://216.250.13.89:8091/ru/static/privacy',
  },
  {
    'title': 'paymentMethods',
    'path': 'http://216.250.13.89:8091/ru/static/privacy',
  }
];
final List bonusTile = [
  'couponDiscount',
  'bonusPrograms',
];
final List settingHinTexts = [
  '+993 61 31 24 54',
  'Введите почту',
  'Дату рождения',
];
//languages
List<Map<String, dynamic>> languageList = [
  {
    'title': 'Türkmençe',
  },
  {
    'title': 'Русский',
  }
];
final List<String> genderList = ['male', 'female'];
final List<String> tabbarList = ['activeCoupon', 'sale'];
final List<String> notificationList = ['post', 'sms'];
