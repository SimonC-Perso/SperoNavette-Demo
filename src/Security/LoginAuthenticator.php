<?php

namespace App\Security;

use App\Repository\UsersRepository;
use Doctrine\ORM\NonUniqueResultException;
use Symfony\Component\HttpFoundation\RedirectResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Generator\UrlGeneratorInterface;
use Symfony\Component\Security\Core\Authentication\Token\TokenInterface;
use Symfony\Component\Security\Core\Exception\AuthenticationException;
use Symfony\Component\Security\Core\Exception\CustomUserMessageAuthenticationException;
use Symfony\Component\Security\Http\Authenticator\AbstractAuthenticator;
use Symfony\Component\Security\Http\Authenticator\Passport\Badge\CsrfTokenBadge;
use Symfony\Component\Security\Http\Authenticator\Passport\Badge\UserBadge;
use Symfony\Component\Security\Http\Authenticator\Passport\Credentials\PasswordCredentials;
use Symfony\Component\Security\Http\Authenticator\Passport\Passport;

class LoginAuthenticator extends AbstractAuthenticator
{
    private UsersRepository $usersRepository;
    private UrlGeneratorInterface $urlGenerator;

    public function __construct(UsersRepository $usersRepository, UrlGeneratorInterface $urlGenerator)
    {
        $this->usersRepository = $usersRepository;
        $this->urlGenerator = $urlGenerator;
    }

    public function supports(Request $request): ?bool
    {
        return $request->attributes->get('_route') === 'login' && $request->isMethod('POST');
    }

    /**
     * @throws NonUniqueResultException
     */
    public function authenticate(Request $request): Passport
    {
        $user = $this->usersRepository->findByEmail($request->request->get('email'));

        if (!$user) {
            throw new CustomUserMessageAuthenticationException('Invalid username');
        }


        return new Passport(new UserBadge($user->getEmail()), new PasswordCredentials($request->request->get('password')),
            [new CsrfTokenBadge('login_form', $request->request->get('csrf_token'))]);


    }

    public function onAuthenticationSuccess(Request $request, TokenInterface $token, string $firewallName): ?Response
    {
        $request->getSession()->getFlashBag()->add('success', "Bienvenue !");
        return null;
    }

    public function onAuthenticationFailure(Request $request, AuthenticationException $exception): ?Response
    {


        //Pour gérer les erreurs de token lors du login
        if ($exception->getToken() === null) {
            $request->getSession()->getFlashBag()->add('error', "Informations d'identification invalides");
            return new RedirectResponse($this->urlGenerator->generate('index'));
        }
        $request->getSession()->getFlashBag()->add('error', 'Combinaison email/mot de passe invalide.');
        return new RedirectResponse($this->urlGenerator->generate('index'));
    }

//    public function start(Request $request, AuthenticationException $authException = null): Response
//    {
//        /*
//         * If you would like this class to control what happens when an anonymous user accesses a
//         * protected page (e.g. redirect to /login), uncomment this method and make this class
//         * implement Symfony\Component\Security\Http\EntryPoint\AuthenticationEntryPointInterface.
//         *
//         * For more details, see https://symfony.com/doc/current/security/experimental_authenticators.html#configuring-the-authentication-entry-point
//         */
//    }
}
