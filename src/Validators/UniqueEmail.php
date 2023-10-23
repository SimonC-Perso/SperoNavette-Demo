<?php

namespace App\Validators;

use Symfony\Component\Validator\Constraint;

#[\Attribute]
class UniqueEmail extends Constraint
{
    public $message = "L'email est déjà utilisée";

    /**
     * @return string
     */
    public function validatedBy()
    {
        return static::class."Validator";
    }
}