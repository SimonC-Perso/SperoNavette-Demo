<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20230917150823 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE booking CHANGE user_id user_id INT DEFAULT NULL, CHANGE discount discount NUMERIC(10, 2) DEFAULT NULL');
        $this->addSql('ALTER TABLE cities CHANGE country_id country_id INT DEFAULT NULL');
        $this->addSql('ALTER TABLE users ADD reset_password TINYINT(1) NOT NULL');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE booking CHANGE user_id user_id INT NOT NULL, CHANGE discount discount NUMERIC(10, 2) NOT NULL');
        $this->addSql('ALTER TABLE cities CHANGE country_id country_id INT NOT NULL');
        $this->addSql('ALTER TABLE users DROP reset_password');
    }
}
