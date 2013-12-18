<?php

class AdminServerController extends BaseController {

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
            $data['allServers'] = Server::paginate(10);
            return View::make('admin/server.index')->with($data);
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
            return Redirect::to('admin/server/')->withErrors($v)->withInput()->with($data);
        } else {

            if ($auth['isAdmin']) {

                $query = $input['query'];
                $type = $input['type'];

                switch($type){
                    case 'name':
                        $servers = Server::where('servers.name', 'LIKE', '%'.$query.'%');
                        break;
                    case 'hostname':
                        $servers = Server::where('servers.hostname', 'LIKE', '%'.$query.'%');
                        break;
                    case 'ip':
                        $servers = Server::where('servers.ip', 'LIKE', '%'.$query.'%');
                        break;
                }

                $servers = $servers->paginate(10);

                $data['links'] = $servers->links();
                $data['allServers'] = $servers;
                $data['query'] = $query;

                return View::make('admin/server.search')->with($data);

            } else {
                Alert::error('Sorry.')->flash();
                return Redirect::to('admin/user/show/'.$auth['userId']);
            }
        }
    }

    // Create ----------------------------------------------------------------------------------------------------------

    public function getCreate($id)
    {

        $data = get_default_data();
        $auth = $data['auth'];

        $data['clan'] = Clan::find($id);

        return View::make('admin/server.create')->with($data);

    }

    public function postCreate($id)
    {

        $data = get_default_data();
        $auth = $data['auth'];

        $input = array(
            'name' => Input::get('name'),
            'hostname' => Input::get('hostname'),
            'ip' => Input::get('ip'),
            'note' => Input::get('note'),
        );

        $rules = array (
            'name' => 'required',
            'hostname' => 'required',
            'ip' => 'required',
        );

        $v = Validator::make($input, $rules);

        if ($v->fails()) {
            return Redirect::to('admin/server/create/'.$id)->withErrors($v)->withInput()->with($data);
        } else {

            $currentUser = $auth['user'];
            $profile = $auth['profile'];

            $clan = Clan::find($id);

            if (!$auth['isAdmin'] && !$auth['isLeader'] && !$auth['isOfficer']) {
                Alert::error('You don\'t have access to that group.')->flash();
                return Redirect::to('admin/clan/show/'.$id);
            }

            if(!$auth['isAdmin'] && $auth['isLeader'] && $profile->clan_id != $clan->id){
                Alert::error('Sorry.')->flash();
                return Redirect::to('admin/clan/show/'.$id);
            }

            if(!$auth['isAdmin'] && $auth['isOfficer'] && $profile->clan_id != $clan->id){
                Alert::error('Sorry.')->flash();
                return Redirect::to('admin/clan/show/'.$id);
            }

            $server = new Server;
            $server->name = $input['name'];
            $server->hostname = $input['hostname'];
            $server->ip = $input['ip'];
            $server->note = $input['note'];
            $server->clan_id = $id;
            $server->key = $this->_generatePassword(32);

            if($server->save()){
                Alert::success('You have created a server.')->flash();
                return Redirect::to('admin/clan/show/'.$id);
            }

        }
    }

    // Show ------------------------------------------------------------------------------------------------------------

    public function getShow($id)
    {

        $data = get_default_data();
        $auth = $data['auth'];

        try {
            $server = Server::findOrFail($id);
            $data['server'] = $server;

            return View::make('admin/server.show')->with($data);

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

        $server = Server::find($id);
        $clan = $server->clan;

        if ($auth['isAdmin']) {
            $data['server'] = $server;
            $data['clan'] = $clan;
            return View::make('admin/server.edit')->with($data);
        } elseif ($auth['isLeader'] || $auth['isOfficer']) {
            if($profile->clan_id == $clan->id){
                $data['server'] = $server;
                $data['clan'] = $clan;
                return View::make('admin/server.edit')->with($data);
            }else{
                Alert::error('You don\'t have access to that group.')->flash();
                return Redirect::to('admin/clan/show/'.$id);
            }
        } else {
            Alert::error('You don\'t have access to that group.')->flash();
            return Redirect::to('admin/clan/show/'.$id);
        }
    }

    public function postEdit($id)
    {

        $data = get_default_data();
        $auth = $data['auth'];

        $input = array(
            'name' => Input::get('name'),
            'hostname' => Input::get('hostname'),
            'ip' => Input::get('ip'),
            'note' => Input::get('note'),
        );

        $rules = array (
            'name' => 'required',
            'hostname' => 'required',
            'ip' => 'required',
            'note' => 'required',
        );

        $v = Validator::make($input, $rules);

        if ($v->fails()) {
            return Redirect::to('admin/server/edit/'.$id)->withErrors($v)->withInput()->with($data);
        } else {

            $currentUser = $auth['user'];
            $profile = $auth['profile'];
            $clan = $profile->clan;

            if (!$auth['isAdmin'] && !$auth['isLeader'] && !$auth['isOfficer']) {
                Alert::error('You don\'t have access to that group.')->flash();
                return Redirect::to('admin/clan/show/'.$id);
            }

            if(!$auth['isAdmin'] && $auth['isLeader'] && $profile->clan_id != $clan->id){
                Alert::error('Sorry.')->flash();
                return Redirect::to('admin/clan/show/'.$id);
            }

            if(!$auth['isAdmin'] && $auth['isOfficer'] && $profile->clan_id != $clan->id){
                Alert::error('Sorry.')->flash();
                return Redirect::to('admin/clan/show/'.$id);
            }

            $server = Server::find($id);

            $server->name = $input['name'];
            $server->hostname = $input['hostname'];
            $server->ip = $input['ip'];
            $server->note = $input['note'];

            if($server->save()){
                Alert::success('Server updated.')->flash();
                return Redirect::to('admin/clan/show/'.$clan->id);
            }

        }
    }

    // Delete ----------------------------------------------------------------------------------------------------------

    public function getConfig($id)
    {

        $data = get_default_data();
        $auth = $data['auth'];

        $currentUser = $auth['user'];
        $profile = $auth['profile'];

        $clan = Clan::find($id);

        if (!$auth['isAdmin'] && !$auth['isLeader'] && !$auth['isOfficer']) {
            Alert::error('You don\'t have access to that group.')->flash();
            return Redirect::to('admin/clan/show/'.$id);
        }

        if(!$auth['isAdmin'] && $auth['isLeader'] && $profile->clan_id != $clan->id){
            Alert::error('Sorry.')->flash();
            return Redirect::to('admin/clan/show/'.$id);
        }

        if(!$auth['isAdmin'] && $auth['isOfficer'] && $profile->clan_id != $clan->id){
            Alert::error('Sorry.')->flash();
            return Redirect::to('admin/clan/show/'.$id);
        }

        $data['clan'] = $clan;

        $content = View::make('admin/server.config')->with($data);

        $headers = array(
            'Content-Type' => 'application/x-tt',
            'Content-Disposition' => 'inline;filename=config.cfg',
        );
        return Response::make( $content, 200, $headers );

    }

    // Delete ----------------------------------------------------------------------------------------------------------

    public function postDelete($id)
    {

        $data = get_default_data();
        $auth = $data['auth'];

        $currentUser = $auth['user'];
        $profile = $auth['profile'];

        $clan = $profile->clan;

        if (!$auth['isAdmin'] && !$auth['isLeader']) {
            Alert::error('You don\'t have access to that group.')->flash();
            return Redirect::to('admin/clan/show/'.$id);
        }

        if(!$auth['isAdmin'] && $auth['isLeader'] && $profile->clan_id != $clan->id){
            Alert::error('You don\'t have access to that group.')->flash();
            return Redirect::to('admin/clan/show/'.$id);
        }

        $server = Server::find($id);

        $server->delete();

        Alert::success('Server deleted.')->flash();
        return Redirect::to('admin/clan/show/'.$clan->id);

    }

    // Password Generate -----------------------------------------------------------------------------------------------

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
