<?php

namespace App\Services;

use App\Entity\Users;
use Doctrine\ORM\EntityManagerInterface;

class UsersService
{
    private $entityManager;
    public function __construct(EntityManagerInterface $entityManager)
    {
        $this->entityManager = $entityManager;
    }


    /**
     * Retourne un Users en fonction de l'id
     * @param int $id
     * @return Users|null
     */
    public function findUserById(int $id): ?Users
    {
        return $this->entityManager->getRepository(Users::class)->find($id);
    }

    /**
     * Crypte le mot de passe
     * @param string $password
     * @return string
     */
    public function cryptPassword(string $password): string{
        return password_hash($password,PASSWORD_BCRYPT);
    }

    /**
     * Retourne un Users en fonction de l'email
     * @param string $email
     * @return Users|null
     */
    public function findByEmail(string $email): ?Users{
        return $this->entityManager->getRepository(Users::class)->findByEmail($email);
    }
}