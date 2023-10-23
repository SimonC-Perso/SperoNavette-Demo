<?php

namespace App\Form;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Validator\Constraints\NotBlank;

class ArrivalAddressSimulatorFormType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add("arrivalStreet", TextType::class, ['label' => 'form.arrivalAddress.arrivalStreet'])
            ->add('arrivalNumber', TextType::class, ['label' => 'form.arrivalAddress.arrivalNumber', 'required' => false])
            ->add('arrivalCity', ArrivalCitySimulatorFormType::class, ['label' => false]);;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            // Configure your form options here
        ]);
    }
}
