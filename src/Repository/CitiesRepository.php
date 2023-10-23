<?php

namespace App\Repository;

use App\Entity\Cities;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<Cities>
 *
 * @method Cities|null find($id, $lockMode = null, $lockVersion = null)
 * @method Cities|null findOneBy(array $criteria, array $orderBy = null)
 * @method Cities[]    findAll()
 * @method Cities[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class CitiesRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Cities::class);
    }

    public function save(Cities $entity, bool $flush = false): void
    {
        $this->getEntityManager()->persist($entity);

        if ($flush) {
            $this->getEntityManager()->flush();
        }
    }

    public function remove(Cities $entity, bool $flush = false): void
    {
        $this->getEntityManager()->remove($entity);

        if ($flush) {
            $this->getEntityManager()->flush();
        }
    }

    /**
     * Recherche limité a 6
     * @param $codePostal
     * @return array
     */
    public function findByCities($city): array
    {
        return $this->createQueryBuilder('c')
            ->select('c')
            ->andWhere("c.label LIKE CONCAT('%', :label, '%')")
            ->setParameter('label', $city)
            ->getQuery()
            ->getResult();
    }

    public function findCitiesByZipLikeAndCountry($zip, $country): array
    {
        return $this->createQueryBuilder('c')
            ->select('c')
            ->andWhere("c.zipcode LIKE CONCAT(:zipcode, '%') and c.country =:country")
            ->setParameter('zipcode', $zip)->setParameter("country", $country)
            ->getQuery()
            ->getResult();
    }

    public function findCitiesByZipLike($zip): array
    {
        return $this->createQueryBuilder('c')
            ->select('c')
            ->andWhere("c.zipcode LIKE CONCAT(:zipcode, '%')")
            ->setParameter('zipcode', $zip)
            ->getQuery()
            ->getResult();
    }

    /**Recherche limité à 6
     * @param $localite
     * @return array
     */
    public function findByLocalite($localite): array
    {
        return $this->createQueryBuilder('cities')
            ->select('cities.label, cities.zipcode')
            ->andWhere("cities.label LIKE CONCAT('%', :localite, '%')")
            ->setParameter('localite', $localite)
            ->setMaxResults(6)
            ->getQuery()
            ->getResult();
    }

//    /**
//     * @return Cities[] Returns an array of Cities objects
//     */
//    public function findByExampleField($value): array
//    {
//        return $this->createQueryBuilder('c')
//            ->andWhere('c.exampleField = :val')
//            ->setParameter('val', $value)
//            ->orderBy('c.id', 'ASC')
//            ->setMaxResults(10)
//            ->getQuery()
//            ->getResult()
//        ;
//    }

//    public function findOneBySomeField($value): ?Cities
//    {
//        return $this->createQueryBuilder('c')
//            ->andWhere('c.exampleField = :val')
//            ->setParameter('val', $value)
//            ->getQuery()
//            ->getOneOrNullResult()
//        ;
//    }
}
