<?php

use Alive\CouchAPI;

class APIController extends BaseController {

    private $couchAPI;

    public function __construct()
    {
        $this->couchAPI = new CouchAPI();
    }

    public function getTotals()
    {
        return $this->couchAPI->getTotals();
    }

    public function getActiveunitcount()
    {
        return $this->couchAPI->getActiveUnitCount();
    }

    public function getRecentoperations()
    {
        return $this->couchAPI->getRecentOperations();
    }

    public function getLivefeed()
    {
        return $this->couchAPI->getLiveFeed();
    }

    public function getLossesblu()
    {
        return $this->couchAPI->getLossesBLU();
    }

    public function getLossesopf()
    {
        return $this->couchAPI->getLossesOPF();
    }

    public function getCasualties()
    {
        return $this->couchAPI->getCasualties();
    }

    public function getOperationsbymap()
    {
        return $this->couchAPI->getOperationsByMap();
    }

    public function getOperationsbyday()
    {
        return $this->couchAPI->getOperationsByDay();
    }

    public function getPlayersbyday()
    {
        return $this->couchAPI->getPlayersByDay();
    }

    public function getKillsbyday()
    {
        return $this->couchAPI->getKillsByDay();
    }

    public function getDeathsbyday()
    {
        return $this->couchAPI->getDeathsByDay();
    }
}
