<?php

namespace App\Form;

use App\Entity\Cities;
use App\Entity\Countries;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\ChoiceType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\Form\FormEvent;
use Symfony\Component\Form\FormEvents;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Validator\Constraints\NotBlank;

class CityForm extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('label', ChoiceType::class, ['label' => 'label', 'constraints' => new NotBlank(['message' => 'form.constraint.label'])])
            ->add('zipcode', TextType::class)
            ->add('country', EntityType::class, [
                    'attr' => ['class' => 'formControl'],
                    'label' => 'form.country.country',
                    'class' => Countries::class,
                    'choice_label' => 'label',
                    'empty_data' => 'Belgique'
                ]
            );
        $builder->addEventListener(FormEvents::PRE_SUBMIT,
            function (FormEvent $event) {
                $form = $event->getForm();
                $cities = $event->getData();
                $form->add('label', TextType::class, ['data' => $cities['label']]);
            });
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Cities::class,
        ]);
    }
}
