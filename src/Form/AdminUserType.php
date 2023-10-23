<?php

namespace App\Form;

use App\Entity\Enum\EnumUserStatus;
use App\Entity\Roles;
use App\Entity\Users;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\ChoiceType;
use Symfony\Component\Form\Extension\Core\Type\EmailType;
use Symfony\Component\Form\Extension\Core\Type\EnumType;
use Symfony\Component\Form\Extension\Core\Type\PasswordType;
use Symfony\Component\Form\Extension\Core\Type\TelType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class AdminUserType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('last_name', TextType::class, [
                "attr" => [
                    "maxlength" => "70",
                    "minlength" => "1",
                    "placeholder" => "Nom",
                ],
                "label" => "Nom",
                'row_attr' => [
                    'class' => 'form-floating text-black',
                ],
            ])
            ->add('first_name', TextType::class, [
                "attr" => [
                    "maxlength" => "70",
                    "minlength" => "1",
                    "placeholder" => "Prénom",
                ],
                "label" => "Prénom",
                'row_attr' => [
                    'class' => 'form-floating text-black',
                ],
            ])
            ->add('phone', TelType::class, [
                'label' => 'Numéro de téléphone',
                'required' => true,
                'attr' => [
                    'placeholder' => '+32',
                ],
                'row_attr' => [
                    'class' => 'form-floating text-black',
                ],

            ])
            ->add('email', EmailType::class, [
                "attr" => [
                    "maxlength" => "100",
                    "placeholder" => "Email",
                ],
                "label" => "Email",
                'row_attr' => [
                    'class' => 'form-floating text-black',
                ],
            ])
            ->add('password', PasswordType::class, [
                "attr" => [
                    "maxlength" => "255",
                    "placeholder" => "Mot de passe",
                ],
                "label" => "Mot de passe",
                'row_attr' => [
                    'class' => 'form-floating text-black',
                ],
            ])
            ->add('confirmPassword', PasswordType::class, [
                "attr" => [
                    "maxlength" => "255",
                    "placeholder" => "Confirmation mot de passe",
                ],
                "label" => "Confirmer le Mot de passe",
                'row_attr' => [
                    'class' => 'form-floating text-black',
                ],

            ])
            ->add('role', EntityType::class, ['class' => Roles::class, 'choice_label' => 'label', 'label' => 'Role', 'row_attr' => [
                'class' => 'form-floating text-black',
            ],])
            ->add('userStatus', ChoiceType::class, ['choices' => EnumUserStatus::cases(), 'choice_label' => fn($choice) => match ($choice) {
                EnumUserStatus::Ok => 'Ok',
                EnumUserStatus::Blacklist => 'Blacklist',
            }, 'label' => 'Status', 'row_attr' => [
                'class' => 'form-floating text-black',
            ],]);
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Users::class,
        ]);
    }
}
