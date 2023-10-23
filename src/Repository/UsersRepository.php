<?php

namespace App\Repository;

use App\Entity\Users;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<Users>
 *
 * @method Users|null find($id, $lockMode = null, $lockVersion = null)
 * @method Users|null findOneBy(array $criteria, array $orderBy = null)
 * @method Users[]    findAll()
 * @method Users[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class UsersRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Users::class);
    }

    public function save(Users $entity, bool $flush = false): void
    {
        $this->getEntityManager()->persist($entity);

        if ($flush) {
            $this->getEntityManager()->flush();
        }
    }

    public function remove(Users $entity, bool $flush = false): void
    {
        $this->getEntityManager()->remove($entity);

        if ($flush) {
            $this->getEntityManager()->flush();
        }
    }

    /**
     * @param $email
     * @return Users|null
     * @throws \Doctrine\ORM\NonUniqueResultException
     */
    public function findByEmail($email): ?Users
    {

        return $this->createQueryBuilder('U')
            ->andWhere('U.email = :email')
            ->setParameter('email', $email)
            ->getQuery()
            ->getOneOrNullResult();

    }

    /**
     * @return \Doctrine\ORM\Query Returns an array of Users objects
     */
    public function findByPagination(): \Doctrine\ORM\Query
    {
        return $this->createQueryBuilder('u')
            ->andWhere('u.active = true')
            ->orderBy('u.id', 'DESC')
            ->getQuery();
    }

    /**
     * @return Users[] Returns an array of Users objects
     */
    public function findBySearch($search): array
    {
        return $this->createQueryBuilder('u')
            ->setParameter('search', '%' . $search . '%')
            ->andWhere('u.first_name LIKE :search')->orWhere('u.last_name LIKE :search')->orWhere('u.email LIKE :search')->orWhere('u.phone LIKE :search')->orWhere('u.statusUser LIKE :search')
            ->getQuery()
            ->getResult();
    }

//    /**
//     * @return Users[] Returns an array of Users objects
//     */
//    public function findByExampleField($value): array
//    {
//        return $this->createQueryBuilder('u')
//            ->andWhere('u.exampleField = :val')
//            ->setParameter('val', $value)
//            ->orderBy('u.id', 'ASC')
//            ->setMaxResults(10)
//            ->getQuery()
//            ->getResult()
//        ;
//    }

//    public function findOneBySomeField($value): ?Users
//    {
//        return $this->createQueryBuilder('u')
//            ->andWhere('u.exampleField = :val')
//            ->setParameter('val', $value)
//            ->getQuery()
//            ->getOneOrNullResult()
//        ;
//    }
}
