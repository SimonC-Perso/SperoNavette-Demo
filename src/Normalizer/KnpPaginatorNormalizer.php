<?php

namespace App\Normalizer;


use App\Entity\Cities;
use Knp\Component\Pager\Pagination\AbstractPagination;
use Symfony\Component\Serializer\Normalizer\ContextAwareNormalizerInterface;

class KnpPaginatorNormalizer implements ContextAwareNormalizerInterface
{

    public function supportsNormalization(mixed $data, string $format = null, array $context = []): bool
    {
        // TODO: Implement supportsNormalization() method.
        return $data instanceof AbstractPagination;
    }

    public function normalize($page, string $format = null, array $context = [])
    {
        // TODO: Implement normalize() method.
        return [
            'id' => $city->getId(),
            'label' => $city->getLabel(),
            'zipcode' => $city->getZipCode(),
            'country' => $city->getCountry()->getId()
        ];
    }
}