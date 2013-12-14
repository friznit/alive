<div id="topnav" class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="{{ URL::to('/war-room') }}"><img src="{{ URL::to('/') }}/img/warroom_logo_combined.png"/></a>
        </div>
        <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
                <li><a href="{{{ URL::to('/') }}}/">ALiVE</a></li>
                <li{{ (Request::is('war-room') ? ' class="active"' : '') }}><a href="{{{ URL::to('war-room') }}}/">War Room</a></li>
            </ul>
            <ul class="nav navbar-nav pull-right">

                <li {{ (Request::is('admin/user/show/*') ? 'class="active"' : '') }}><a href="{{ URL::to('admin/user/show/') }}/{{ Sentry::getUser()->getId() }}">Profile</a></li>

                @if ($auth['isAdmin'])
                <li {{ (Request::is('admin/clan*') ? 'class="active"' : '') }}><a href="{{ URL::to('admin/clan') }}">Groups</a></li>
                <li {{ (Request::is('admin/user*') ? 'class="active"' : '') }}><a href="{{ URL::to('admin/user') }}">Users</a></li>
                <li {{ (Request::is('admin/group*') ? 'class="active"' : '') }}><a href="{{ URL::to('admin/group') }}">User Groups</a></li>
                @endif

                <li id="logout"><a href="{{ URL::to('user/logout') }}">Logout</a></li>
            </ul>
        </div>
    </div>
</div>