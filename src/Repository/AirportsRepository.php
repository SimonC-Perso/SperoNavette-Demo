<?php

namespace App\Repository;

use App\Entity\Airports;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<Airports>
 *
 * @method Airports|null find($id, $lockMode = null, $lockVersion = null)
 * @method Airports|null findOneBy(array $criteria, array $orderBy = null)
 * @method Airports[]    findAll()
 * @method Airports[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class AirportsRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Airports::class);
    }

    public function save(Airports $entity, bool $flush = false): void
    {
        $this->getEntityManager()->persist($entity);

        if ($flush) {
            $this->getEntityManager()->flush();
        }
    }

    public function remove(Airports $entity, bool $flush = false): void
    {
        $this->getEntityManager()->remove($entity);

        if ($flush) {
            $this->getEntityManager()->flush();
        }
    }

    /**
     * Recherche limité à 6
     * @param $label
     * @return array
     */
    public function findByLabel($label): array
    {
        return $this->createQueryBuilder('airport')
            ->select('airport.label')
            ->andWhere("airport.label LIKE CONCAT('%', :street, '%')")
            ->setParameter('label', $label)
            ->setMaxResults(6)
            ->getQuery()
            ->getResult();
    }

//    public function findOneBySomeField($value): ?Airports
//    {
//        return $this->createQueryBuilder('a')
//            ->andWhere('a.exampleField = :val')
//            ->setParameter('val', $value)
//            ->getQuery()
//            ->getOneOrNullResult()
//        ;
//    }
}
