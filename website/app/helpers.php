<?php

function query_debug(){
    Event::listen('illuminate.query', function($query, $bindings, $time, $name)
    {
        $data = compact('bindings', 'time', 'name');

        // Format binding data for sql insertion
        foreach ($bindings as $i => $binding)
        {
            if ($binding instanceof \DateTime)
            {
                $bindings[$i] = $binding->format('\'Y-m-d H:i:s\'');
            }
            else if (is_string($binding))
            {
                $bindings[$i] = "'$binding'";
            }
        }

        // Insert bindings into query
        $query = str_replace(array('%', '?'), array('%%', '%s'), $query);
        $query = vsprintf($query, $bindings);

        Log::info($query, $data);
    });
}

function get_default_data(){
    try {
        $user = Sentry::getUser();
        $userId = $user->getId();
        $profile = $user->profile;

        $userGroup = Sentry::findGroupByName('Users');
        $gruntGroup = Sentry::findGroupByName('Grunt');
        $officerGroup = Sentry::findGroupByName('Officer');
        $leaderGroup = Sentry::findGroupByName('Leader');
        $adminGroup = Sentry::findGroupByName('Admins');

        $isUser = $user->inGroup($userGroup);
        $isGrunt = $user->inGroup($gruntGroup);
        $isOfficer = $user->inGroup($officerGroup);
        $isLeader = $user->inGroup($leaderGroup);
        $isAdmin = $user->inGroup($adminGroup);

        $result = array();
        $result['auth'] = array();
        $result['auth']['user'] = $user;
        $result['auth']['userId'] = $userId;
        $result['auth']['profile'] = $profile;
        $result['auth']['isUser'] = $isUser;
        $result['auth']['isGrunt'] = $isGrunt;
        $result['auth']['isOfficer'] = $isOfficer;
        $result['auth']['isLeader'] = $isLeader;
        $result['auth']['isAdmin'] = $isAdmin;
        $result['auth']['userGroup'] = $userGroup;
        $result['auth']['gruntGroup'] = $gruntGroup;
        $result['auth']['officerGroup'] = $officerGroup;
        $result['auth']['leaderGroup'] = $leaderGroup;
        $result['auth']['adminGroup'] = $adminGroup;

        return $result;

    } catch (Cartalyst\Sentry\UserNotFoundException $e) {
        Alert::error('There was a problem accessing your account.')->flash();
        return Redirect::to('user/login');
    }
}

function get_age_group_data(){
    $ageGroup = array();
    $ageGroup['1-10'] = '1-10';
    $ageGroup['10-20'] = '10-20';
    $ageGroup['20-30'] = '20-30';
    $ageGroup['30-40'] = '30-40';
    $ageGroup['40-50'] = '40-50';
    $ageGroup['50-60'] = '50-60';
    $ageGroup['60-70'] = '60-70';
    $ageGroup['70-80'] = '70-80';
    $ageGroup['80-90'] = '80-90';
    return $ageGroup;
}