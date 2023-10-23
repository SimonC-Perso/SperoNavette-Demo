<?php

namespace App\Normalizer;

use App\Entity\Airports;
use Symfony\Component\Serializer\Normalizer\ContextAwareNormalizerInterface;

class AirportNormalizer implements ContextAwareNormalizerInterface
{
    public function supportsNormalization(mixed $data, string $format = null, array $context = []): bool
    {
        // TODO: Implement supportsNormalization() method.
        return $data instanceof Airports;
    }

    public function normalize($Airports, string $format = null, array $context = []): array
    {
        // TODO: Implement normalize() method.
        return [
            'id' => $Airports->getId(),
            'label' => $Airports->getLabel(),
            'active' => $Airports->getActive(),
            'zipcode' => $Airports->getAddresse()->getCity()->getZipcode(),
        ];
    }
}