<?php

namespace App\Normalizer;


use App\Entity\Addresses;
use Symfony\Component\Serializer\Normalizer\ContextAwareNormalizerInterface;

class AddressesNormalizer implements ContextAwareNormalizerInterface
{

    public function supportsNormalization(mixed $data, string $format = null, array $context = []): bool
    {
        // TODO: Implement supportsNormalization() method.
        return $data instanceof Addresses;
    }

    public function normalize($addresse, string $format = null, array $context = [])
    {
        // TODO: Implement normalize() method.
        return [
            'id' => $addresse->getId(),
            'street_name' => $addresse->getStreetName(),
            'street_number' => $addresse->getStreetNumber(),
            'box_number' => $addresse->getBoxNumber(),
            'city' => $addresse->getCity(),
            'airports' => $addresse->getAirports(),
        ];
    }
}