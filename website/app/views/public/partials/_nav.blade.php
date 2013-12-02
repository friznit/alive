<div id="topnav" class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#"><img src="{{ URL::to('/') }}/img/logo.png"/></a>
        </div>
        <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
                <li><a href="#Trailer">Trailer</a></li>
                <li><a href="#Welcome">Welcome</a></li>
                <li><a href="#Gameplay">Gameplay</a></li>
                <li><a href="#Download">Download</a></li>
                <li><a href="#Media">Media</a></li>
                <li><a href="#Editors">Editors</a></li>
                <li><a href="#ALiVEWarRoom">ALiVE War Room</a></li>
                <li><a href="#FAQ">FAQ's</a></li>
                <li><a href="#INFO">More Info</a></li>
            </ul>
            <ul class="nav navbar-nav pull-right">
                @if (Sentry::check() && Sentry::getUser()->hasAccess('admin'))
                <li id="login"><a href="{{ URL::to('war-room') }}"><img src="{{ URL::to('/') }}/img/alive_warroom_tiny.png" class="img-responsive navbar-warroom"/></a></li>
                @else
                    <!--<li id="login"><a href="{{ URL::to('user/login') }}"><img src="{{ URL::to('/') }}/img/alive_warroom_login.png" class="img-responsive navbar-warroom"/></a></li>-->
                @endif
            </ul>
        </div>
    </div>
</div>
