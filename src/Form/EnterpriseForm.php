<?php

namespace App\Form;

use App\Entity\Enterprises;
use Doctrine\DBAL\Types\IntegerType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\DateTimeType;
use Symfony\Component\Form\Extension\Core\Type\EmailType;
use Symfony\Component\Form\Extension\Core\Type\TelType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class EnterpriseForm extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('name', TextType::class,['label' => 'form.enterprise.name'])
            ->add('email', EmailType::class,['label' => 'form.enterprise.email'])
            ->add('phone', TelType::class,['label' => 'form.enterprise.phone'])
            ->add('vat', TextType::class, ['label' => 'form.enterprise.vat']);
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Enterprises::class,
        ]);
    }
}
