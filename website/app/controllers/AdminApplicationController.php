<?php

class AdminApplicationController extends BaseController {

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

        $data['allClans'] = Clan::where('allow_applicants',1)->paginate(10);
        $data['applications'] = $auth['user']->applications;
        return View::make('admin/application.index')->with($data);

    }

    // Show ------------------------------------------------------------------------------------------------------------

    public function getShowapplicant($id)
    {

        $data = get_default_data();
        $auth = $data['auth'];

        $currentUser = $auth['user'];
        $profile = $auth['profile'];

        $application = Application::find($id);
        $clan = $application->clan;
        $user_id = $currentUser->getId();

        if(!$auth['isAdmin'] && $application->user_id != $user_id){
            Alert::error('You don\'t have access to that application.')->flash();
            return Redirect::to('admin/user/show/'.$user_id);
        }

        $data['application'] = $application;
        $data['clan'] = $clan;

        return View::make('admin/application.show_applicant')->with($data);
    }

    public function getShowrecipient($id)
    {

        $data = get_default_data();
        $auth = $data['auth'];

        $currentUser = $auth['user'];
        $profile = $auth['profile'];

        $application = Application::find($id);
        $clan = $application->clan;

        if (!$auth['isAdmin'] && $profile->clan_id != $clan->id) {
            Alert::error('You don\'t have access to that application.')->flash();
            return Redirect::to('admin/clan/show/'. $clan->id);
        }

        $data['application'] = $application;

        return View::make('admin/application.show_recipient')->with($data);
    }

    // Update ----------------------------------------------------------------------------------------------------------

    public function postUpdateapplicant($id)
    {

        $data = get_default_data();
        $auth = $data['auth'];

        $input = array(
            'note' => Input::get('note'),
        );

        $rules = array (
            'note' => 'required',
        );

        $v = Validator::make($input, $rules);

        if ($v->fails()) {
            return Redirect::to('admin/application/showapplicant/' . $id)->withErrors($v)->withInput()->with($data);
        } else {

            $currentUser = $auth['user'];
            $profile = $auth['profile'];

            $application = Application::find($id);
            $clan = $application->clan;
            $user_id = $currentUser->getId();

            if(!$auth['isAdmin'] && $application->user_id != $user_id){
                Alert::error('You don\'t have access to that application.')->flash();
                return Redirect::to('admin/user/show/'.$user_id);
            }

            $application->note = $input['note'];
            $application->save();

            $data['application'] = $application;

            Alert::success('Application updated.')->flash();
            return View::make('admin/application.show_applicant')->with($data);

        }
    }

    public function postUpdaterecipient($id)
    {

        $data = get_default_data();
        $auth = $data['auth'];

        $input = array(
            'response' => Input::get('response'),
        );

        $rules = array (
            'response' => 'required',
        );

        $v = Validator::make($input, $rules);

        if ($v->fails()) {
            return Redirect::to('admin/application/showrecipient/' . $id)->withErrors($v)->withInput()->with($data);
        } else {

            $currentUser = $auth['user'];
            $profile = $auth['profile'];

            $application = Application::find($id);
            $clan = $application->clan;

            if (!$auth['isAdmin'] && $profile->clan_id != $clan->id) {
                Alert::error('You don\'t have access to that application.')->flash();
                return Redirect::to('admin/clan/show/'. $clan->id);
            }

            $application->response = $input['response'];
            $application->save();

            $data['application'] = $application;

            Alert::success('Application updated.')->flash();
            return View::make('admin/application.show_recipient')->with($data);

        }
    }

    // Lodge -----------------------------------------------------------------------------------------------------------

    public function getLodge($id)
    {

        $data = get_default_data();
        $auth = $data['auth'];

        $currentUser = $auth['user'];
        $profile = $auth['profile'];
        $applications = $currentUser->applications;

        if($auth['isGrunt'] || $auth['isOfficer'] || $auth['isLeader']){
            Alert::success('You already belong to an active group, you will need to leave this group to join a new one.')->flash();
            return Redirect::to('admin/clan/show/'. $profile->clan_id);
        }

        if($profile->clan_id == 0){
            $data['countries'] = DB::table('countries')->lists('name','iso_3166_2');
            $data['user'] = $currentUser;
            $data['profile'] = $profile;
            $data['applications'] = $applications;
            $data['clan'] = Clan::find($id);
            return View::make('admin/application.lodge')->with($data);
        }else{
            Alert::success('You already belong to an active group, you will need to leave this group to create a new one.')->flash();
            return Redirect::to('admin/clan/show/'. $profile->clan_id);
        }
    }

    public function postLodge($id)
    {

        $data = get_default_data();
        $auth = $data['auth'];

        $input = array(
            'note' => Input::get('note'),
        );

        $rules = array (
            'note' => 'required'
        );

        $v = Validator::make($input, $rules);

        if ($v->fails()) {
            return Redirect::to('admin/application/lodge/' . $id)->withErrors($v)->withInput()->with($data);
        } else {

            $currentUser = $auth['user'];
            $profile = $auth['profile'];

            if($auth['isGrunt'] || $auth['isOfficer'] || $auth['isLeader']){
                Alert::success('You already belong to an active group, you will need to leave this group to join a new one.')->flash();
                return Redirect::to('admin/clan/show/'. $profile->clan_id);
            }

            $user_id = $currentUser->getId();
            $applicationCount = $currentUser->applications->count();

            if($applicationCount > 2){
                Alert::success('You have reached your open application limit')->flash();
                return Redirect::to('admin/user/show/'. $user_id);
            }

            if($profile->clan_id == 0){

                $application = new Application;

                if($profile->country != ''){
                    $countries = DB::table('countries')->lists('name','iso_3166_2');
                    $countryName = $countries[$profile->country];
                    $application->country = $profile->country;
                    $application->country_name = $profile->country_name;
                }

                $application->user_id = $user_id;
                $application->clan_id = $id;
                $application->username = $profile->username;
                $application->age_group = $profile->age_group;
                $application->note = $input['note'];

                $application->save();

                Alert::success('Application lodged.')->flash();
                return Redirect::to('admin/user/show/'. $user_id);

            }else{
                Alert::success('You already belong to an active group, you will need to leave this group to create a new one.')->flash();
                return Redirect::to('admin/clan/show/'. $profile->clan_id);
            }
        }
    }

    // Delete ----------------------------------------------------------------------------------------------------------

    public function postDeleteapplicant($id)
    {

        $data = get_default_data();
        $auth = $data['auth'];

        $currentUser = $auth['user'];
        $profile = $auth['profile'];

        $application = Application::find($id);
        $clan = $application->clan;
        $user_id = $currentUser->getId();

        if(!$auth['isAdmin'] && $application->user_id != $user_id){
            Alert::error('You don\'t have access to that application.')->flash();
            return Redirect::to('admin/user/show/'.$user_id);
        }

        $application->delete();

        Alert::success('Application deleted.')->flash();
        return Redirect::to('admin/user/show/' . $user_id);

    }

    public function postDeleterecipient($id)
    {

        $data = get_default_data();
        $auth = $data['auth'];

        $currentUser = $auth['user'];
        $profile = $auth['profile'];

        $application = Application::find($id);
        $clan = $application->clan;

        if (!$auth['isAdmin'] && $profile->clan_id != $clan->id) {
            Alert::error('You don\'t have access to that application.')->flash();
            return Redirect::to('admin/clan/show/'. $clan->id);
        }

        $application->delete();

        Alert::success('Application deleted.')->flash();
        return Redirect::to('admin/clan/show/'. $clan->id);

    }

    // Accept / Deny ---------------------------------------------------------------------------------------------------

    public function postAccept($id)
    {

        $data = get_default_data();
        $auth = $data['auth'];

        $currentUser = $auth['user'];
        $profile = $auth['profile'];

        $application = Application::find($id);
        $clan = $application->clan;

        if (!$auth['isAdmin'] && $profile->clan_id != $clan->id) {
            Alert::error('You don\'t have access to that application.')->flash();
            return Redirect::to('admin/clan/show/'. $clan->id);
        }

        $applicant = Sentry::findUserById($application->user_id);
        $applicantProfile = $applicant->profile;

        if($applicant->inGroup($auth['officerGroup'])){
            $applicant->removeGroup($auth['officerGroup']);
        }
        if($applicant->inGroup($auth['leaderGroup'])){
            $applicant->removeGroup($auth['leaderGroup']);
        }

        if(!$applicant->inGroup($auth['adminGroup'])){
            $applicant->addGroup($auth['gruntGroup']);
        }

        $applicantProfile->clan_id = $clan->id;
        $applicantProfile->save();

        forEach($applicant->applications as $application){
            $application->delete();
        }

        Alert::success('You have accepted the applicant into your group.')->flash();
        return Redirect::to('admin/clan/show/'. $clan->id);

    }

    public function postDeny($id)
    {

        $data = get_default_data();
        $auth = $data['auth'];

        $currentUser = $auth['user'];
        $profile = $auth['profile'];

        $application = Application::find($id);
        $clan = $application->clan;

        if (!$auth['isAdmin'] && $profile->clan_id != $clan->id) {
            Alert::error('You don\'t have access to that application.')->flash();
            return Redirect::to('admin/clan/show/'. $clan->id);
        }

        $application->denied = true;

        $application->save();

        Alert::success('Application denied.')->flash();
        return Redirect::to('admin/clan/show/'. $clan->id);

    }
}
