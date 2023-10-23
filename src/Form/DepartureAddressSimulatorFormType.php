<?php

namespace App\Form;


use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Validator\Constraints\NotBlank;

class DepartureAddressSimulatorFormType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add("departureStreet", TextType::class, ['label' => 'form.departureAddress.departureStreet', 'constraints' => new NotBlank(['message' => 'form.error.street.notBlank'])])
            ->add('departureNumber', TextType::class, ['label' => 'form.departureAddress.departureNumber'])
            ->add('departureCity', DepartureCitySimulatorFormType::class, ['label' => false]);
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            // Configure your form options here
        ]);
    }
}
