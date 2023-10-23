<?php

namespace App\Form;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\EmailType;
use Symfony\Component\Form\Extension\Core\Type\TelType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class UserSimulatorFormType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('phone', TelType::class, [
                'label' => 'modal.booking.contact.phone',
                'required' => true,
                'attr' => [
                    'placeholder' => '+XX XXX XXX XXX',
                ],

            ])->add('email', EmailType::class, [
                "attr" => [
                    'placeholder' => "Email",
                    "maxlength" => "100",
                ],
                'required' => true,
                "label" => "modal.booking.contact.mail"
            ])->add('lastName', TextType::class, [
                "attr" => [
                    'placeholder' => "Nom",
                    "maxlength" => "70",
                    "minlength" => "1"

                ],
                'required' => true,
                "label" => "modal.booking.contact.lastName"
            ])
            ->add('firstName', TextType::class, [
                "attr" => [
                    'placeholder' => "Prénom",
                    "maxlength" => "70",
                    "minlength" => "1"
                ],
                'required' => true,
                "label" => "modal.booking.contact.firstName"
            ]);
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            // Configure your form options here
        ]);
    }
}
