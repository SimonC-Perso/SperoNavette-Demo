<?php

namespace App\Form;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\ChoiceType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class BookingSimulatorFormType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('bookingType', ChoiceType::class, [
                'choices' => [
                    'Aller' => 'Aller',
                    'Aller/Retour' => 'Aller/Retour'
                ],
                'attr' => [],
                'label' => 'form.travel.type',
                'expanded' => true,
                'data' => 'Aller',
            ])
            ->add('travelType', ChoiceType::class, [
                'choices' => [
                    'Navette privée' => 'private',
                    'Navette partagée' => 'shared'
                ],
                'attr' => [],
                'label' => 'form.travel.transport',
                'expanded' => true,
                'data' => 'shared',
            ])
            ->add('passenger', ChoiceType::class, [
                'choices' => array_combine(range(1, 8), range(1, 8)),
                'label' => 'form.number.passenger'
            ])
            ->add('contact', UserSimulatorFormType::class, ['label' => false])
            ->add('travel', TravelSimulatorForm::class, ['label' => false]);
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            // Configure your form options here
        ]);
    }
}
