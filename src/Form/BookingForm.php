<?php

namespace App\Form;

use App\Entity\Baggage;
use App\Entity\Booking;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\ChoiceType;
use Symfony\Component\Form\Extension\Core\Type\DateTimeType;
use Symfony\Component\Form\Extension\Core\Type\IntegerType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class BookingForm extends AbstractType
{
    private $manager;

    public function __construct(EntityManagerInterface $manager)
    {
        $this->manager = $manager;
    }

    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('bookingType', ChoiceType::class, [
                'choices' => [
                    'Aller' => 'Aller',
                    'Aller/Retour' => 'Aller/Retour'
                ],
                'attr' => [],
                'label' => false,
                'expanded' => true
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
            ->add('bookingDate', TextType::class, [
                'required' => true,
                'label' => 'form.label.departureDate',
                'attr' => array(
                    'class' => 'form-control input-inline datetimepicker',
                    'data-provide' => 'datepicker',
                    'data-format' => 'dd-mm-yyyy HH:ii',
                ),
            ])
            ->add('passenger', ChoiceType::class, [
                'choices' => array_combine(range(1, 8), range(1, 8)),
                'label' => 'Passagers'
            ])
            ->add('departureDate', TextType::class, [
                'required' => true,
                'label' => 'form.label.departureDate',
                'attr' => array(
                    'class' => 'form-control input-inline datetimepicker',
                    'data-provide' => 'datepicker',
                    'data-format' => 'dd-mm-yyyy HH:ii',
                ),
            ])
            ->add('arrivalDate', TextType::class, [
                'required' => true,
                'label' => 'form.label.arrivalDate',
                'attr' => array(
                    'class' => 'form-control input-inline datetimepicker',
                    'data-provide' => 'datepicker',
                    'data-format' => 'dd-mm-yyyy HH:ii',
                ),
            ])
            ->add('arrivalFlightNumber', TextType::class)
            ->add('departureFlightNumber', TextType::class)
            ->add('price', IntegerType::class, [
                'attr' => [
                    'readonly' => true,
                    'style' => 'appearance: textfield; -moz-appearance: textfield;',
                ]
            ])
            ->add('note', TextType::class)
            ->add('status')
            ->add('discount')
            ->add('step', EntityType::class, [
                'class' => 'App\Entity\Booking',
                'choice_label' => 'id'
            ])
            ->add('travel', TravelSimulatorForm::class, ['label' => false])
            ->add('driver', EntityType::class, [
                'class' => 'App\Entity\Users',
                'choice_label' => 'id'
            ])
            ->add('user', EntityType::class, [
                'class' => 'App\Entity\Users',
                'choice_label' => 'id'
            ])->add("bookingBaggageList", ChoiceType::class);


    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Booking::class,
        ]);
    }

    private function baggage(): array
    {

        $bagages = $this->manager->getRepository(Baggage::class)->findBy(array('is_active' => 1));
        return $bagages;
    }
}
