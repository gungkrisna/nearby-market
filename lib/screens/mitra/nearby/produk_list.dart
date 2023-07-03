class Produk {
  int idproduk;
  String gambar;
  String nama;
  String kategori;
  int harga;

  Produk({
    this.idproduk,
    this.gambar,
    this.kategori,
    this.nama,
    this.harga,
  });
}

List<Produk> wholeProduct = [
  Produk(
    idproduk: 1,
    kategori: 'Daging Ayam',
    gambar:
        'https://s3-ap-southeast-1.amazonaws.com/etanee-images/product/A1103200.jpg',
    nama: '1Kg Dada Ayam Frozen [Tanpa Tulang]',
    harga: 57000,
  ),
  Produk(
    idproduk: 8,
    kategori: 'Aneka Ikan',
    gambar:
        'https://etanee-images.s3-ap-southeast-1.amazonaws.com/ikan/Ikan+Patin+500px.jpg',
    nama: 'Patin 600gr',
    harga: 26000,
  ),
  Produk(
    idproduk: 9,
    kategori: 'Sembako',
    gambar:
        'https://etanee-images.s3-ap-southeast-1.amazonaws.com/product/sembako/gula+(1).jpg',
    nama: 'Gula Pasir 1kg',
    harga: 16500,
  ),
  Produk(
    idproduk: 15,
    kategori: 'Sayuran',
    gambar:
        'https://etanee-images.s3-ap-southeast-1.amazonaws.com/product/sayur/Brokoli.jpg',
    nama: 'Brokoli 500gr',
    harga: 1900,
  ),
  Produk(
    idproduk: 15,
    kategori: 'Aneka Bumbu',
    gambar:
        'https://etanee-images.s3-ap-southeast-1.amazonaws.com/sayur/Cabai+Rawit+Merah.jpg',
    nama: 'Cabai Rawit Merah 250gr',
    harga: 13000,
  ),
  Produk(
    idproduk: 15,
    kategori: 'Siap Santap',
    gambar:
        'https://i2.wp.com/resepkoki.id/wp-content/uploads/2017/11/Resep-Ayam-geprek-jogja.jpg',
    nama: 'Ayam Geprek',
    harga: 20000,
  ),
  Produk(
    idproduk: 3,
    kategori: 'Daging Ayam',
    gambar:
        'https://karya-pangan.com/wp-content/uploads/2015/04/Whole-Chicken167615-Copy.jpg',
    nama: '1 Ekor Ayam Utuh [0.6 - 0.7 Kg]',
    harga: 57000,
  ),
  Produk(
    idproduk: 4,
    kategori: 'Daging Ayam',
    gambar:
        'https://cdn11.bigcommerce.com/s-7tefearjt6/images/stencil/1280x1280/products/219/512/Whole-chicken-cut-up-bone-in__10443.1586276555.jpg?c=2&imbypass=on',
    nama: 'Ayam Potong [0.8 - 0.9 Kg 10 Potong]',
    harga: 35000,
  ),
  Produk(
    idproduk: 5,
    kategori: 'Daging Sapi',
    gambar:
        'https://etanee-images.s3-ap-southeast-1.amazonaws.com/product/Daging+Sapi+Satuan/shabu+shortrib+2.jpg',
    nama: 'Daging Sapi Shabu Shortplate 500gr',
    harga: 58500,
  ),
  Produk(
    idproduk: 6,
    kategori: 'Daging Sapi',
    gambar:
        'https://etanee-images.s3-ap-southeast-1.amazonaws.com/product/Daging+Sapi+Satuan/Daging+Semur+500gr.jpg',
    nama: 'Daging Sapi Frozen Potongan Semur Kemasan 500 gr',
    harga: 59000,
  ),
  Produk(
    idproduk: 7,
    kategori: 'Aneka Ikan',
    gambar:
        'https://etanee-images.s3-ap-southeast-1.amazonaws.com/product/Ikan/Ikan+Gurame+500px.jpg',
    nama: 'Gurame 400gr',
    harga: 31000,
  ),
  Produk(
    idproduk: 10,
    kategori: 'Sembako',
    gambar:
        'https://ecs7.tokopedia.net/img/cache/700/product-1/2019/6/1/6134168/6134168_443e903c-497b-47e2-8cda-bbedaef4faf8_554_554.jpg',
    nama: 'Beras Bulog 5kg',
    harga: 60000,
  ),
  Produk(
    idproduk: 2,
    kategori: 'Daging Ayam',
    gambar:
        'https://s3-ap-southeast-1.amazonaws.com/etanee-images/product/A1102200.jpg',
    nama: '1Kg Paha Ayam Frozen [Tanpa Tulang]',
    harga: 58000,
  ),
  Produk(
    idproduk: 11,
    kategori: 'Buah',
    gambar:
        'https://etanee-images.s3-ap-southeast-1.amazonaws.com/product/buah/Pisang+Ambon.jpeg',
    nama: 'Pisang Ambon',
    harga: 20000,
  ),
  Produk(
    idproduk: 12,
    kategori: 'Buah',
    gambar:
        'https://etanee-images.s3-ap-southeast-1.amazonaws.com/product/buah/apel+merah+(1).png',
    nama: 'Apel Merah',
    harga: 16000,
  ),
  Produk(
    idproduk: 13,
    kategori: 'Sayuran',
    gambar:
        'https://etanee-images.s3-ap-southeast-1.amazonaws.com/product/sayur/Kacang+Panjang.jpg',
    nama: 'Kacang Panjang 250gr',
    harga: 7500,
  ),
  Produk(
    idproduk: 14,
    kategori: 'Sayuran',
    gambar:
        'https://etanee-images.s3-ap-southeast-1.amazonaws.com/sayur/Sawi+Putih.jpg',
    nama: 'Sawi Putih 250gr',
    harga: 5500,
  ),
  Produk(
    idproduk: 15,
    kategori: 'Sayuran',
    gambar:
        'https://etanee-images.s3-ap-southeast-1.amazonaws.com/product/sayur/Brokoli.jpg',
    nama: 'Brokoli 500gr',
    harga: 1900,
  ),
  Produk(
    idproduk: 15,
    kategori: 'Aneka Bumbu',
    gambar:
        'https://etanee-images.s3-ap-southeast-1.amazonaws.com/sayur/Cabai+Rawit+Merah.jpg',
    nama: 'Cabai Rawit Merah 250gr',
    harga: 13000,
  ),
  Produk(
    idproduk: 15,
    kategori: 'Siap Santap',
    gambar:
        'https://i2.wp.com/resepkoki.id/wp-content/uploads/2017/11/Resep-Ayam-geprek-jogja.jpg',
    nama: 'Ayam Geprek',
    harga: 20000,
  ),
];
