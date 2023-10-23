<?php

namespace App\DataFixtures;

use App\Entity\Addresses;
use App\Entity\Cities;
use App\Entity\Countries;
use App\Entity\Enterprises;
use App\Entity\Enum\EnumCivilite;
use App\Entity\Enum\EnumGender;
use App\Entity\Enum\EnumUserStatus;
use App\Entity\Roles;
use App\Entity\Users;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\DBAL\Types\Type;
use Doctrine\Persistence\ObjectManager;

class TestDataFixtures extends Fixture
{
    public function load(ObjectManager $manager): void
    {
        $entreprise = new Enterprises();
        $entreprise->setName("Spero Navette");
        $entreprise->setEmail("info@spero-navette.be");
        $entreprise->setPhone("+32 490 197 914");
        $entreprise->setVat("");
        $entreprise->setDate(new \DateTime("now"));
        $manager->persist($entreprise);
        $role = new Roles();
        $role->setLabel("Admin");
        $role2 = new Roles();
        $role2->setLabel("User");
        $role3 = new Roles();
        $role3->setLabel("Employee");
        $role4 = new Roles();
        $role4->setLabel("Coordinator");
        $manager->persist($role);
        $manager->persist($role2);
        $manager->persist($role3);
        $manager->persist($role4);
        $manager->flush();
    }
}
