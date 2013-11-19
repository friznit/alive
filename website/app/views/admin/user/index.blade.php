@extends('admin.layouts.default')

<div class="admin-panel">
    <div class="container">
        <div class="row">
            <div class="col-md-12">

            {{-- Content --}}
            @section('content')

            @if (Sentry::check())

            @if($user->hasAccess('admin'))

            <h2>Users</h2>

            <form class="light" action="{{ URL::to('admin/user/search') }}" method="post">

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
                                <input type="radio" name="type" value="id" checked> by ID
                            </label>
                            <label class="checkbox-inline">
                                <input type="radio" name="type" value="email"> by Email
                            </label>
                            <label class="checkbox-inline">
                                <input type="radio" name="type" value="lastName"> by Last Name
                            </label>
                        </div>
                    </div>
                </div>

            </form>

            <table class="table table-hover">
                <thead>
                    <th>User ID</th>
                    <th>User</th>
                    <th>Status</th>
                    <th>Options</th>
                </thead>
                <tbody>
                @foreach ($allUsers as $user)
                <tr>
                    <td>{{{ $user->user_id }}}</td>
                    <td><a href="{{ URL::to('admin/user/show') }}/{{ $user->user_id }}">{{{ $user->email }}}</a></td>
                    <td>{{ $userStatus[$user->id] }} </td>
                    <td>
                        <button class="btn btn-default" onClick="location.href='{{ URL::to('admin/user/edit') }}/{{ $user->user_id}}'">Edit</button>
                        <button class="btn btn-default" onClick="location.href='{{ URL::to('admin/user/suspend') }}/{{ $user->user_id}}'">Suspend</button>
                        <button class="btn btn-default action_confirm" href="{{ URL::to('admin/user/delete') }}/{{ $user->user_id}}" data-token="{{ Session::getToken() }}" data-method="post">Delete</button>
                    </td>
                </tr>
                @endforeach
                </tbody>
            </table>

            <?php echo $allUsers->links(); ?>

            @else
            <h4>You are not an Administrator</h4>
            @endif
            @else
            <h4>You are not logged in</h4>
            @endif

            </div>
        </div>
    </div>
</div>



@stop
