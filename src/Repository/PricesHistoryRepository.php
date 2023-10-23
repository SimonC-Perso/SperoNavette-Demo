<?php

namespace App\Repository;

use App\Entity\PricesHistories;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<PricesHistories>
 *
 * @method PricesHistories|null find($id, $lockMode = null, $lockVersion = null)
 * @method PricesHistories|null findOneBy(array $criteria, array $orderBy = null)
 * @method PricesHistories[]    findAll()
 * @method PricesHistories[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class PricesHistoryRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, PricesHistories::class);
    }

    public function save(PricesHistories $entity, bool $flush = false): void
    {
        $this->getEntityManager()->persist($entity);

        if ($flush) {
            $this->getEntityManager()->flush();
        }
    }

    public function remove(PricesHistories $entity, bool $flush = false): void
    {
        $this->getEntityManager()->remove($entity);

        if ($flush) {
            $this->getEntityManager()->flush();
        }
    }

//    /**
//     * @return PricesHistory[] Returns an array of PricesHistory objects
//     */
//    public function findByExampleField($value): array
//    {
//        return $this->createQueryBuilder('p')
//            ->andWhere('p.exampleField = :val')
//            ->setParameter('val', $value)
//            ->orderBy('p.id', 'ASC')
//            ->setMaxResults(10)
//            ->getQuery()
//            ->getResult()
//        ;
//    }

    public function findHistoriesByPriceId($value): array
    {
        return $this->createQueryBuilder('p')
            ->andWhere('p.price = :val')
            ->setParameter('val', $value)
            ->getQuery()
            ->getResult();
    }
//    public function findOneBySomeField($value): ?PricesHistory
//    {
//        return $this->createQueryBuilder('p')
//            ->andWhere('p.exampleField = :val')
//            ->setParameter('val', $value)
//            ->getQuery()
//            ->getOneOrNullResult()
//        ;
//    }
}
