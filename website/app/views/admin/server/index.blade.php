@extends('admin.layouts.default')

<div class="admin-panel">
    <div class="container">
        <div class="row">
            <div class="col-md-12">

            {{-- Content --}}
            @section('content')

            <h2>Servers</h2>

            <form class="light" action="{{ URL::to('admin/server/search') }}" method="post">

                {{ Form::token() }}

                <div class="row">
                    <div class="col-lg-4">
                        <div class="input-group">
                            <input type="text" name="query" class="form-control">
                            <span class="input-group-btn">
                            <input class="btn btn-default" type="submit" value="Search">
                            </span>
                        </div>
                        <?php
                        if($errors->has('query')){
                            echo '<span class="label label-danger">' . $errors->first('query') . '</span>';
                        }
                        ?>
                        <div class="input-group">
                            <label class="radio-inline">
                                <input type="radio" name="type" value="name" checked> by Name
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="type" value="hostname"> by Hostname
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="type" value="ip"> by IP
                            </label>
                        </div>
                    </div>
                </div>

            </form>

            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Clan</th>
                        <th>Hostname</th>
                        <th>IP</th>
                        <th>Options</th>
                    </tr>
                </thead>
                <tbody>
                @foreach ($allServers as $server)
                <tr>
                    <td><a href="{{ URL::to('admin/server/show') }}/{{ $server->id }}">{{{ $server->name }}}</a></td>
                    <td>{{{ $server->clan->name }}}</td>
                    <td>{{{ $server->hostname }}}</td>
                    <td>{{{ $server->ip }}}</td>
                    <td>
                        <button class="btn btn-default" onClick="location.href='{{ URL::to('admin/server/edit') }}/{{ $server->id}}'">Edit</button>
                        <button class="btn btn-default action_confirm" href="{{ URL::to('admin/server/delete') }}/{{ $server->id}}" data-token="{{ Session::getToken() }}" data-method="post">Delete</button>
                    </td>
                </tr>
                @endforeach
                </tbody>
            </table>

            <?php echo $allServers->links(); ?>

            </div>
        </div>
    </div>
</div>



@stop
