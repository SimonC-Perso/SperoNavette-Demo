<?php

namespace App\Validators;


use App\Entity\Users;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Validator\Constraint;
use Symfony\Component\Validator\ConstraintValidator;

class UniqueEmailValidator extends ConstraintValidator
{


    private  $entityManager;
    public function __construct(EntityManagerInterface $entityManager )
    {

        $this->entityManager = $entityManager;
    }

    public function validate( $value, Constraint $constraint)
    {
        if(!$value){
            return;
        }
        $existingUser = $this->entityManager->getRepository(Users::class)->findByEmail($value);

        if($existingUser){
            $this->context->buildViolation($constraint->message)
                ->addViolation();
        }
    }
}