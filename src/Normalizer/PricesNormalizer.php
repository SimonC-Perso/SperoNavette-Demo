<?php

namespace App\Normalizer;


use App\Entity\Cities;
use App\Entity\Prices;
use Symfony\Component\Serializer\Normalizer\ContextAwareNormalizerInterface;

class PricesNormalizer implements ContextAwareNormalizerInterface
{

    public function supportsNormalization(mixed $data, string $format = null, array $context = []): bool
    {
        // TODO: Implement supportsNormalization() method.
        return $data instanceof Prices;
    }

    public function normalize($price, string $format = null, array $context = [])
    {
        // TODO: Implement normalize() method.
        return [
            'id' => $price->getId(),
            'from.id' => $price->getFrom()->getId(),
            'from.label' => $price->getFrom()->getLabel(),
            'to.label' => $price->getTo()->getLabel(),
            'to.id' => $price->getTo()->getId(),
            'price' => $price->getPrice(),

        ];
    }
}