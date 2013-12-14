<?php

class AdminGroupController extends BaseController {

    public function __construct()
    {
        //Check CSRF token on POST
        $this->beforeFilter('csrf', array('on' => 'post'));

        // Authenticated access only
        $this->beforeFilter('auth');

    }

    // Lists -----------------------------------------------------------------------------------------------------------

    public function index()
    {
        $data = get_default_data();
        $auth = $data['auth'];

        if ($auth['isAdmin']) {
            $data['allGroups'] = Sentry::getGroupProvider()->findAll();
            return View::make('admin/group.index', $data);
        }else{
            Alert::error('Sorry.')->flash();
            return Redirect::to('admin/user/show/'.$auth['userId']);
        }
    }

    // Create ----------------------------------------------------------------------------------------------------------

    public function create()
    {
        $data = get_default_data();
        $auth = $data['auth'];

        if ($auth['isAdmin']) {
            return View::make('admin/group.create', $data);
        }else{
            Alert::error('Sorry.')->flash();
            return Redirect::to('admin/user/show/'.$auth['userId']);
        }
    }

    public function store()
    {

        $data = get_default_data();
        $auth = $data['auth'];

        $input = array(
            'newGroup' => Input::get('newGroup')
        );

        $rules = array (
            'newGroup' => 'required|min:4'
        );

        $v = Validator::make($input, $rules);

        if ($v->fails()) {
            return Redirect::to('admin/group/create')->withErrors($v)->withInput()->with($data);
        } else {

            if ($auth['isAdmin']) {

                try {
                    $group = Sentry::getGroupProvider()->create(array(

                        'name'        => $input['newGroup'],
                        'permissions' => array(
                            'admin' => Input::get('adminPermissions', 0),
                            'users' => Input::get('userPermissions', 0),
                            'clans' => Input::get('clansPermissions', 0),
                            'clan' => Input::get('clanPermissions', 0),
                            'clanmembers' => Input::get('clanMemberPermissions', 0),
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
            }else{
                Alert::error('Sorry.')->flash();
                return Redirect::to('admin/user/show/'.$auth['userId']);
            }
        }
    }

    // Show ------------------------------------------------------------------------------------------------------------

    public function show($id)
    {

        $data = get_default_data();
        $auth = $data['auth'];

        if ($auth['isAdmin']) {

            try {

                $data['group'] = Sentry::getGroupProvider()->findById($id);
                $data['groupPermissions'] = $data['group']->getPermissions();
                return View::make('admin/group.show', $data);

            } catch (Cartalyst\Sentry\Groups\GroupNotFoundException $e) {
                Session::flash('error', 'Group does not exist.');
                return Redirect::to('groups');
            }

        }else{
            Alert::error('Sorry.')->flash();
            return Redirect::to('admin/user/show/'.$auth['userId']);
        }
    }

    // Edit ------------------------------------------------------------------------------------------------------------

    public function edit($id)
    {

        $data = get_default_data();
        $auth = $data['auth'];

        if ($auth['isAdmin']) {

            try {

                $data['group'] = Sentry::getGroupProvider()->findById($id);
                return View::make('admin/group.edit', $data);

            } catch (Cartalyst\Sentry\Groups\GroupNotFoundException $e) {
                Session::flash('error', 'Group does not exist.');
                return Redirect::to('groups');
            }
        }else{
            Alert::error('Sorry.')->flash();
            return Redirect::to('admin/user/show/'.$auth['userId']);
        }
    }

    public function update($id)
    {

        $data = get_default_data();
        $auth = $data['auth'];

        $input = array(
            'name' => Input::get('name')
        );

        $rules = array (
            'name' => 'required|min:4'
        );

        $v = Validator::make($input, $rules);

        if ($v->fails()) {
            return Redirect::to('admin/group/'. $id . '/edit')->withErrors($v)->withInput()->with($data);
        } else {

            if ($auth['isAdmin']) {

                try {
                    $group = Sentry::getGroupProvider()->findById($id);

                    $group->name = $input['name'];
                    $group->permissions = array(
                        'admin' => Input::get('adminPermissions', 0),
                        'users' => Input::get('userPermissions', 0),
                        'clans' => Input::get('clansPermissions', 0),
                        'clan' => Input::get('clanPermissions', 0),
                        'clanmembers' => Input::get('clanMemberPermissions', 0),
                    );

                    if ($group->save()) {
                        Session::flash('success', 'Group updated.');
                        return Redirect::to('admin/group');
                    } else {
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
            }else{
                Alert::error('Sorry.')->flash();
                return Redirect::to('admin/user/show/'.$auth['userId']);
            }
        }
    }

    // Delete ----------------------------------------------------------------------------------------------------------

    public function destroy($id)
    {

        $data = get_default_data();
        $auth = $data['auth'];

        if ($auth['isAdmin']) {

            try {
                $group = Sentry::getGroupProvider()->findById($id);

                if ($group->delete()) {
                    Session::flash('success', 'Group has been deleted.');
                    return Redirect::to('admin/group/');
                } else {
                    Session::flash('error', 'There was a problem deleting that group.');
                    return Redirect::to('admin/group/');
                }
            } catch (Cartalyst\Sentry\Groups\GroupNotFoundException $e) {
                Session::flash('error', 'Group was not found.');
                return Redirect::to('admin/group/');
            }
        }else{
            Alert::error('Sorry.')->flash();
            return Redirect::to('admin/user/show/'.$auth['userId']);
        }
    }

}
