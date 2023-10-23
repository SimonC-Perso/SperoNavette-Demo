<?php

namespace App\Controller;

use App\Entity\Addresses;
use App\Entity\Baggage;
use App\Entity\Booking;
use App\Entity\BookingBaggage;
use App\Entity\Cities;
use App\Entity\Enterprise;
use App\Entity\Enum\BookingTypeEnum;
use App\Entity\Enum\EnumBookingStatus;
use App\Entity\Enum\EnumUserStatus;
use App\Entity\Roles;
use App\Entity\Travel;
use App\Entity\Users;
use App\Form\BookingSimulatorFormType;
use App\Services\MailerService;
use App\Services\UsersService;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Mailer\Exception\TransportExceptionInterface;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\String\ByteString;
use Symfony\Component\Validator\Constraints\Collection;
use Symfony\Component\Validator\Constraints\Json;

class BookingController extends AbstractController
{

    #[Route('/setContent', name: 'setContent')]
    public function setContent(Request $request): JsonResponse
    {
        $session = $request->getSession();
        $content = $request->get('contentSessionHTML');
        $session->set('contentSessionHTML', $content);
        $json = '{"return":"true"}';
        return new JsonResponse($json, 200);
    }

    /**
     * @throws TransportExceptionInterface
     */
    #[Route('/saveBooking', name: 'saveBooking')]
    public function saveBooking(Request $request, MailerService $mailerService, EntityManagerInterface $entityManager, UsersService $usersService): Response
    {
        $form = $this->createForm(BookingSimulatorFormType::class);
        $form->handleRequest($request);
        if ($form->isSubmitted() && $form->isValid()) {

            $booking = new Booking();
            $booking->setBookingDate(new \DateTime());
            $booking->setActive(true);
            $booking->setPassenger($form->get('passenger')->getData());
            $booking->setTotalPrice(str_replace(array(' ', '€'), '', $request->request->get('price')));
            switch (strtoupper($form->get('travelType')->getData())) {
                case 'SHARED':
                    $booking->setBookingTypeEnum(BookingTypeEnum::SHARED);
                    break;
                case 'PRIVATE':
                    $booking->setBookingTypeEnum(BookingTypeEnum::PRIVATE);
                    break;
                default:
                    $booking->setBookingTypeEnum(BookingTypeEnum::OTHER);
            }
            $travel = new Travel();
            $startingAddress = new Addresses();
            $arrivalAddress = new Addresses();
            $startingCity = $form->get('travel')->get('departureAddress')->get('departureCity')->getData();
            if ($startingCity != null)
                $startingAddress->setCity($entityManager->getRepository(Cities::class)->find($startingCity->getZipcode()));
            $startingAddress->setStreetName($form->get('travel')->get('departureAddress')->get('departureStreet')->getData());
            $startingAddress->setStreetNumber($form->get('travel')->get('departureAddress')->get('departureNumber')->getData());
            $arrivalAddress->setStreetName($form->get('travel')->get('arrivalAddress')->get('arrivalStreet')->getData());
            $arrivalAddress->setStreetNumber($form->get('travel')->get('arrivalAddress')->get('arrivalNumber')->getData());
            $arrivalCity = $form->get('travel')->get('arrivalAddress')->get('arrivalCity')->getData();
            if ($arrivalCity != null)
                $arrivalAddress->setCity($entityManager->getRepository(Cities::class)->find($arrivalCity->getZipcode()));
            $travel->setStartingAddress($startingAddress);
            $travel->setArrivalAddress($arrivalAddress);
            $booking->setTravel($travel);
            $booking->setStatus(EnumBookingStatus::REQUEST);
            $additionalFeeQte = $request->request->all('booking_simulator_form_additional_fee_qte');
            $bookingBaggageList = new ArrayCollection();
            $i = 0;
            foreach ($request->request->all('booking_simulator_form_additional_fee_id') as $additionalFee) {
                $baggage = new Baggage();
                dd($additionalFee);
                $baggage = $entityManager->getRepository(Baggage::class)->find($additionalFee);
                $bookingBaggage = new BookingBaggage();
                $bookingBaggage->setBooking($booking);
                $bookingBaggage->setBaggage($baggage);
                $bookingBaggage->setQuantity($additionalFeeQte[$i]);
                $bookingBaggageList->add($bookingBaggage);
                $i++;
            }
            $firstName = $form->get('contact')->get('firstName')->getData();
            $lastName = $form->get('contact')->get('lastName')->getData();
            $to = $form->get('contact')->get('email')->getData();
            $phone = $form->get('contact')->get('phone')->getData();
            $user = $usersService->findByEmail($to);
            if ($user == null) {
                $user = new Users();
                $user->setEmail($to);
                $user->setActive(true);
                $user->setLastName($lastName);
                $user->setFirstName($firstName);
                $user->setPassword(password_hash(ByteString::fromRandom(32)->toString(), PASSWORD_BCRYPT));
                $user->setUserStatusEnum(EnumUserStatus::Ok);
                $user->setPhone($phone);
                $user->setRole($entityManager->getRepository(Roles::class)->find(2));
                $user->setResetPassword(true);
                //  $entityManager->persist($user);
            }
            $booking->setUser($user);
            $booking->setTravelBaggageList($bookingBaggageList);
            $booking->setDiscount("0");
            $session = $request->getSession();
            $content = $session->get('contentSessionHTML');
            $content = str_replace('input', 'span', $content);
            $content = str_replace('<select>', '<span>', $content);
            $content = str_replace('</select>', '</span>', $content);
            $content = str_replace('<option', '<span', $content);
            $session->set('contentSessionHTML', $content);
//            dd($content);
            $mailContent = $this->renderView("email/email.booking_template.html.twig");
//            dd($request);
//            $entityManager->persist($booking);
            //           $entityManager->flush();
            //dd($mailContent);
            $mailerService->sendEmail(mail: $to, content: $mailContent, phone: $phone);
        }
        return $this->redirect('/');
    }
}
