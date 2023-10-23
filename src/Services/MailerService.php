<?php

namespace App\Services;

use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Mailer\Exception\TransportExceptionInterface;
use Symfony\Component\Mailer\MailerInterface;
use Symfony\Component\Mime\Address;
use Symfony\Component\Mime\Email;

class MailerService
{
    public function __construct(private MailerInterface $mailer)
    {
    }

    /**
     * @throws TransportExceptionInterface
     */
    public function sendEmail($mail, $content, $phone = ''): void
    {
//        $email = (new Email())
//            ->from($mail)
//            ->to('xavier.lawaree@gmail.com')
//            //->cc('cc@example.com')
//            //->bcc('bcc@example.com')
//            //->replyTo('fabien@example.com')
//            //->priority(Email::PRIORITY_HIGH)
//            ->subject('speroNavette Symfony Mailer!')
////            ->text('Sending emails is fun again!')
//            ->html($content);
//
//        $this->mailer->send($email);

        $emailClient = (new Email())
            ->from(new Address("speroNavette.noreply@speroNavette.be", "Spero Navette"))
            ->to($mail)
            //->cc('cc@example.com')
            //->bcc('bcc@example.com')
            //->replyTo('fabien@example.com')
            //->priority(Email::PRIORITY_HIGH)
            ->embedFromPath('IMG/email/logo-trans-spero-min.png', 'logo')
            ->subject('spero Navette récapitulatif!')
//            ->text('Sending emails is fun again!')
            ->html($content);

        $this->mailer->send($emailClient);

        // ...
    }
}