<?php

class AdminAOController extends BaseController {

    public function __construct()
    {
        //Check CSRF token on POST
        $this->beforeFilter('csrf', array('on' => 'post'));

        // Authenticated access only
        $this->beforeFilter('auth');

    }

    // List ------------------------------------------------------------------------------------------------------------

    public function getIndex()
    {

        $data = get_default_data();
        $auth = $data['auth'];

        if ($auth['isAdmin']) {
            $data['allAOs'] = AO::paginate(10);
            return View::make('admin/AO.index')->with($data);
        } else {
            Alert::error('Sorry.')->flash();
            return Redirect::to('admin/user/show/'.$auth['userId']);
        }
    }

    public function postSearch()
    {

        $data = get_default_data();
        $auth = $data['auth'];

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
            return Redirect::to('admin/AO/')->withErrors($v)->withInput()->with($data);
        } else {

            if ($auth['isAdmin']) {

                $query = $input['query'];
                $type = $input['type'];

                switch($type){
                    case 'name':
                        $aos = AO::where('AO.name', 'LIKE', '%'.$query.'%');
                        break;
                    case 'size':
                        $aos = AO::where('AO.size', '=>', '%'.$query.'%');
                        break;
                }

                $aos = $aos->paginate(10);

                $data['links'] = $aos->links();
                $data['allAOs'] = $aos;
                $data['query'] = $query;

                return View::make('admin/AO.search')->with($data);

            } else {
                Alert::error('Sorry.')->flash();
                return Redirect::to('admin/user/show/'.$auth['userId']);
            }
        }
    }

    // Create ----------------------------------------------------------------------------------------------------------

    public function getCreate()
    {

        $data = get_default_data();
        $auth = $data['auth'];

        return View::make('admin/AO.create')->with($data);

    }

    public function postCreate()
    {

        $data = get_default_data();
        $auth = $data['auth'];

        $input = array(
            'name' => Input::get('name'),
            'size' => Input::get('size'),
            'configName' => Input::get('configName'),
            'imageMapX' => Input::get('imageMapX'),
			'imageMapY' => Input::get('imageMapY'),
			'latitude' => Input::get('latitude'),
			'longitude' => Input::get('longitude'),
        );

        $rules = array (
            'name' => 'required',
            'configName' => 'required',
            'imageMapX' => 'required',
			'imageMapY' => 'required',
        );

        $v = Validator::make($input, $rules);

        if ($v->fails()) {
            return Redirect::to('admin/AO/create/'.$id)->withErrors($v)->withInput()->with($data);
        } else {

            $currentUser = $auth['user'];
            $profile = $auth['profile'];

            if (!$auth['isAdmin']) {
                Alert::error('You don\'t have access to do that.')->flash();
                return Redirect::to('admin/ao/index');
            }

            $ao = new AO;
            $ao->name = $input['name'];
            $ao->size = $input['size'];
            $ao->configName = $input['configName'];
            $ao->imageMapX = $input['imageMapX'];
            $ao->imageMapY = $input['imageMapY'];
			$ao->latitude = $input['latitude'];
			$ao->longitude = $input['longitude'];

            if($ao->save()){
                Alert::success('You have successfully created an Area of Operation.')->flash();
                return Redirect::to('admin/ao/index');
            }

        }
    }

    // Show ------------------------------------------------------------------------------------------------------------

    public function getShow($id)
    {

        $data = get_default_data();
        $auth = $data['auth'];

        try {
            $ao = AO::findOrFail($id);
            $data['ao'] = $ao;

            return View::make('admin/AO.show')->with($data);

        } catch (ModelNotFoundException $e) {
            return Redirect::to('warroom');
        }

    }

    // Edit ------------------------------------------------------------------------------------------------------------

    public function getEdit($id)
    {

        $data = get_default_data();
        $auth = $data['auth'];

        $currentUser = $auth['user'];
        $profile = $auth['profile'];

        $ao = AO::find($id);

        if ($auth['isAdmin']) {
            $data['ao'] = $ao;
            return View::make('admin/AO.edit')->with($data);
        } else {
            Alert::error('You don\'t have access to do that.')->flash();
            return Redirect::to('admin/ao/show/'. $ao->id);
        }
    }

    public function postEdit($id)
    {

        $data = get_default_data();
        $auth = $data['auth'];

        $input = array(
            'name' => Input::get('name'),
            'size' => Input::get('size'),
            'configName' => Input::get('configName'),
            'imageMapX' => Input::get('imageMapX'),
			'imageMapY' => Input::get('imageMapY'),
			'latitude' => Input::get('latitude'),
			'longitude' => Input::get('longitude'),
        );

        $rules = array (
            'name' => 'required',
            'configName' => 'required',
            'imageMapX' => 'required',
			'imageMapY' => 'required',
        );

        $v = Validator::make($input, $rules);
		
		 if ($v->fails()) {
            return Redirect::to('admin/ao/edit/'.$id)->withErrors($v)->withInput()->with($data);
        } else {

            $currentUser = $auth['user'];
            $profile = $auth['profile'];

            if (!$auth['isAdmin']) {
                Alert::error('You don\'t have access to do that.')->flash();
                return Redirect::to('admin/ao/show/'. $id);
            }
            
			$ao = AO::find($id);
			$ao->name = $input['name'];
            $ao->size = $input['size'];
            $ao->configName = $input['configName'];
            $ao->imageMapX = $input['imageMapX'];
            $ao->imageMapY = $input['imageMapY'];
			$ao->latitude = $input['latitude'];
			$ao->longitude = $input['longitude'];
			
            if($ao->save()){
                Alert::success('You have updated the Area of Operation.')->flash();
                return Redirect::to('admin/ao/show/'. $id);
            }

        }
    }
	
	// Change Images ----------------------------------------------------------------------------------------------------
	
	public function postChangeimage($id)
    {

        $data = get_default_data();
        $auth = $data['auth'];

        $input = array(
            'image' => Input::file('image'),
        );

        $rules = array (
            'image' => 'mimes:jpeg,bmp,png',
        );

        $v = Validator::make($input, $rules);

        if ($v->fails()) {
            return Redirect::to('admin/ao/edit/' . $id)->withErrors($v)->withInput()->with($data);
        } else {

            try {

                $currentUser = $auth['user'];
                $profile = $auth['profile'];

                $ao = AO::find($id);

                if (!$auth['isAdmin']) {
                    Alert::error('You don\'t have access to that AO.')->flash();
                    return Redirect::to('admin/ao/show/'.$id);
                }

                $ao->image->clear();
                $ao->image = $input['image'];

                if ($ao->save()) {
                    Alert::success('Area of Operation updated.')->flash();
                    return Redirect::to('admin/ao/show/'. $id);
                } else {
                    Alert::error('Area of Operation could not be updated.')->flash();
                    return Redirect::to('admin/ao/edit/' . $id);
                }

            } catch (Cartalyst\Sentry\Users\UserNotFoundException $e) {
                Alert::error('User was not found.')->flash();
                return Redirect::to('user/login' . $id);
            }
        }
    }

	public function postChangepic($id)
    {

        $data = get_default_data();
        $auth = $data['auth'];

        $input = array(
            'pic' => Input::file('pic'),
        );

        $rules = array (
            'pic' => 'mimes:jpeg,bmp,png',
        );

        $v = Validator::make($input, $rules);

        if ($v->fails()) {
            return Redirect::to('admin/ao/edit/' . $id)->withErrors($v)->withInput()->with($data);
        } else {

            try {

                $currentUser = $auth['user'];
                $profile = $auth['profile'];

                $ao = AO::find($id);

                if (!$auth['isAdmin']) {
                    Alert::error('You don\'t have access to that AO.')->flash();
                    return Redirect::to('admin/ao/show/'.$id);
                }

                $ao->pic->clear();
                $ao->pic = $input['pic'];

                if ($ao->save()) {
                    Alert::success('Area of Operation updated.')->flash();
                    return Redirect::to('admin/ao/show/'. $id);
                } else {
                    Alert::error('Area of Operation could not be updated.')->flash();
                    return Redirect::to('admin/ao/edit/' . $id);
                }

            } catch (Cartalyst\Sentry\Users\UserNotFoundException $e) {
                Alert::error('User was not found.')->flash();
                return Redirect::to('user/login' . $id);
            }
        }
    }
    // Delete ----------------------------------------------------------------------------------------------------------

    public function postDelete($id)
    {

        $data = get_default_data();
        $auth = $data['auth'];

        $currentUser = $auth['user'];
        $profile = $auth['profile'];

        if (!$auth['isAdmin']) {
            Alert::error('You don\'t have access to that AO.')->flash();
            return Redirect::to('admin/ao/show/'.$id);
        }

        $ao = AO::find($id);
		$name = $ao->name;
        $ao->delete();

        Alert::success('Area of Operation deleted.')->flash();
        return Redirect::to('admin/ao/index');

    }

}
