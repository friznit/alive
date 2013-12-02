<?php

class AdminUserController extends BaseController {

    public function __construct()
    {
        //Check CSRF token on POST
        $this->beforeFilter('csrf', array('on' => 'post'));

        // Get the Throttle Provider
        $throttleProvider = Sentry::getThrottleProvider();

        // Enable the Throttling Feature
        $throttleProvider->enable();
    }

    public function getIndex()
    {
        try {
            // Find the current user
            if ( Sentry::check()) {
                // Find the user using the user id
                $data['user'] = Sentry::getUser();

                if ( $data['user']->hasAccess('admin')) {

                    //return Sentry::getUserProvider()->getEmptyUser()->paginate(1);
                    //return Sentry::getUserProvider()->createModel()->with('groups')->paginate();
                    //$data['allUsers'] = Sentry::getUserProvider()->findAll();

                    $data['allUsers'] = Sentry::getUserProvider()->createModel()
                        ->leftJoin('throttle', 'throttle.user_id', '=', 'users.id')
                        ->leftJoin('profiles', 'profiles.user_id', '=', 'users.id')
                        ->paginate(10, array(
                            'users.id',
                            'users.email',
                            'users.activated',
                            'users.last_login',
                            'profiles.username',
                            'throttle.suspended',
                            'throttle.banned'
                        ));

                    //Assemble an array of each user's status
                    $data['userStatus'] = array();

                    foreach ($data['allUsers'] as $user) {
                        if ($user->isActivated()) {
                            $data['userStatus'][$user->id] = "Active";
                        } else {
                            $data['userStatus'][$user->id] = "Not Active";
                        }

                        //Check for suspension
                        if($user->suspended == '1') {
                            // User is Suspended
                            $data['userStatus'][$user->id] = "Suspended";
                        }

                        //Check for ban
                        if($user->banned == '1') {
                            // User is Banned
                            $data['userStatus'][$user->id] = "Banned";
                        }
                    }

                    return View::make('admin/user.index')->with($data);
                }

            } else {
                Alert::error('You are not logged in.')->flash();
                return Redirect::to('user/login');
            }
        } catch (Cartalyst\Sentry\UserNotFoundException $e) {
            Alert::error('There was a problem accessing your account.')->flash();
            return Redirect::to('admin');
        }
    }

    public function postSearch()
    {
        $input = array(
            'query' => Input::get('query'),
            'type' => Input::get('type')
        );

        $rules = array (
            'query' => 'required',
            'type' => 'required|alpha',
        );

        $v = Validator::make($input, $rules);

        if ($v->fails()) {
            return Redirect::to('admin/user/')->withErrors($v)->withInput();
        } else {

            $query = $input['query'];
            $type = $input['type'];

            try {
                // Find the current user
                if ( Sentry::check()) {
                    // Find the user using the user id
                    $data['user'] = Sentry::getUser();

                    if ( $data['user']->hasAccess('admin')) {

                        // get all users
                        $users =  Sentry::getUserProvider()->getEmptyUser()
                            ->join('throttle', 'throttle.user_id', '=', 'users.id');

                        switch($type){
                            case 'id':
                                $users = $users->where('users.id', $query);
                                break;
                            case 'email':
                                $users = $users->where('email', 'LIKE', '%'.$query.'%');
                                break;
                            case 'lastName':
                                $users = $users->where('last_name', 'LIKE', '%'.$query.'%');
                                break;
                        }

                        $users = $users->paginate(10);

                        //Assemble an array of each user's status
                        $data['userStatus'] = array();
                        foreach ($users as $user) {
                            if ($user->isActivated()) {
                                $data['userStatus'][$user->id] = "Active";
                            } else {
                                $data['userStatus'][$user->id] = "Not Active";
                            }

                            //Check for suspension
                            if($user->suspended == '1') {
                                // User is Suspended
                                $data['userStatus'][$user->id] = "Suspended";
                            }

                            //Check for ban
                            if($user->banned == '1') {
                                // User is Banned
                                $data['userStatus'][$user->id] = "Banned";
                            }
                        }

                        $data['links'] = $users->links();
                        $data['allUsers'] = $users;
                        $data['query'] = $query;

                        return View::make('admin/user.search')->with($data);
                    }

                } else {
                    Alert::error('You are not logged in.')->flash();
                    return Redirect::to('user/login');
                }
            } catch (Cartalyst\Sentry\UserNotFoundException $e) {
                Alert::error('There was a problem accessing your account.')->flash();
                return Redirect::to('admin');
            }
        }
    }

    public function getShow($id)
    {
        try {
            //Get the current user's id.
            Sentry::check();
            $currentUser = Sentry::getUser();

            //Do they have admin access?
            if ( $currentUser->hasAccess('admin') || $currentUser->getId() == $id) {
                //Either they are an admin, or:
                //They are not an admin, but they are viewing their own profile.
                $data['user'] = Sentry::getUserProvider()->findById($id);
                $data['myGroups'] = $data['user']->getGroups();
                return View::make('admin/user.show')->with($data);
            } else {
                Alert::error('You don\'t have access to that user.')->flash();
                return Redirect::to('admin/user');
            }

        } catch (Cartalyst\Sentry\Users\UserNotFoundException $e) {
            Alert::error('There was a problem accessing this account.')->flash();
            return Redirect::to('admin');
        }
    }

    public function getEdit($id)
    {
        try {
            //Get the current user's id.
            Sentry::check();
            $currentUser = Sentry::getUser();

            //Do they have admin access?
            if ( $currentUser->hasAccess('admin')) {
                $data['user'] = Sentry::getUserProvider()->findById($id);
                $data['userGroups'] = $data['user']->getGroups();
                $data['profile'] = $data['user']->profile;
                $data['allGroups'] = Sentry::getGroupProvider()->findAll();
                return View::make('admin/user.edit')->with($data);
            } elseif ($currentUser->getId() == $id) {
                //They are not an admin, but they are viewing their own profile.
                $data['user'] = Sentry::getUserProvider()->findById($id);
                $data['userGroups'] = $data['user']->getGroups();
                $data['profile'] = $data['user']->profile;
                return View::make('admin/user.edit')->with($data);
            } else {
                Alert::error('You don\'t have access to that user.')->flash();
                return Redirect::to('admin/user');
            }

        } catch (Cartalyst\Sentry\Users\UserNotFoundException $e) {
            Alert::error('There was a problem accessing this account.')->flash();
            return Redirect::to('admin');
        }
    }

    public function postEdit($id) {
        $input = array(
            'firstName' => Input::get('firstName'),
            'lastName' => Input::get('lastName'),
            'username' => Input::get('username'),
            'a2ID' => Input::get('a2ID'),
            'a3ID' => Input::get('a3ID'),
            'preferredClass' => Input::get('preferredClass'),
            'primaryProfile' => Input::get('primaryProfile'),
            'secondaryProfile' => Input::get('secondaryProfile'),
            'alias' => Input::get('alias'),
            'armaFace' => Input::get('armaFace'),
            'armaVoice' => Input::get('armaVoice'),
            'armaPitch' => Input::get('armaPitch'),
            'twitchStream' => Input::get('twitchStream'),
        );

        $rules = array (
            'firstName' => 'alpha',
            'lastName' => 'alpha',
            'username' => 'required',
        );

        $v = Validator::make($input, $rules);

        if ($v->fails()) {
            return Redirect::to('admin/user/edit/' . $id)->withErrors($v)->withInput();
        } else {
            try {
                //Get the current user's id.
                Sentry::check();
                $currentUser = Sentry::getUser();

                //Do they have admin access?
                if ( $currentUser->hasAccess('admin')  || $currentUser->getId() == $id) {
                    // Either they are an admin, or they are changing their own password.
                    // Find the user using the user id
                    $user = Sentry::getUserProvider()->findById($id);
                    $profile = $user->profile;

                    // Update the user details
                    $user->first_name = $input['firstName'];
                    $user->last_name = $input['lastName'];

                    // Update the user
                    if ($user->save()) {
                        // User information was updated
                        // update the user profile
                        //  'preferredClass' => Input::get('preferredClass'),
                        $profile->username = $input['username'];
                        $profile->alias = $input['alias'];
                        $profile->a2_id = $input['a2ID'];
                        $profile->a3_id = $input['a3ID'];
                        $profile->primary_profile = $input['primaryProfile'];
                        $profile->secondary_profile = $input['secondaryProfile'];
                        $profile->arma_face = $input['armaFace'];
                        $profile->arma_voice = $input['armaVoice'];
                        $profile->arma_pitch = $input['armaPitch'];
                        $profile->twitch_stream = $input['twitchStream'];

                        if ($profile->save()) {
                            Alert::success('Profile updated.')->flash();
                            return Redirect::to('admin/user/show/'. $id);
                        }
                    } else {
                        // User information was not updated
                        Alert::error('Profile could not be updated.')->flash();
                        return Redirect::to('admin/user/edit/' . $id);
                    }

                } else {
                    Alert::error('You don\'t have access to that user.')->flash();
                    return Redirect::to('admin');
                }
            } catch (Cartalyst\Sentry\Users\UserExistsException $e) {
                Alert::error('User already exists.')->flash();
                return Redirect::to('admin/user/edit/' . $id);
            } catch (Cartalyst\Sentry\Users\UserNotFoundException $e) {
                Alert::error('User was not found.')->flash();
                return Redirect::to('admin/user/edit/' . $id);
            }
        }
    }

    public function postChangeavatar($id) {

        $input = array(
            'avatar' => Input::file('avatar'),
        );

        $rules = array (
            'avatar' => 'mimes:jpeg,bmp,png',
        );

        $v = Validator::make($input, $rules);

        if ($v->fails()) {
            return Redirect::to('admin/user/edit/' . $id)->withErrors($v)->withInput();
        } else {
            try {
                //Get the current user's id.
                Sentry::check();
                $currentUser = Sentry::getUser();

                //Do they have admin access?
                if ( $currentUser->hasAccess('admin')  || $currentUser->getId() == $id) {
                    // Either they are an admin, or they are changing their own password.
                    // Find the user using the user id
                    $user = Sentry::getUserProvider()->findById($id);
                    $profile = $user->profile;

                    $profile->avatar->clear();
                    $profile->avatar = $input['avatar'];

                    if ($profile->save()) {
                        Alert::success('Profile updated.')->flash();
                        return Redirect::to('admin/user/show/'. $id);
                    } else {
                        // User information was not updated
                        Alert::error('Profile could not be updated.')->flash();
                        return Redirect::to('admin/user/edit/' . $id);
                    }

                } else {
                    Alert::error('You don\'t have access to that user.')->flash();
                    return Redirect::to('admin');
                }
            } catch (Cartalyst\Sentry\Users\UserExistsException $e) {
                Alert::error('User already exists.')->flash();
                return Redirect::to('admin/user/edit/' . $id);
            } catch (Cartalyst\Sentry\Users\UserNotFoundException $e) {
                Alert::error('User was not found.')->flash();
                return Redirect::to('admin/user/edit/' . $id);
            }
        }
    }

    public function postChangepassword($id)
    {
        $input = array(
            'oldPassword' => Input::get('oldPassword'),
            'newPassword' => Input::get('newPassword'),
            'newPassword_confirmation' => Input::get('newPassword_confirmation')
        );

        $rules = array (
            'oldPassword' => 'required|min:6',
            'newPassword' => 'required|min:6|confirmed',
            'newPassword_confirmation' => 'required'
        );

        $v = Validator::make($input, $rules);

        if ($v->fails()) {
            return Redirect::to('admin/user/edit/' . $id)->withErrors($v)->withInput();
        } else {
            try {
                //Get the current user's id.
                Sentry::check();
                $currentUser = Sentry::getUser();

                //Do they have admin access?
                if ( $currentUser->hasAccess('admin')  || $currentUser->getId() == $id) {
                    // Either they are an admin, or they are changing their own password.
                    $user = Sentry::getUserProvider()->findById($id);
                    if ($user->checkHash($input['oldPassword'], $user->getPassword())) {
                        //The oldPassword matches the current password in the DB. Proceed.
                        $user->password = $input['newPassword'];

                        if ($user->save()) {
                            // User saved
                            Alert::success('Your password has been changed.')->flash();
                            return Redirect::to('admin/user/show/'. $id);
                        } else {
                            // User not saved
                            Alert::error('Your password could not be changed.')->flash();
                            return Redirect::to('admin/user/edit/' . $id);
                        }
                    } else {
                        // The oldPassword did not match the password in the database. Abort.
                        Alert::error('You did not provide the correct password.')->flash();
                        return Redirect::to('admin/user/edit/' . $id);
                    }
                } else {
                    Alert::error('You don\'t have access to that user.')->flash();
                    return Redirect::to('/');
                }
            } catch (Cartalyst\Sentry\Users\LoginRequiredException $e) {
                Alert::error('Login field required.')->flash();
                return Redirect::to('admin/user/edit/' . $id);
            } catch (Cartalyst\Sentry\Users\UserExistsException $e) {
                Alert::error('User already exists.')->flash();
                return Redirect::to('admin/user/edit/' . $id);
            } catch (Cartalyst\Sentry\Users\UserNotFoundException $e) {
                Alert::error('User was not found.')->flash();
                return Redirect::to('admin/user/edit/' . $id);
            }
        }
    }


    public function postChangeemail($id)
    {
        $input = array(
            'oldEmail' => Input::get('oldEmail'),
            'newEmail' => Input::get('newEmail'),
            'newEmail_confirmation' => Input::get('newEmail_confirmation')
        );

        $rules = array (
            'oldEmail' => 'required|email',
            'newEmail' => 'required|email|confirmed',
            'newEmail_confirmation' => 'required'
        );

        $v = Validator::make($input, $rules);

        if ($v->fails()) {
            return Redirect::to('admin/user/edit/' . $id)->withErrors($v)->withInput();
        } else {
            try {
                //Get the current user's id.
                Sentry::check();
                $currentUser = Sentry::getUser();

                //Do they have admin access?
                if ( $currentUser->hasAccess('admin')  || $currentUser->getId() == $id) {
                    // Either they are an admin, or they are changing their own password.
                    $user = Sentry::getUserProvider()->findById($id);

                    //The oldPassword matches the current password in the DB. Proceed.
                    $user->email = $input['newEmail'];

                    if ($user->save()) {
                        // User saved
                        Alert::success('Your email has been changed.')->flash();
                        return Redirect::to('admin/user/show/'. $id);
                    } else {
                        // User not saved
                        Alert::error('Your email could not be changed.')->flash();
                        return Redirect::to('admin/user/edit/' . $id);
                    }
                } else {
                    Alert::error('You don\'t have access to that user.')->flash();
                    return Redirect::to('/');
                }
            } catch (Cartalyst\Sentry\Users\LoginRequiredException $e) {
                Alert::error('Login field required.')->flash();
                return Redirect::to('admin/user/edit/' . $id);
            } catch (Cartalyst\Sentry\Users\UserExistsException $e) {
                Alert::error('User already exists.')->flash();
                return Redirect::to('admin/user/edit/' . $id);
            } catch (Cartalyst\Sentry\Users\UserNotFoundException $e) {
                Alert::error('User was not found.')->flash();
                return Redirect::to('admin/user/edit/' . $id);
            }
        }
    }

    public function postUpdatememberships($id)
    {
        try {
            //Get the current user's id.
            Sentry::check();
            $currentUser = Sentry::getUser();

            //Do they have admin access?
            if ( $currentUser->hasAccess('admin')) {
                $user = Sentry::getUserProvider()->findById($id);
                $allGroups = Sentry::getGroupProvider()->findAll();
                $permissions = Input::get('permissions');

                $statusMessage = '';
                foreach ($allGroups as $group) {

                    if (isset($permissions[$group->id])) {
                        //The user should be added to this group
                        if ($user->addGroup($group)) {
                            $statusMessage .= "Added to " . $group->name . "<br />";
                        } else {
                            $statusMessage .= "Could not be added to " . $group->name . "<br />";
                        }
                    } else {
                        // The user should be removed from this group
                        if ($user->removeGroup($group)) {
                            $statusMessage .= "Removed from " . $group->name . "<br />";
                        } else {
                            $statusMessage .= "Could not be removed from " . $group->name . "<br />";
                        }
                    }

                }
                Alert::info($statusMessage)->flash();
                return Redirect::to('admin/user/show/'. $id);
            } else {
                Alert::error('You don\'t have access to that user.')->flash();
                return Redirect::to('admin');
            }

        } catch (Cartalyst\Sentry\Users\UserNotFoundException $e) {
            Alert::error('User was not found.')->flash();
            return Redirect::to('admin/user/edit/' . $id);
        } catch (Cartalyst\Sentry\Groups\GroupNotFoundException $e) {
            Alert::error('Trying to access unidentified Groups.')->flash();
            return Redirect::to('admin/user/edit/' . $id);
        }
    }

    public function getSuspend($id)
    {
        try {
            //Get the current user's id.
            Sentry::check();
            $currentUser = Sentry::getUser();

            //Do they have admin access?
            if ( $currentUser->hasAccess('admin')) {
                $data['user'] = Sentry::getUserProvider()->findById($id);
                return View::make('admin/user.suspend')->with($data);
            } else {
                Alert::error('You are not allowed to do that.')->flash();
                return Redirect::to('admin');
            }

        } catch (Cartalyst\Sentry\UserNotFoundException $e) {
            Alert::error('There was a problem accessing that user\s account.')->flash();
            return Redirect::to('admin/user');
        }
    }

    public function postSuspend($id)
    {
        $input = array(
            'suspendTime' => Input::get('suspendTime')
        );

        $rules = array (
            'suspendTime' => 'required|numeric'
        );

        $v = Validator::make($input, $rules);

        if ($v->fails()) {
            return Redirect::to('admin/user/suspend/' . $id)->withErrors($v)->withInput();
        } else {
            try {
                //Prep for suspension
                $throttle = Sentry::getThrottleProvider()->findByUserId($id);

                //Set suspension time
                $throttle->setSuspensionTime($input['suspendTime']);

                // Suspend the user
                $throttle->suspend();

                //Done.  Return to user page.
                Alert::success("User has been suspended for " . $input['suspendTime'] . " minutes.")->flash();
                return Redirect::to('admin/user');

            } catch (Cartalyst\Sentry\UserNotFoundException $e) {
                Alert::error('There was a problem accessing that user\s account.')->flash();
                return Redirect::to('admin/user');
            }
        }
    }

    public function postDelete($id)
    {
        try {
            // Find the user using the user id
            $user = Sentry::getUserProvider()->findById($id);

            // Delete the user
            if ($user->delete()) {
                // User was successfully deleted
                Alert::success('That user has been deleted.')->flash();
                return Redirect::to('admin/user');
            } else {
                // There was a problem deleting the user
                Alert::error('There was a problem deleting that user.')->flash();
                return Redirect::to('admin/user');
            }
        } catch (Cartalyst\Sentry\Users\UserNotFoundException $e) {
            Alert::error('There was a problem accessing that user\s account.')->flash();
            return Redirect::to('admin/user');
        }
    }

    public function getClearReset($userId = null)
    {
        try {
            // Find the user
            $user = Sentry::getUserProvider()->findById($userId);

            // Clear the password reset code
            $user->clearResetPassword();

            echo "clear.";
        } catch (Cartalyst\Sentry\Users\UserNotFoundException $e) {
            echo 'User does not exist';
        }
    }
}
