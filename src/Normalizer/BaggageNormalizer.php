<?php


namespace App\Normalizer;

use App\Entity\Baggage;
use Symfony\Component\Serializer\Normalizer\ContextAwareNormalizerInterface as ContextAwareNormalizerInterfaceAlias;

class BaggageNormalizer implements ContextAwareNormalizerInterfaceAlias
{

    public function supportsNormalization(mixed $data, string $format = null, array $context = []): bool
    {
        // TODO: Implement supportsNormalization() method.
        return $data instanceof Baggage;
    }

    public function normalize($Baggage, string $format = null, array $context = [])
    {
        // TODO: Implement normalize() method.
        return [
            'id' => $Baggage->getId(),
            'baggage_types' => $Baggage->getBaggageTypes()->getLabel(),
            'baggage_types_id' => $Baggage->getBaggageTypes()->getId(),
            'label' => $Baggage->getLabel(),
            'price' => $Baggage->getPrice(),
            'is_active' => $Baggage->isActive()
        ];
    }
}