<?php

namespace App\Normalizer;


use App\Entity\Cities;
use Symfony\Component\Serializer\Normalizer\ContextAwareNormalizerInterface;

class CitiesSelect2Normalizer implements ContextAwareNormalizerInterface
{

    public function supportsNormalization(mixed $data, string $format = null, array $context = []): bool
    {
        // TODO: Implement supportsNormalization() method.
        return $data instanceof Cities;
    }

    public function normalize($city, string $format = null, array $context = [])
    {
        // TODO: Implement normalize() method.
        return [
            'id' => $city->getId(),
            'text' => '(' . $city->getZipCode() . ") - " . $city->getLabel(),
            'label' => $city->getLabel(),
            'zipcode' => $city->getZipCode(),
            'zipcodeId' => $city->getId(),
            'country' => $city->getCountry()->getId()
        ];
    }
}