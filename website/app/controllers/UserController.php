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
                $user = Sentry::register(array('email' => $input['email'], 'password' => $input['password']));

                $data['activationCode'] = $user->GetActivationCode();
                $data['email'] = $input['email'];
                $data['userId'] = $user->getId();

                Mail::send('emails.auth.welcome', $data, function($m) use($data) {
                    $m->to($data['email'])->subject('Welcome to the ALiVE War Room - Activate your account');
                });

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
            $user = Sentry::getUserProvider()->findById($userId);

            if ($user->attemptActivation($activationCode)) {
                $userGroup = Sentry::findGroupByName('Users');
                $user->addGroup($userGroup);

                Alert::success('Your account has been activated. Please log in.')->flash();
                return Redirect::to('user/loginactivate');
            } else {
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
            $user = Sentry::getUserProvider()->findByLogin(Input::get('email'));

            if (!$user->isActivated()) {
                $data['activationCode'] = $user->GetActivationCode();
                $data['email'] = $input['email'];
                $data['userId'] = $user->getId();

                Mail::send('emails.auth.welcome', $data, function($m) use ($data) {
                    $m->to($data['email'])->subject('ALiVE War Room - Activate your account');
                });

                Alert::success('Check your email for the confirmation link.')->flash();
                return Redirect::to('/user/resend');
            } else {
                Alert::error('That account has already been activated.')->flash();
                return Redirect::to('/user/resend');
            }
        }
    }

    // Profile ----------------------------------------------------------------------------------------------------

    public function getProfile($id)
    {
        try {
            $data['user'] = Sentry::getUser();
            $data['countries'] = DB::table('countries')->lists('name','iso_3166_2');
            $data['ageGroup'] = get_age_group_data();

            if ( $data['user']->hasAccess('admin') || $data['user']->getId() == $id) {
                $data['user'] = Sentry::getUserProvider()->findById($id);
                return View::make('user.profile')->with($data);
            } else {
                Alert::error('You don\'t have access to that user.')->flash();
                return Redirect::to('admin/user');
            }
        } catch (Cartalyst\Sentry\Users\UserNotFoundException $e) {
            Alert::error('There was a problem accessing this account.')->flash();
            return Redirect::to('admin');
        }
    }

    public function postProfile($id)
    {
        $input = array(
            'username' => Input::get('username'),
            'a3ID' => Input::get('a3ID'),
            'country' => Input::get('country'),
            'ageGroup' => Input::get('ageGroup'),
            'twitchStream' => Input::get('twitchStream'),
            /*
            'a2ID' => Input::get('a2ID'),
            'preferredClass' => Input::get('preferredClass'),
            'primaryProfile' => Input::get('primaryProfile'),
            'secondaryProfile' => Input::get('secondaryProfile'),
            'alias' => Input::get('alias'),
            'armaFace' => Input::get('armaFace'),
            'armaVoice' => Input::get('armaVoice'),
            'armaPitch' => Input::get('armaPitch'),
            */
        );

        $rules = array (
            'username' => 'required',
        );

        $v = Validator::make($input, $rules);

        if ($v->fails()) {
            return Redirect::to('user/profile/' . $id)->withErrors($v)->withInput();
        } else {

            try {
                $currentUser = Sentry::getUser();

                if ($currentUser->getId() == $id) {

                    $user = Sentry::getUserProvider()->findById($id);
                    if(is_null($user->profile)){
                        $profile = new Profile;

                        if($input['country'] != ''){
                            $countries = DB::table('countries')->lists('name','iso_3166_2');
                            $countryName = $countries[$input['country']];
                            $profile->country = $input['country'];
                            $profile->country_name = $countryName;
                        }

                        $profile->user_id = $id;
                        $profile->username = $input['username'];
                        $profile->a3_id = $input['a3ID'];
                        $profile->age_group = $input['ageGroup'];
                        $profile->twitch_stream = $input['twitchStream'];

                        /*
                        $profile->alias = $input['alias'];
                        $profile->a2_id = $input['a2ID'];
                        $profile->primary_profile = $input['primaryProfile'];
                        $profile->secondary_profile = $input['secondaryProfile'];
                        $profile->arma_face = $input['armaFace'];
                        $profile->arma_voice = $input['armaVoice'];
                        $profile->arma_pitch = $input['armaPitch'];
                        */

                        if ($profile->save()) {

                            Alert::success('Profile updated.')->flash();
                            return Redirect::to('war-room')->with('welcome', true);
                        }
                    }else{
                        return Redirect::to('war-room')->with('welcome', true);
                    }
                } else {
                    Alert::error('You don\'t have access to that user.')->flash();
                    return Redirect::to('user/profile/' . $id);
                }
            } catch (Cartalyst\Sentry\Users\UserNotFoundException $e) {
                Alert::error('User was not found.')->flash();
                return Redirect::to('user/profile/' . $id);
            }
        }
    }

    // Authentication --------------------------------------------------------------------------------------------------

    public function getLogin()
    {
        return View::make('user.login');
    }

    public function getLoginactivate()
    {
        return View::make('user.login_activate');
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
                $user = Sentry::getUserProvider()->findByLogin($input['email']);
                $throttle = Sentry::getThrottleProvider()->findByUserId($user->id);
                $throttle->check();

                $credentials = array(
                    'email'    => $input['email'],
                    'password' => $input['password']
                );

                $user = Sentry::authenticate($credentials, $input['rememberMe']);

            } catch (Cartalyst\Sentry\Users\UserNotFoundException $e) {
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

            $activation = Input::get('activation');

            if($activation === 'true'){
                return Redirect::to('user/profile/' . $user->id);
            }

            if(is_null($user->profile)){
                return Redirect::to('user/profile/' . $user->id);
            }

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
            $user = Sentry::getUserProvider()->findById($userId);
            $newPassword = $this->_generatePassword(8,8);

            if ($user->attemptResetPassword($resetCode, $newPassword)) {
                $data['newPassword'] = $newPassword;
                $data['email'] = $user->getLogin();

                Mail::send('emails.auth.newpassword', $data, function($m) use($data) {
                    $m->to($data['email'])->subject('ALiVE War Room - New Password Information');
                });

                Alert::success('Your password has been changed. Check your email for the new password.')->flash();
                return Redirect::to('/user/login');

            } else {
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
