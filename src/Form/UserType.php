<?php

namespace App\Form;

use App\Entity\Users;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\ChoiceType;
use Symfony\Component\Form\Extension\Core\Type\EmailType;
use Symfony\Component\Form\Extension\Core\Type\PasswordType;
use Symfony\Component\Form\Extension\Core\Type\TelType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class UserType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('last_name', TextType::class, [
                "attr" => [
                    'placeholder' => "Nom",
                    "maxlength" => "70",
                    "minlength" => "1"
                ],
                "label" => "Nom"
            ])
            ->add('first_name', TextType::class, [
                "attr" => [
                    'placeholder' => "Prénom",
                    "maxlength" => "70",
                    "minlength" => "1"
                ],
                "label" => "Prénom"
            ])
            ->add('country_code', ChoiceType::class, [
                'choices' => [
                    'BE' => '+32',
                    'US' => '+1',
                    'FR' => '+33',
                    'GB' => '+44',
                    // add more country codes here...
                ],
                'attr' => ['data-selected' => "be",]
            ])
            ->add('phone', TelType::class, [
                'label' => 'Numéro de téléphone',
                'required' => true,
                'attr' => [
                    'placeholder' => '+XX XXX XXX XXX',
                ],

            ])
            ->add('email', EmailType::class, [
                "attr" => [
                    'placeholder' => "Email",
                    "maxlength" => "100",

                ],
                "label" => "Adresse mail"
            ])
            ->add('password', PasswordType::class, [
                "attr" => [
                    'placeholder' => "Votre mot de passe",
                    "maxlength" => "255",
                ],
                "label" => "Mot de passe"
            ])
            ->add('confirmPassword', PasswordType::class, [
                "attr" => [
                    'placeholder' => "Confirmer le mot de passe",
                    "maxlength" => "255",
                ],
                "label" => "Confirmer le Mot de passe",

            ]);

    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Users::class,
            'Validation_groups' => ['default', 'registration']
        ]);

    }
}
