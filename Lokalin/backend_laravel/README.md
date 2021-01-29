
```shell
# install composer-dependency
$ composer install
# install npm package
$ npm install
# build dev 
$ npm run dev
```

Sebelum menjalanlan program pastikan sudah membuat file .env

```shell
# create copy of .env
cp .env.example .env
# create laravel key
$ php artisan key:generate
# laravel migrate
$ php artisan migrate
```

```shell
# tambah midtrans key pada .env
MIDTRANS_SERVER_KEY="midtrans-server-key-mu"
MIDTRANS_CLIENT_KEY="midtrans-client-key-mu"
MIDTRANS_IS_PRODUCTION=false
MIDTRANS_IS_SANITIZED=true
MIDTRANS_IS_3DS=true

```
