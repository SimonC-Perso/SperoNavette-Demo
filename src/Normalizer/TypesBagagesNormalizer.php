<?php

namespace App\Normalizer;

use App\Entity\BaggageTypes;
use Symfony\Component\Serializer\Normalizer\ContextAwareNormalizerInterface;

class TypesBagagesNormalizer implements ContextAwareNormalizerInterface
{

    public function supportsNormalization(mixed $data, string $format = null, array $context = []): bool
    {
        // TODO: Implement supportsNormalization() method.
        return $data instanceof BaggageTypes;
    }

    public function normalize($typesBaggage, string $format = null, array $context = [])
    {
        // TODO: Implement normalize() method.
        return [
            'id' => $typesBaggage->getId(),
            'label' => $typesBaggage->getLabel(),
            'active' => $typesBaggage->isActive()
        ];
    }
}