<?php

namespace App\Normalizer;

use App\Entity\Users;
use Symfony\Component\Serializer\Normalizer\ContextAwareNormalizerInterface;
use Symfony\Component\Serializer\Normalizer\NormalizerInterface;

class UsersNormalizer implements NormalizerInterface
{

    public function supportsNormalization(mixed $data, string $format = null, array $context = []): bool
    {
        // TODO: Implement supportsNormalization() method.
        return $data instanceof Users;
    }

    /**
     * @param $user
     * @param string|null $format
     * @param array $context
     * @return array
     */
    public function normalize($user, string $format = null, array $context = []): array
    {
        // TODO: Implement normalize() method.
        return [
            'id' => $user->getId(),
            'lastName' => $user->getLastName(),
            'firstName' => $user->getFirstName(),
            'mail' => $user->getEmail(),
            'phone' => $user->getPhone(),
            'role' => $user->getRole()->getId(),
            'isActive' => $user->isActive(),
            'statut' => $user->getUserStatus(),
            'addresse' => $user->getAddress()
        ];
    }
}