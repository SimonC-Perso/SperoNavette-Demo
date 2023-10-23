<?php

namespace App\Form;

use App\Entity\Cities;
use App\Entity\Prices;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\NumberType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class PricesFormType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('price', NumberType::class, ['label' => 'form.prices.price'])
            ->add('from', EntityType::class, [
                'attr' => ['class' => 'formControl select-prices-from'],
                'label' => 'form.prices.from',
                "multiple" => false,
                "expanded" => false,
                'class' => Cities::class,
                'choice_label' => 'label'])
            ->add('to', EntityType::class, [
                'attr' => ['class' => 'formControl select-prices-to'],
                'label' => 'form.prices.to',
                "multiple" => false,
                "expanded" => false,
                'class' => Cities::class,
                'choice_label' => 'label']);
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Prices::class,
        ]);
    }
}
