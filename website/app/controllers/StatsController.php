<?php

class StatsController extends BaseController {

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
        return View::make('warroom/stats.index')->with($data);

    }
}