@extends('admin.layouts.default')

{{-- Content --}}
@section('content')

<div class="dark-panel form-holder">

    <div class="container">
        <div class="row">

            <div class="col-md-12">
                @include('alerts/alerts')
            </div>

        </div>
        <div class="row">

            <div class="col-md-4">
                <div class="panel panel-dark">
                    <div class="panel-heading">
                        <h3 class="panel-title">Edit Profile</h3>
                    </div>
                    <form action="{{ URL::to('admin/user/edit') }}/{{ $user->id }}" method="post">

                        {{ Form::token() }}

                        <div class="panel-body">

                            <div class="form-group {{ ($errors->has('firstName')) ? 'has-error' : '' }}" for="firstName">
                                <label class="control-label" for="firstName">First Name</label>
                                <input name="firstName" value="{{ (Request::old('firstName')) ? Request::old("firstName") : $user->first_name }}" type="text" class="form-control" placeholder="First Name">
                                <?php
                                if($errors->has('firstName')){
                                    echo '<span class="label label-danger">' . $errors->first('firstName') . '</span>';
                                }
                                ?>
                            </div>

                            <div class="form-group {{ $errors->has('lastName') ? 'has-error' : '' }}" for="lastName">
                                <label class="control-label" for="lastName">Last Name</label>
                                <input name="lastName" value="{{ (Request::old('lastName')) ? Request::old("lastName") : $user->last_name }}" type="text" class="form-control" placeholder="Last Name">
                                <?php
                                if($errors->has('lastName')){
                                    echo '<span class="label label-danger">' . $errors->first('lastName') . '</span>';
                                }
                                ?>
                            </div>

                        </div>
                        <div class="panel-footer clearfix">
                            <div class="btn-toolbar pull-right" role="toolbar">
                                <input class="btn btn-dark" type="reset" value="Reset">
                                <input class="btn btn-yellow" type="submit" value="Save">
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <div class="col-md-4">
                <div class="panel panel-dark">
                    <div class="panel-heading">
                        <h3 class="panel-title">Change Password</h3>
                    </div>
                    <form action="{{ URL::to('admin/user/changepassword') }}/{{ $user->id }}" method="post">
                        {{ Form::token() }}

                        <div class="panel-body">
        
                            <div class="form-group {{ $errors->has('oldPassword') ? 'has-error' : '' }}" for="oldPassword">
                                <label class="control-label" for="oldPassword">Old Password</label>
                                <input name="oldPassword" value="" type="password" class="form-control" placeholder="Old Password">
                                <?php
                                if($errors->has('oldPassword')){
                                    echo '<span class="label label-danger">' . $errors->first('oldPassword') . '</span>';
                                }
                                ?>
                            </div>

                            <div class="form-group {{ $errors->has('newPassword') ? 'has-error' : '' }}" for="newPassword">
                                <label class="control-label" for="newPassword">New Password</label>
                                <input name="newPassword" value="" type="password" class="form-control" placeholder="New Password">
                                <?php
                                if($errors->has('newPassword')){
                                    echo '<span class="label label-danger">' . $errors->first('newPassword') . '</span>';
                                }
                                ?>
                            </div>

                            <div class="form-group {{ $errors->has('newPassword_confirmation') ? 'has-error' : '' }}" for="newPassword_confirmation">
                                <label class="control-label" for="newPassword_confirmation">Confirm New Password</label>
                                <input name="newPassword_confirmation" value="" type="password" class="form-control" placeholder="New Password Again">
                                <?php
                                if($errors->has('newPassword_confirmation')){
                                    echo '<span class="label label-danger">' . $errors->first('newPassword_confirmation') . '</span>';
                                }
                                ?>
                            </div>

                        </div>
                        <div class="panel-footer clearfix">
                            <div class="btn-toolbar pull-right" role="toolbar">
                                <input class="btn btn-dark" type="reset" value="Reset">
                                <input class="btn btn-yellow" type="submit" value="Change Password">
                            </div>
                        </div>
                    </form>
                </div>
            </div>


@if (Sentry::check() && Sentry::getUser()->hasAccess('admin'))


            <div class="col-md-4">
                <div class="panel panel-dark">
                    <div class="panel-heading">
                        <h3 class="panel-title">Group Memberships</h3>
                    </div>
                    <form action="{{ URL::to('admin/user/updatememberships') }}/{{ $user->id }}" method="post">
                        {{ Form::token() }}

                        <div class="panel-body">
                            <table class="table">
                                <thead>
                                    <th>Group</th>
                                    <th>Membership Status</th>
                                </thead>
                                <tbody>
                                    @foreach ($allGroups as $group)
                                        <tr>
                                            <td>{{ $group->name }}</td>
                                            <td>
                                                <div class="switch" data-on-label="In" data-on='info' data-off-label="Out">
                                                    <input name="permissions[{{ $group->id }}]" type="checkbox" {{ ( $user->inGroup($group)) ? 'checked' : '' }} >
                                                </div>
                                            </td>
                                        </tr>
                                    @endforeach
                                </tbody>
                            </table>
                        </div>
                        <div class="panel-footer clearfix">
                            <div class="btn-toolbar pull-right" role="toolbar">
                                <input class="btn btn-yellow" type="submit" value="Update">
                            </div>
                        </div>
                    </form>
                </div>
            </div>


@endif

        </div>
    </div>
</div>

@stop