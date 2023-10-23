<?php

namespace App\Repository;

use App\Entity\Baggage;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<Baggage>
 *
 * @method Baggage|null find($id, $lockMode = null, $lockVersion = null)
 * @method Baggage|null findOneBy(array $criteria, array $orderBy = null)
 * @method Baggage[]    findAll()
 * @method Baggage[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class BaggagesRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Baggage::class);
    }

    public function save(Baggage $entity, bool $flush = false): void
    {
        $this->getEntityManager()->persist($entity);

        if ($flush) {
            $this->getEntityManager()->flush();
        }
    }

    public function remove(Baggage $entity, bool $flush = false): void
    {
        $this->getEntityManager()->remove($entity);

        if ($flush) {
            $this->getEntityManager()->flush();
        }
    }

    /**
     * @return Baggage[] Returns an array of Baggages objects
     */
    public function findByFilter($filter): array
    {
        return $this->createQueryBuilder('baggage')
            ->andWhere('baggage.baggageTypes IN (:val)')
            ->setParameter('val', $filter)
            ->orderBy('baggage.id', 'ASC')
            ->getQuery()
            ->getResult();
    }

//    public function findOneBySomeField($value): ?Baggages
//    {
//        return $this->createQueryBuilder('b')
//            ->andWhere('b.exampleField = :val')
//            ->setParameter('val', $value)
//            ->getQuery()
//            ->getOneOrNullResult()
//        ;
//    }
}
