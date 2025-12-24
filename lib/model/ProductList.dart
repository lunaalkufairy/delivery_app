import 'package:flutter/material.dart';
import 'package:delivery_app/model/CartModel.dart';
import 'package:delivery_app/model/ProductOrder.dart';

import 'package:delivery_app/model/favoraitesProducts.dart';
import 'package:delivery_app/model/productsmodel.dart';

List<FavoriteProduct> favoraites = [];
//==============================================
List<CartModel> PublicListProductsCart = [];
List<ProductsModel> PublicListProductsFavorite = [];
List<Object> PublicListProductsOrder = [];
List<Object> PublicListProductsHistoryCancel = [];
List<ProductsModel> PublicListProductsCartGroupOrder = [];
List<List> allOrders = [
  PublicListProductsOrder,
  PublicListProductsCartGroupOrder,
];

// إنشاء ValueNotifier لقائمة المفضلات
ValueNotifier<List<ProductsModel>> PublicListProductsFavoriteNotifier =
    ValueNotifier(PublicListProductsFavorite);

// ===========================================================

Map<String, List<String>> citiesByState = {
  'Damascus': [
    'Old-Damascus',
    'Barzeh',
    'Mazzeh',
    'Kafr-Sousa',
    'Bab-Touma',
    'Al-Midan',
    'Al-Shaghour',
  ],
  'Rif-Dimashq': [
    'Douma',
    'Harasta',
    'Jaramana',
    'Qatana',
    'Daraya',
    'Zabadani',
    'Sa’sa’',
    'Al-Tall',
  ],
  'Aleppo': [
    'Manbij',
    'Azaz',
    'Afrin',
    'Jarabulus',
    'Al-Bab',
    'Khanaser',
    'Atareb',
    'Nubl',
    'Al-Zahraa',
  ],
  'Homs': [
    'Al-Rastan',
    'Al-Qusayr',
    'Tadmur',
    'Talbiseh',
    'Al-Houla',
    'Zara',
    'Al-Waer',
    'Fairouzeh',
  ],
  'Hama': [
    'Masyaf',
    'Salamiyah',
    'Suqaylabiyah',
    'Kafr-Zita',
    'Tremseh',
    'Qamhana',
    'Khirbat-al-Qutna',
  ],
  'Latakia': [
    'Jableh',
    'Qardaha',
    'Kasab',
    'Slunfeh',
    'Burj-Islam',
    'Ain-al-Bayda',
    'Mashqita',
  ],
  'Tartus': [
    'Baniyas',
    'Safita',
    'Duraykish',
    'Sheikh-Badr',
    'Qadmous',
    'Al-Annazah',
    'Khirbet-al-Faras',
  ],
  'Daraa': [
    'Bosra',
    'Tafas',
    'Inkhil',
    'Nawa',
    'Jasim',
    'Al-Hirak',
    'Al-Sanamayn',
    'Dael',
  ],
  'As-Suwayda': [
    'Shahba',
    'Salkhad',
    'Qanawat',
    'Ariqa',
    'Malah',
    'Raha',
    'Al-Mazraa',
    'Mushannaf',
  ],
  'Deir-ez-Zor': [
    'Al-Mayadin',
    'Abu-Kamal',
    'Al-Busayrah',
    'Al-Hawayij',
    'Al-Kashma',
    'Ashara',
    'Hajin',
  ],
  'Hasakah': [
    'Qamishli',
    'Amuda',
    'Ras-al-Ayn',
    'Al-Malikiyah',
    'Tal-Tamer',
    'Al-Yaarubiyah',
    'Shaddadi',
  ],
  'Raqqa': [
    'Tabqa',
    'Ain-Issa',
    'Suluk',
    'Sabkha',
    'Al-Karama',
    'Mazraat-Tishrin',
    'Al-Jurniyah',
  ],
  'Idlib': [
    'Maarat-al-Numan',
    'Ariha',
    'Saraqib',
    'Khan-Shaykhun',
    'Binnish',
    'Jisr-al-Shughur',
    'Kafr-Nabl',
  ],
  'Quneitra': [
    'Khan-Arnabah',
    'Baath-City',
    'Jaba',
    'Tranja',
    'Al-Hamidiyah',
    'Bir-Ajam',
    'Hader',
  ],
};
