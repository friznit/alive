<?php

class AdminGroupController extends BaseController {

    public function __construct()
    {
        $this->beforeFilter('admin_auth');
    }

    public function index()
    {
        try {
            // Find the current user
            if ( ! Sentry::check()) {
                // User is not logged in, or is not activated
                Session::flash('error', 'You must be logged in to perform that action.');
                return Redirect::to('/');
            } else {
                // User is logged in
                $user = Sentry::getUser();

                // Get the user groups
                $data['myGroups'] = $user->getGroups();

                //Get all the available groups.
                $data['allGroups'] = Sentry::getGroupProvider()->findAll();


                return View::make('admin/group.index', $data);
            }
        } catch (Cartalyst\Sentry\Users\UserNotFoundException $e) {
            Session::flash('error', 'User was not found.');
            return Redirect::to('admin/group');
        }
    }

    public function create()
    {
        return View::make('admin/group.create');
    }

    public function store()
    {
        $input = array(
            'newGroup' => Input::get('newGroup')
        );

        $rules = array (
            'newGroup' => 'required|min:4'
        );

        $v = Validator::make($input, $rules);

        if ($v->fails()) {
            return Redirect::to('admin/group/create')->withErrors($v)->withInput();
        } else {
            try {
                // Create the group
                $group = Sentry::getGroupProvider()->create(array(

                    'name'        => $input['newGroup'],
                    'permissions' => array(
                        'admin' => Input::get('adminPermissions', 0),
                        'users' => Input::get('userPermissions', 0),
                    ),
                ));

                if ($group) {
                    Session::flash('success', 'New Group Created');
                    return Redirect::to('admin/group');
                } else {
                    Session::flash('error', 'New Group was not created');
                    return Redirect::to('admin/group');
                }
            } catch (Cartalyst\Sentry\Groups\NameRequiredException $e) {
                Session::flash('error', 'Name field is required');
                return Redirect::to('admin/group/create')->withErrors($v)->withInput();
            } catch (Cartalyst\Sentry\Groups\GroupExistsException $e) {
                Session::flash('error', 'Group already exists');
                return Redirect::to('admin/group/create')->withErrors($v)->withInput();
            }
        }
    }

    public function show($id)
    {
        try {
            // Find the group using the group id
            $data['group'] = Sentry::getGroupProvider()->findById($id);

            // Get the group permissions
            $data['groupPermissions'] = $data['group']->getPermissions();
        } catch (Cartalyst\Sentry\Groups\GroupNotFoundException $e) {
            Session::flash('error', 'Group does not exist.');
            return Redirect::to('groups');
        }

        return View::make('admin/group.show', $data);
    }

    public function edit($id)
    {
        try {
            // Find the group using the group id
            $data['group'] = Sentry::getGroupProvider()->findById($id);

        } catch (Cartalyst\Sentry\Groups\GroupNotFoundException $e) {
            Session::flash('error', 'Group does not exist.');
            return Redirect::to('groups');
        }

        return View::make('admin/group.edit', $data);
    }

    public function update($id)
    {
        $input = array(
            'name' => Input::get('name')
        );

        $rules = array (
            'name' => 'required|min:4'
        );

        $v = Validator::make($input, $rules);

        if ($v->fails()) {
            return Redirect::to('admin/group/'. $id . '/edit')->withErrors($v)->withInput();
        } else {
            try {
                // Find the group using the group id
                $group = Sentry::getGroupProvider()->findById($id);

                // Update the group details
                $group->name = $input['name'];
                $group->permissions = array(
                    'admin' => Input::get('adminPermissions', 0),
                    'users' => Input::get('userPermissions', 0),
                );

                // Update the group
                if ($group->save()) {
                    // Group information was updated
                    Session::flash('success', 'Group has been updated.');
                    return Redirect::to('admin/group');
                } else {
                    // Group information was not updated
                    Session::flash('error', 'There was a problem updating the group.');
                    return Redirect::to('admin/group/'. $id . '/edit')->withErrors($v)->withInput();
                }
            } catch (Cartalyst\Sentry\Groups\GroupExistsException $e) {
                Session::flash('error', 'Group already exists.');
                return Redirect::to('admin/group/'. $id . '/edit')->withErrors($v)->withInput();
            } catch (Cartalyst\Sentry\Groups\GroupNotFoundException $e) {
                Session::flash('error', 'Group was not found.');
                return Redirect::to('admin/group/'. $id . '/edit')->withErrors($v)->withInput();
            }
        }
    }

    public function destroy($id)
    {
        try {
            // Find the group using the group id
            $group = Sentry::getGroupProvider()->findById($id);

            // Delete the group
            if ($group->delete()) {
                // Group was successfully deleted
                Session::flash('success', 'Group has been deleted.');
                return Redirect::to('admin/group/');
            } else {
                // There was a problem deleting the group
                Session::flash('error', 'There was a problem deleting that group.');
                return Redirect::to('admin/group/');
            }
        } catch (Cartalyst\Sentry\Groups\GroupNotFoundException $e) {
            Session::flash('error', 'Group was not found.');
            return Redirect::to('admin/group/');
        }
    }

}