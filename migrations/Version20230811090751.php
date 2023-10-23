<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20230811090751 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE TABLE addresses (id INT AUTO_INCREMENT NOT NULL, city_id INT NOT NULL, street_name VARCHAR(255) NOT NULL, street_number VARCHAR(255) DEFAULT NULL, box_number VARCHAR(255) DEFAULT NULL, INDEX IDX_6FCA75168BAC62AF (city_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE airports (id INT AUTO_INCREMENT NOT NULL, addresse_id INT NOT NULL, label VARCHAR(255) NOT NULL, active TINYINT(1) NOT NULL, INDEX IDX_6E1AFD60B299877A (addresse_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE authorizations (id INT AUTO_INCREMENT NOT NULL, label VARCHAR(255) NOT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE baggage (id INT AUTO_INCREMENT NOT NULL, baggage_types INT NOT NULL, label VARCHAR(255) NOT NULL, price NUMERIC(10, 2) NOT NULL, is_active TINYINT(1) NOT NULL, INDEX IDX_917FF30AB28A0E4A (baggage_types), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE baggage_types (id INT AUTO_INCREMENT NOT NULL, label VARCHAR(255) NOT NULL, is_active TINYINT(1) NOT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE booking (id INT AUTO_INCREMENT NOT NULL, travel INT NOT NULL, driver_id INT DEFAULT NULL, user_id INT NOT NULL, booking_date DATETIME NOT NULL, passenger INT NOT NULL, departure_date DATETIME NOT NULL, arrival_date DATETIME NOT NULL, arrival_flight_number VARCHAR(15) DEFAULT NULL, departure_flight_number VARCHAR(15) DEFAULT NULL, total_price NUMERIC(10, 2) NOT NULL, booking_type_enum VARCHAR(255) NOT NULL, note VARCHAR(500) DEFAULT NULL, status VARCHAR(255) NOT NULL, discount NUMERIC(10, 2) NOT NULL, is_active TINYINT(1) NOT NULL, INDEX IDX_E00CEDDE2D0B6BCE (travel), INDEX IDX_E00CEDDEC3423909 (driver_id), INDEX IDX_E00CEDDEA76ED395 (user_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE booking_baggage (id INT AUTO_INCREMENT NOT NULL, baggage_id INT NOT NULL, booking_id INT NOT NULL, quantity NUMERIC(10, 2) NOT NULL, INDEX IDX_CBC1B62A94FD9EA4 (baggage_id), INDEX IDX_CBC1B62A3301C60 (booking_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE cities (id INT AUTO_INCREMENT NOT NULL, country_id INT NOT NULL, label VARCHAR(255) NOT NULL, zipcode VARCHAR(255) NOT NULL, INDEX IDX_D95DB16BF92F3E70 (country_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE countries (id INT AUTO_INCREMENT NOT NULL, label VARCHAR(255) NOT NULL, iso_alpha3 VARCHAR(3) DEFAULT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE enterprises (id INT AUTO_INCREMENT NOT NULL, name VARCHAR(255) NOT NULL, email VARCHAR(255) NOT NULL, phone VARCHAR(255) NOT NULL, vat VARCHAR(255) NOT NULL, date DATETIME NOT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE prices (id INT AUTO_INCREMENT NOT NULL, from_id INT NOT NULL, to_id INT NOT NULL, price NUMERIC(10, 2) NOT NULL, INDEX IDX_E4CB6D5978CED90B (from_id), INDEX IDX_E4CB6D5930354A65 (to_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE prices_histories (id INT AUTO_INCREMENT NOT NULL, price_id INT NOT NULL, begin_date DATETIME NOT NULL, end_date DATETIME DEFAULT NULL, previous_price NUMERIC(10, 2) NOT NULL, INDEX IDX_BA637DAAD614C7E7 (price_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE reports (id INT AUTO_INCREMENT NOT NULL, booking_id INT NOT NULL, user_id INT NOT NULL, text VARCHAR(500) NOT NULL, date DATETIME NOT NULL, INDEX IDX_F11FA7453301C60 (booking_id), INDEX IDX_F11FA745A76ED395 (user_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE reports_history (id INT AUTO_INCREMENT NOT NULL, report_id INT NOT NULL, text VARCHAR(500) NOT NULL, date DATETIME NOT NULL, INDEX IDX_375779FC4BD2A4C0 (report_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE roles (id INT AUTO_INCREMENT NOT NULL, label VARCHAR(255) NOT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE roles_authorizations (id INT AUTO_INCREMENT NOT NULL, role_id INT NOT NULL, authorization_id INT NOT NULL, label VARCHAR(255) NOT NULL, INDEX IDX_8876B4F9D60322AC (role_id), INDEX IDX_8876B4F92F8B0EB2 (authorization_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE travel (id INT AUTO_INCREMENT NOT NULL, starting_address INT NOT NULL, arrival_address INT NOT NULL, step_id INT DEFAULT NULL, INDEX IDX_2D0B6BCEBA92CFEC (starting_address), INDEX IDX_2D0B6BCEC685A189 (arrival_address), UNIQUE INDEX UNIQ_2D0B6BCE73B21E9C (step_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE users (id INT AUTO_INCREMENT NOT NULL, role_id INT NOT NULL, address_id INT DEFAULT NULL, last_name VARCHAR(70) NOT NULL, first_name VARCHAR(70) NOT NULL, phone VARCHAR(20) NOT NULL, email VARCHAR(100) NOT NULL, password VARCHAR(255) NOT NULL, user_status_enum VARCHAR(25) NOT NULL, active TINYINT(1) NOT NULL, UNIQUE INDEX UNIQ_1483A5E9E7927C74 (email), INDEX IDX_1483A5E9D60322AC (role_id), INDEX IDX_1483A5E9F5B7AF75 (address_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('ALTER TABLE addresses ADD CONSTRAINT FK_6FCA75168BAC62AF FOREIGN KEY (city_id) REFERENCES cities (id)');
        $this->addSql('ALTER TABLE airports ADD CONSTRAINT FK_6E1AFD60B299877A FOREIGN KEY (addresse_id) REFERENCES addresses (id)');
        $this->addSql('ALTER TABLE baggage ADD CONSTRAINT FK_917FF30AB28A0E4A FOREIGN KEY (baggage_types) REFERENCES baggage_types (id)');
        $this->addSql('ALTER TABLE booking ADD CONSTRAINT FK_E00CEDDE2D0B6BCE FOREIGN KEY (travel) REFERENCES travel (id)');
        $this->addSql('ALTER TABLE booking ADD CONSTRAINT FK_E00CEDDEC3423909 FOREIGN KEY (driver_id) REFERENCES users (id)');
        $this->addSql('ALTER TABLE booking ADD CONSTRAINT FK_E00CEDDEA76ED395 FOREIGN KEY (user_id) REFERENCES users (id)');
        $this->addSql('ALTER TABLE booking_baggage ADD CONSTRAINT FK_CBC1B62A94FD9EA4 FOREIGN KEY (baggage_id) REFERENCES baggage (id)');
        $this->addSql('ALTER TABLE booking_baggage ADD CONSTRAINT FK_CBC1B62A3301C60 FOREIGN KEY (booking_id) REFERENCES booking (id)');
        $this->addSql('ALTER TABLE cities ADD CONSTRAINT FK_D95DB16BF92F3E70 FOREIGN KEY (country_id) REFERENCES countries (id)');
        $this->addSql('ALTER TABLE prices ADD CONSTRAINT FK_E4CB6D5978CED90B FOREIGN KEY (from_id) REFERENCES cities (id)');
        $this->addSql('ALTER TABLE prices ADD CONSTRAINT FK_E4CB6D5930354A65 FOREIGN KEY (to_id) REFERENCES cities (id)');
        $this->addSql('ALTER TABLE prices_histories ADD CONSTRAINT FK_BA637DAAD614C7E7 FOREIGN KEY (price_id) REFERENCES prices (id)');
        $this->addSql('ALTER TABLE reports ADD CONSTRAINT FK_F11FA7453301C60 FOREIGN KEY (booking_id) REFERENCES booking (id)');
        $this->addSql('ALTER TABLE reports ADD CONSTRAINT FK_F11FA745A76ED395 FOREIGN KEY (user_id) REFERENCES users (id)');
        $this->addSql('ALTER TABLE reports_history ADD CONSTRAINT FK_375779FC4BD2A4C0 FOREIGN KEY (report_id) REFERENCES reports (id)');
        $this->addSql('ALTER TABLE roles_authorizations ADD CONSTRAINT FK_8876B4F9D60322AC FOREIGN KEY (role_id) REFERENCES roles (id)');
        $this->addSql('ALTER TABLE roles_authorizations ADD CONSTRAINT FK_8876B4F92F8B0EB2 FOREIGN KEY (authorization_id) REFERENCES authorizations (id)');
        $this->addSql('ALTER TABLE travel ADD CONSTRAINT FK_2D0B6BCEBA92CFEC FOREIGN KEY (starting_address) REFERENCES addresses (id)');
        $this->addSql('ALTER TABLE travel ADD CONSTRAINT FK_2D0B6BCEC685A189 FOREIGN KEY (arrival_address) REFERENCES addresses (id)');
        $this->addSql('ALTER TABLE travel ADD CONSTRAINT FK_2D0B6BCE73B21E9C FOREIGN KEY (step_id) REFERENCES travel (id)');
        $this->addSql('ALTER TABLE users ADD CONSTRAINT FK_1483A5E9D60322AC FOREIGN KEY (role_id) REFERENCES roles (id)');
        $this->addSql('ALTER TABLE users ADD CONSTRAINT FK_1483A5E9F5B7AF75 FOREIGN KEY (address_id) REFERENCES addresses (id)');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE addresses DROP FOREIGN KEY FK_6FCA75168BAC62AF');
        $this->addSql('ALTER TABLE airports DROP FOREIGN KEY FK_6E1AFD60B299877A');
        $this->addSql('ALTER TABLE baggage DROP FOREIGN KEY FK_917FF30AB28A0E4A');
        $this->addSql('ALTER TABLE booking DROP FOREIGN KEY FK_E00CEDDE2D0B6BCE');
        $this->addSql('ALTER TABLE booking DROP FOREIGN KEY FK_E00CEDDEC3423909');
        $this->addSql('ALTER TABLE booking DROP FOREIGN KEY FK_E00CEDDEA76ED395');
        $this->addSql('ALTER TABLE booking_baggage DROP FOREIGN KEY FK_CBC1B62A94FD9EA4');
        $this->addSql('ALTER TABLE booking_baggage DROP FOREIGN KEY FK_CBC1B62A3301C60');
        $this->addSql('ALTER TABLE cities DROP FOREIGN KEY FK_D95DB16BF92F3E70');
        $this->addSql('ALTER TABLE prices DROP FOREIGN KEY FK_E4CB6D5978CED90B');
        $this->addSql('ALTER TABLE prices DROP FOREIGN KEY FK_E4CB6D5930354A65');
        $this->addSql('ALTER TABLE prices_histories DROP FOREIGN KEY FK_BA637DAAD614C7E7');
        $this->addSql('ALTER TABLE reports DROP FOREIGN KEY FK_F11FA7453301C60');
        $this->addSql('ALTER TABLE reports DROP FOREIGN KEY FK_F11FA745A76ED395');
        $this->addSql('ALTER TABLE reports_history DROP FOREIGN KEY FK_375779FC4BD2A4C0');
        $this->addSql('ALTER TABLE roles_authorizations DROP FOREIGN KEY FK_8876B4F9D60322AC');
        $this->addSql('ALTER TABLE roles_authorizations DROP FOREIGN KEY FK_8876B4F92F8B0EB2');
        $this->addSql('ALTER TABLE travel DROP FOREIGN KEY FK_2D0B6BCEBA92CFEC');
        $this->addSql('ALTER TABLE travel DROP FOREIGN KEY FK_2D0B6BCEC685A189');
        $this->addSql('ALTER TABLE travel DROP FOREIGN KEY FK_2D0B6BCE73B21E9C');
        $this->addSql('ALTER TABLE users DROP FOREIGN KEY FK_1483A5E9D60322AC');
        $this->addSql('ALTER TABLE users DROP FOREIGN KEY FK_1483A5E9F5B7AF75');
        $this->addSql('DROP TABLE addresses');
        $this->addSql('DROP TABLE airports');
        $this->addSql('DROP TABLE authorizations');
        $this->addSql('DROP TABLE baggage');
        $this->addSql('DROP TABLE baggage_types');
        $this->addSql('DROP TABLE booking');
        $this->addSql('DROP TABLE booking_baggage');
        $this->addSql('DROP TABLE cities');
        $this->addSql('DROP TABLE countries');
        $this->addSql('DROP TABLE enterprises');
        $this->addSql('DROP TABLE prices');
        $this->addSql('DROP TABLE prices_histories');
        $this->addSql('DROP TABLE reports');
        $this->addSql('DROP TABLE reports_history');
        $this->addSql('DROP TABLE roles');
        $this->addSql('DROP TABLE roles_authorizations');
        $this->addSql('DROP TABLE travel');
        $this->addSql('DROP TABLE users');
    }
}
