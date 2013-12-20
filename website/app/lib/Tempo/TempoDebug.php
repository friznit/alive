<?php

namespace Tempo;

use Tempo\Base\Base;
use Tempo\Output\HTMLFormat;
use Tempo\Output\HTMLFormatDefaults;
use Tempo\Util\PrettyDump;
use Tempo\Util\PrettyTrace;
use Tempo\Util\Profiler;

class TempoDebug {

    /**
     * Debug an object of your choice..
     */
    public static function dump($object, $title = false, $echo = true)
    {
        $formatter = new HTMLFormat();
        $dump = new PrettyDump($formatter);
        if($echo){ echo $dump->dump($object, $title); return; }
        return $dump->dump($object, $title);
    }

    /**
     * Inspect a class of your choice..
     */
    public static function inspect($object, $title = false, $echo = true)
    {
        $formatter = new HTMLFormat();
        $dump = new PrettyInspect($formatter);
        if($echo){ echo $dump->inspect($object, $title); return; }
        return $dump->inspect($object, $title);
    }

    /**
     * Output a message of your choice..
     */
    public static function message($msg, $echo = true)
    {
        $formatter = new HTMLFormat();
        $dump = new PrettyDump($formatter);
        if($echo){ echo $dump->message($msg); return; }
        return $dump->message($msg);
    }

    /**
     * Start profiler
     */
    public static function startProfile()
    {
        return new Profiler();
    }

    /**
     * Stop profiler
     */
    public static function stopProfile($profiler)
    {
        echo $profiler->stop_profile();
    }

}