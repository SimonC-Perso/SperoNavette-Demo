<?php

namespace App\Normalizer;

use App\Entity\Users;
use Symfony\Component\Serializer\Normalizer\NormalizerInterface;

class UsersAdminNormalizer implements NormalizerInterface
{

    /**
     * @inheritDoc
     */
    public function normalize(mixed $object, string $format = null, array $context = []): float|int|bool|\ArrayObject|array|string|null
    {
        return [
            'id' => $object->getId(),
            'lastname' => $object->getLastName(),
            'firstname' => $object->getFirstName(),
            'mail' => $object->getEmail(),
            'phone' => $object->getPhone(),
            'role' => strtoupper($object->getRole()->getLabel()),
            'isActive' => $object->isActive(),
            'status' => $object->getUserStatus(),
            'address' => $object->getAddress()
        ];
    }

    /**
     * @inheritDoc
     */
    public function supportsNormalization(mixed $data, string $format = null): bool
    {
        return $data instanceof Users;
    }
}