<?php

namespace App\Form;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\TelType;
use Symfony\Component\Form\Extension\Core\Type\TextareaType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use App\Entity\Contact;
use Symfony\Component\Form\Extension\Core\Type\EmailType;
use Symfony\Component\Form\Extension\Core\Type\TextType;


class ContactType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('name',TextType::class,[
                'attr'=>[
                    'placeholder'=>'Votre Nom',
                    'class'=>"form-control ",
                    'id'=>"name",
                    'data-sb-validations'=>"required"
                ],
                'label'=>false
            ])
            ->add('mail',EmailType::class,[
                'attr'=>[
                    'placeholder'=>'Votre Email',
                    'class'=>"form-control",
                    'id'=>"email",
                    'data-sb-validations'=>"required,email"
                ],
                'label'=>false
            ])
            ->add('phone',TelType::class,[
                'attr'=>[
                    'placeholder'=>'Votre téléphone',
                    'class'=>'form-control',
                    'id'=>'phone',
                    'data-sb-validations'=>'required'
                ],
                'label'=>false
            ])
            ->add('message',TextareaType::class,[
                'attr'=> [
                'placeholder'=>'Votre Message',
                'class'=>"form-control",
                'id'=>"message",
                'data-sb-validations'=>"required"
                ],
                'label'=>false
        ]);
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class'=>Contact::class
        ]);
    }
}
