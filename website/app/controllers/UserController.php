<?php

class UserController extends BaseController {

    public function __construct()
    {
        //Check CSRF token on POST
        $this->beforeFilter('csrf', array('on' => 'post'));

        // Get the Throttle Provider
        $throttleProvider = Sentry::getThrottleProvider();

        // Enable the Throttling Feature
        $throttleProvider->enable();
    }

    // Registration ----------------------------------------------------------------------------------------------------

    public function getRegister()
    {
        return View::make('user.register');
    }

    public function postRegister()
    {
        $input = array(
            'email' => Input::get('email'),
            'password' => Input::get('password'),
            'password_confirmation' => Input::get('password_confirmation')
        );

        $rules = array (
            'email' => 'required|min:4|max:32|email',
            'password' => 'required|min:6|confirmed',
            'password_confirmation' => 'required'
        );

        $v = Validator::make($input, $rules);

        if ($v->fails()) {
            return Redirect::to('user/register')->withErrors($v)->withInput();
        }
        else
        {
            try {
                //Attempt to register the user.
                $user = Sentry::register(array('email' => $input['email'], 'password' => $input['password']));

                //Get the activation code & prep data for email
                $data['activationCode'] = $user->GetActivationCode();
                $data['email'] = $input['email'];
                $data['userId'] = $user->getId();

                //send email with link to activate.
                Mail::send('emails.auth.welcome', $data, function($m) use($data) {
                    $m->to($data['email'])->subject('Welcome to the ALiVE War Room - Activate your account');
                });

                //success!
                Alert::success('Your account has been created. Check your email for the confirmation link.')->flash();
                return Redirect::to('user/register');

            } catch (Cartalyst\Sentry\Users\LoginRequiredException $e) {
                Alert::error('Login field required')->flash();
                return Redirect::to('user/register')->withErrors($v)->withInput();

            } catch (Cartalyst\Sentry\Users\UserExistsException $e) {
                Alert::error('A user already exists with this email address.')->flash();
                return Redirect::to('user/register')->withErrors($v)->withInput();

            }
        }
    }

    public function getActivate($userId = null, $activationCode = null)
    {
        try {
            // Find the user
            $user = Sentry::getUserProvider()->findById($userId);

            // Attempt user activation
            if ($user->attemptActivation($activationCode)) {
                //Add this person to the user group.
                $userGroup = Sentry::getGroupProvider()->findById(1);
                $user->addGroup($userGroup);

                Alert::success('Your account has been activated. Please log in.')->flash();
                return Redirect::to('user/login');
            } else {
                // User activation failed
                Alert::error('There was a problem activating this account. Please contact the system administrator.')->flash();
                return Redirect::to('user/register');
            }
        } catch (Cartalyst\Sentry\Users\UserNotFoundException $e) {
            Alert::error('User does not exist.')->flash();
            return Redirect::to('user/register');
        } catch (Cartalyst\SEntry\Users\UserAlreadyActivatedException $e) {
            Alert::error('You have already activated this account.')->flash();
            return Redirect::to('user/register');
        }
    }

    public function getResend()
    {
        return View::make('user.resend');
    }

    public function postResend()
    {

        $input = array(
            'email' => Input::get('email')
        );

        $rules = array (
            'email' => 'required|min:4|max:32|email'
        );

        $v = Validator::make($input, $rules);

        if ($v->fails()) {
            return Redirect::to('user/resend')->withErrors($v)->withInput();
        } else {
            //Attempt to find the user.
            $user = Sentry::getUserProvider()->findByLogin(Input::get('email'));

            if (!$user->isActivated()) {
                //Get the activation code & prep data for email
                $data['activationCode'] = $user->GetActivationCode();
                $data['email'] = $input['email'];
                $data['userId'] = $user->getId();

                //send email with link to activate.
                Mail::send('emails.auth.welcome', $data, function($m) use ($data) {
                    $m->to($data['email'])->subject('ALiVE War Room - Activate your account');
                });

                //success!
                Alert::success('Check your email for the confirmation link.')->flash();
                return Redirect::to('/user/resend');
            } else {
                Alert::error('That account has already been activated.')->flash();
                return Redirect::to('/user/resend');
            }
        }
    }

    // Authentication --------------------------------------------------------------------------------------------------

    public function getLogin()
    {
        return View::make('user.login');
    }

    public function postLogin()
    {
        $input = array(
            'email' => Input::get('email'),
            'password' => Input::get('password'),
            'rememberMe' => Input::get('rememberMe')
        );

        $rules = array (
            'email' => 'required|min:4|max:32|email',
            'password' => 'required|min:6'
        );

        $v = Validator::make($input, $rules);

        if ($v->fails()) {
            return Redirect::to('user/login')->withErrors($v)->withInput();
        } else {
            try {
                //Check for suspension or banned status
                $user = Sentry::getUserProvider()->findByLogin($input['email']);
                $throttle = Sentry::getThrottleProvider()->findByUserId($user->id);
                $throttle->check();

                // Set login credentials
                $credentials = array(
                    'email'    => $input['email'],
                    'password' => $input['password']
                );

                // Try to authenticate the user
                $user = Sentry::authenticate($credentials, $input['rememberMe']);

            } catch (Cartalyst\Sentry\Users\UserNotFoundException $e) {
                // Sometimes a user is found, however hashed credentials do
                // not match. Therefore a user technically doesn't exist
                // by those credentials. Check the error message returned
                // for more information.
                Alert::error('Invalid username or password.')->flash();
                return Redirect::to('user/login')->withErrors($v)->withInput();

            } catch (Cartalyst\Sentry\Users\UserNotActivatedException $e) {
                Alert::error('You have not yet activated this account. <a href="'. URL::to('user/resend'). '">Resend actiavtion?</a>')->flash();
                return Redirect::to('user/login')->withErrors($v)->withInput();

            } catch (Cartalyst\Sentry\Throttling\UserSuspendedException $e) {
                $time = $throttle->getSuspensionTime();
                Alert::error("Your account has been suspended for $time minutes.")->flash();
                return Redirect::to('user/login')->withErrors($v)->withInput();

            } catch (Cartalyst\Sentry\Throttling\UserBannedException $e) {
                Alert::error('You have been banned.')->flash();
                return Redirect::to('user/login')->withErrors($v)->withInput();

            }

            //Login was succesful.
            return Redirect::to('war-room');
        }
    }

    public function getLogout()
    {
        Sentry::logout();
        return Redirect::to('/');
    }

    // Help ------------------------------------------------------------------------------------------------------------

    public function getResetpassword()
    {
        return View::make('user.reset');
    }

    public function postResetpassword ()
    {
        $input = array(
            'email' => Input::get('email')
        );

        $rules = array (
            'email' => 'required|min:4|max:32|email'
        );

        $v = Validator::make($input, $rules);

        if ($v->fails()) {
            return Redirect::to('user/resetpassword')->withErrors($v)->withInput();
        } else {
            try {
                $user = Sentry::getUserProvider()->findByLogin($input['email']);
                $data['resetCode'] = $user->getResetPasswordCode();
                $data['userId'] = $user->getId();
                $data['email'] = $input['email'];

                // Email the reset code to the user
                Mail::send('emails.auth.reset', $data, function($m) use($data) {
                    $m->to($data['email'])->subject('ALiVE War Room - Password Reset Confirmation');
                });

                Alert::success('Check your email for password reset information.')->flash();
                return Redirect::to('/user/resetpassword');

            } catch (Cartalyst\Sentry\Users\UserNotFoundException $e) {
                Alert::error('User does not exist.')->flash();
                return Redirect::to('/user/resetpassword');
            }
        }
    }

    public function getReset($userId = null, $resetCode = null) {
        try
        {
            // Find the user
            $user = Sentry::getUserProvider()->findById($userId);
            $newPassword = $this->_generatePassword(8,8);

            // Attempt to reset the user password
            if ($user->attemptResetPassword($resetCode, $newPassword)) {
                // Password reset passed
                //
                // Email the reset code to the user

                //Prepare New Password body
                $data['newPassword'] = $newPassword;
                $data['email'] = $user->getLogin();

                Mail::send('emails.auth.newpassword', $data, function($m) use($data) {
                    $m->to($data['email'])->subject('ALiVE War Room - New Password Information');
                });

                Alert::success('Your password has been changed. Check your email for the new password.')->flash();
                return Redirect::to('/user/login');

            } else {
                // Password reset failed
                Alert::error('There was a problem.  Please contact the system administrator.')->flash();
                return Redirect::to('user/resetpassword');
            }
        } catch (Cartalyst\Sentry\Users\UserNotFoundException $e) {
            Alert::error('User does not exist.')->flash();
            return Redirect::to('/user/login');
        }
    }

    private function _generatePassword($length=9, $strength=4) {
        $vowels = 'aeiouy';
        $consonants = 'bcdfghjklmnpqrstvwxz';
        if ($strength & 1) {
            $consonants .= 'BCDFGHJKLMNPQRSTVWXZ';
        }
        if ($strength & 2) {
            $vowels .= "AEIOUY";
        }
        if ($strength & 4) {
            $consonants .= '23456789';
        }
        if ($strength & 8) {
            $consonants .= '@#$%';
        }

        $password = '';
        $alt = time() % 2;
        for ($i = 0; $i < $length; $i++) {
            if ($alt == 1) {
                $password .= $consonants[(rand() % strlen($consonants))];
                $alt = 0;
            } else {
                $password .= $vowels[(rand() % strlen($vowels))];
                $alt = 1;
            }
        }
        return $password;
    }

}