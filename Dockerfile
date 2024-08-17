#ติดตั้ง PHP 8.2 พร้อม Apache
FROM php:8.2-apache

#เซ็ตพื้นที่ทำงาน
WORKDIR /www

#เปิดการใช้งาน .httaccess
RUN a2enmod rewrite

# ติดตั้ง dependencies ที่จำเป็น
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libpq-dev \
    libzip-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd \
    && docker-php-ext-install mysqli\
    && docker-php-ext-install pdo_mysql\
    && docker-php-ext-install pdo_pgsql \
    && docker-php-ext-install zip

# ทำการลบ cache ของ apt-get เพื่อลดขนาดของ image
RUN apt-get clean && rm -rf /var/lib/apt/lists/*


# คัดลอกไฟล์การตั้งค่า httpd.conf หรือ apache2.conf จากเครื่องของคุณไปยัง container
# COPY ./apache/httpd.conf /usr/local/apache2/conf/httpd.conf

# COPY ไฟล์ทั้งหมดไป 
# COPY . /var/www/html