<?php

namespace App\Form;

use App\Entity\Cities;
use App\Entity\Countries;
use App\Entity\Country;
use App\Repository\CountriesRepository;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\ChoiceList\ChoiceList;
use Symfony\Component\Form\Extension\Core\Type\ChoiceType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\Form\FormEvent;
use Symfony\Component\Form\FormEvents;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Validator\Constraints\NotBlank;

class DepartureCitySimulatorFormType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('zipcode', TextType::class, ['label' => 'form.departureCity.zipcode'])
            ->add('label', ChoiceType::class, ['label' => 'form.departureCity.label',
                'constraints' => new NotBlank(['message' => 'form.constraint.city']),
                'attr' => ['class' => 'select-departure-city']])
            ->add('Country', EntityType::class, [
                    'attr' => ['class' => 'formControl'],
                    'label' => 'form.departureCountry.country',
                    "multiple" => false,
                    "expanded" => false,
                    'class' => Countries::class,
                    'choice_label' => 'label',
                ]
            );


        $builder->addEventListener(FormEvents::PRE_SUBMIT,
            function (FormEvent $event) {
                $form = $event->getForm();
                $locality = $event->getData();
                $form->add('label', TextType::class, ['data' => $locality['label'],
                    'attr' => ['class' => 'select-departure-city']]);
            });
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Cities::class,
        ]);
    }
}
