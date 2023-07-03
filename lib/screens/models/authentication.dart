class Autentikasi {
  String email;
  String password;
  String nama;
  int saldo;
  String status;

  Autentikasi(
      {this.email, this.password, this.nama, this.saldo, this.status});
}

List<Autentikasi> autentikasi = [
  Autentikasi(
      email: 'demo@nearbymarket.com',
      password: 'demo',
      status: 'PENGGUNA',
      saldo: 950000,
      nama: 'Achmad Room Fitrianto'),
  Autentikasi(
      email: 'guest@nearbymarket.com',
      password: 'guest',
      status: 'PENGGUNA',
      saldo: 100000,
      nama: 'Guest'),
      Autentikasi(
      email: 'demopenjual@nearbymarket.com',
      password: 'demo',
      status: 'PEDAGANG',
      saldo: 1500000,
      nama: 'Achmad Room Fitrianto'),
  Autentikasi(
      email: 'guestpenjual@nearbymarket.com',
      password: 'guest',
      status: 'PEDAGANG',
      saldo: 1000000,
      nama: 'Guest'),
];
 