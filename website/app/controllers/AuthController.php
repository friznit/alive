<?php

class AuthController extends BaseController {

    public function login()
    {
        try
        {
            // Set login credentials
            $credentials = array(
                'email'    => Input::get('email') ?: null,
                'password' => Input::get('password') ?: null
            );

            // Authenticate our user and log them in
            $user = Sentry::authenticate($credentials, Input::get('remember_me') ?: false);

            // Tell them what a great job they did logging in.
            Alert::success(trans('success/authorize.login.successful'))->flash();

            // Send them where they wanted to go
            return Redirect::intended('/');

        }
        catch (Cartalyst\Sentry\Users\LoginRequiredException $e)
        {
            Alert::error(trans('errors/authorize.login.required'))->flash();
        }
        catch (Cartalyst\Sentry\Users\PasswordRequiredException $e)
        {
            Alert::error(trans('errors/authorize.login.password.required'))->flash();
        }
        catch (Cartalyst\Sentry\Users\WrongPasswordException $e)
        {
            Alert::error(trans('errors/authorize.login.password.wrong'))->flash();
        }
        catch (Cartalyst\Sentry\Users\UserNotFoundException $e)
        {
            Alert::error(trans('errors/authorize.login.user.found'))->flash();
        }
        catch (Cartalyst\Sentry\Users\UserNotActivatedException $e)
        {
            Alert::error(trans('errors/authorize.login.user.activated'))->flash();
        }
            // The following is only required if throttle is enabled
        catch (Cartalyst\Sentry\Throttling\UserSuspendedException $e)
        {
            Alert::error(trans('errors/authorize.login.user.suspended'))->flash();
        }
        catch (Cartalyst\Sentry\Throttling\UserBannedException $e)
        {
            Alert::error(trans('errors/authorize.login.user.banned'))->flash();
        }

        return Redirect::back()->withInput(Input::except('password'));
    }

    public function logout()
    {
        Sentry::logout();

        Alert::success(trans('success/authorize.logout.successful'))->flash();

        return Redirect::to('/');
    }
}