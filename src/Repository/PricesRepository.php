<?php

namespace App\Repository;

use App\Entity\Cities;
use App\Entity\Prices;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\NonUniqueResultException;
use Doctrine\ORM\Query\Expr\Join;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<Prices>
 *
 * @method Prices|null find($id, $lockMode = null, $lockVersion = null)
 * @method Prices|null findOneBy(array $criteria, array $orderBy = null)
 * @method Prices[]    findAll()
 * @method Prices[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class PricesRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Prices::class);
    }

    public function save(Prices $entity, bool $flush = false): void
    {
        $this->getEntityManager()->persist($entity);

        if ($flush) {
            $this->getEntityManager()->flush();
        }
    }

    public function remove(Prices $entity, bool $flush = false): void
    {
        $this->getEntityManager()->remove($entity);

        if ($flush) {
            $this->getEntityManager()->flush();
        }
    }

//    /**
//     * @return Prices[] Returns an array of Prices objects
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

    /**
     * @throws NonUniqueResultException
     */
    public function findByFormIdToId($from, $to): ?Prices
    {
        return $this->createQueryBuilder('p')
            ->andWhere('p.from =:from and p.to =:to')
            ->setParameter('from', $from)
            ->setParameter('to', $to)
            ->getQuery()
            ->getOneOrNullResult();
    }

    public function findByPagination($search = ''): \Doctrine\ORM\Query
    {
        $form = $this->createQueryBuilder('p');
        $form->innerJoin('p.from', 'c', 'WITH', 'c.id = p.from')
            ->innerJoin('p.to', 'ct', 'WITH', 'ct.id = p.to')
            ->orderBy('ct.label', 'DESC')
            ->orderBy(' c.label', 'ASC');
        if ($search != '') {
            $form->where('lower(c.label) like :search')->orWhere('lower(ct.label) like :search')
                ->setParameter('search', strtolower('%' . $search . '%'));
        }
        return $form->getQuery();
    }


}
