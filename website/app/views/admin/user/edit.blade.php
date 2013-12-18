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

                            <div class="form-group {{ $errors->has('username') ? 'has-error' : '' }}" for="username">
                                <label class="control-label" for="username">User name</label>
                                <input name="username" value="{{ (Request::old('username')) ? Request::old("username") : $profile->username }}" type="text" class="form-control" placeholder="username">
                                <?php
                                if($errors->has('username')){
                                    echo '<span class="label label-danger">' . $errors->first('username') . '</span>';
                                }
                                ?>
                            </div>

                            <div class="form-group {{ $errors->has('a3ID') ? 'has-error' : '' }}" for="a3ID">
                                <label class="control-label" for="a3ID">Arma 3 Player ID </label><span class="badge" data-toggle="modal" data-target="#playerIDModal">?</span>
                                <input name="a3ID" value="{{ (Request::old('a3ID')) ? Request::old("a3ID") : $profile->a3_id }}" type="text" class="form-control" placeholder="Arma 3 ID">
                                <?php
                                if($errors->has('a3ID')){
                                    echo '<span class="label label-danger">' . $errors->first('a3ID') . '</span>';
                                }
                                ?>
                            </div>

                            <div class="modal fade" id="playerIDModal" tabindex="-1" role="dialog" aria-labelledby="playerIDModal" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h4 class="modal-title" id="myModalLabel"></h4>
                                        </div>
                                        <div class="strip">
                                            <p>We use your player ID to connect your war room account to your in-game activity.</p>
                                        </div>
                                        <div class="modal-body">
                                            <img src="{{ URL::to('/') }}/img/id1.jpg" class="img-responsive dark-border center-block" /><br/>
                                            <img src="{{ URL::to('/') }}/img/id2.jpg" class="img-responsive dark-border" />
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-dark" data-dismiss="modal">Close</button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group {{ ($errors->has('country')) ? 'has-error' : '' }}" for="country">
                                <label class="control-label" for="country">Country</label>
                                <select name="country" value="{{ (Request::old('country')) ? Request::old("country") : $profile->country }}" type="text" class="form-control" placeholder="Country">
                                @foreach ($countries as $key =>$value)
                                @if ($key == $profile->country)
                                <option value="{{$key}}" selected="selected">{{$value}}</option>
                                @else
                                <option value="{{$key}}">{{$value}}</option>
                                @endif
                                @endforeach
                                </select>
                                <?php
                                if($errors->has('country')){
                                    echo '<span class="label label-danger">' . $errors->first('country') . '</span>';
                                }
                                ?>
                            </div>

                            <div class="form-group {{ $errors->has('ageGroup') ? 'has-error' : '' }}" for="ageGroup">
                                <label class="control-label" for="ageGroup">Age Group</label>
                                <select name="ageGroup" value="{{ (Request::old('ageGroup')) ? Request::old("ageGroup") : $profile->age_group }}" type="text" class="form-control" placeholder="Age Group">
                                @foreach ($ageGroup as $key =>$value)
                                @if ($key == $profile->age_group)
                                <option value="{{$key}}" selected="selected">{{$value}}</option>
                                @else
                                <option value="{{$key}}">{{$value}}</option>
                                @endif
                                @endforeach
                                </select>
                                <?php
                                if($errors->has('ageGroup')){
                                    echo '<span class="label label-danger">' . $errors->first('ageGroup') . '</span>';
                                }
                                ?>
                            </div>

                            <div class="form-group {{ $errors->has('twitchStream') ? 'has-error' : '' }}" for="twitchStream">
                                <label class="control-label" for="twitchStream">Twitch Stream</label>
                                <input name="twitchStream" value="{{ (Request::old('twitchStream')) ? Request::old("twitchStream") : $profile->twitch_stream }}" type="text" class="form-control" placeholder="Twitch Stream">
                                <?php
                                if($errors->has('twitchStream')){
                                    echo '<span class="label label-danger">' . $errors->first('twitchStream') . '</span>';
                                }
                                ?>
                            </div>

                            <!--
                            <div class="form-group {{ $errors->has('alias') ? 'has-error' : '' }}" for="alias">
                                <label class="control-label" for="alias">Alias</label>
                                <input name="alias" value="{{ (Request::old('alias')) ? Request::old("alias") : $profile->alias }}" type="text" class="form-control" placeholder="Alias">
                                <?php
                                if($errors->has('alias')){
                                    echo '<span class="label label-danger">' . $errors->first('alias') . '</span>';
                                }
                                ?>
                            </div>

                            <div class="form-group {{ $errors->has('a2ID') ? 'has-error' : '' }}" for="a2ID">
                                <label class="control-label" for="a2ID">Arma 2 ID</label>
                                <input name="a2ID" value="{{ (Request::old('a2ID')) ? Request::old("a2ID") : $profile->a2_id }}" type="text" class="form-control" placeholder="Arma 2 ID">
                                <?php
                                if($errors->has('a2ID')){
                                    echo '<span class="label label-danger">' . $errors->first('a2ID') . '</span>';
                                }
                                ?>
                            </div>

                            <div class="form-group {{ $errors->has('primaryProfile') ? 'has-error' : '' }}" for="primaryProfile">
                                <label class="control-label" for="primaryProfile">Primary profile name</label>
                                <input name="primaryProfile" value="{{ (Request::old('primaryProfile')) ? Request::old("primary_profile") : $profile->primary_profile }}" type="text" class="form-control" placeholder="Primary Profile">
                                <?php
                                if($errors->has('primaryProfile')){
                                    echo '<span class="label label-danger">' . $errors->first('primaryProfile') . '</span>';
                                }
                                ?>
                            </div>

                            <div class="form-group {{ $errors->has('secondaryProfile') ? 'has-error' : '' }}" for="secondaryProfile">
                                <label class="control-label" for="secondaryProfile">Secondary profile name</label>
                                <input name="secondaryProfile" value="{{ (Request::old('secondaryProfile')) ? Request::old("secondary_profile") : $profile->secondary_profile }}" type="text" class="form-control" placeholder="Secondary Profile">
                                <?php
                                if($errors->has('secondaryProfile')){
                                    echo '<span class="label label-danger">' . $errors->first('secondaryProfile') . '</span>';
                                }
                                ?>
                            </div>

                            <div class="form-group {{ $errors->has('armaFace') ? 'has-error' : '' }}" for="armaFace">
                                <label class="control-label" for="armaFace">Arma face</label>
                                <input name="armaFace" value="{{ (Request::old('armaFace')) ? Request::old("armaFace") : $profile->arma_face }}" type="text" class="form-control" placeholder="Arma Face">
                                <?php
                                if($errors->has('armaFace')){
                                    echo '<span class="label label-danger">' . $errors->first('armaFace') . '</span>';
                                }
                                ?>
                            </div>

                            <div class="form-group {{ $errors->has('armaVoice') ? 'has-error' : '' }}" for="armaVoice">
                                <label class="control-label" for="armaVoice">Arma voice</label>
                                <input name="armaVoice" value="{{ (Request::old('armaVoice')) ? Request::old("armaVoice") : $profile->arma_voice }}" type="text" class="form-control" placeholder="Arma Voice">
                                <?php
                                if($errors->has('armaVoice')){
                                    echo '<span class="label label-danger">' . $errors->first('armaVoice') . '</span>';
                                }
                                ?>
                            </div>

                            <div class="form-group {{ $errors->has('armaPitch') ? 'has-error' : '' }}" for="armaPitch">
                                <label class="control-label" for="armaPitch">Arma pitch</label>
                                <input name="armaPitch" value="{{ (Request::old('armaPitch')) ? Request::old("armaPitch") : $profile->arma_pitch }}" type="text" class="form-control" placeholder="Arma Pitch">
                                <?php
                                if($errors->has('armaPitch')){
                                    echo '<span class="label label-danger">' . $errors->first('armaPitch') . '</span>';
                                }
                                ?>
                            </div>

                            <div class="form-group {{ $errors->has('remark') ? 'has-error' : '' }}" for="remark">
                                <label class="control-label" for="remark">Remark</label>
                                <input name="remark" value="{{ (Request::old('remark')) ? Request::old("remark") : $profile->remark }}" type="text" class="form-control" placeholder="Remark">
                                <?php
                                if($errors->has('remark')){
                                    echo '<span class="label label-danger">' . $errors->first('remark') . '</span>';
                                }
                                ?>
                            </div>
                            -->

                        </div>
                        <div class="panel-footer clearfix">
                            <div class="btn-toolbar pull-right" role="toolbar">
                                <input class="btn btn-yellow" type="submit" value="Save">
                            </div>
                        </div>
                    </form>
                </div>

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
                                <input class="btn btn-yellow" type="submit" value="Change Password">
                            </div>
                        </div>
                    </form>
                </div>

                <div class="panel panel-dark">
                    <div class="panel-heading">
                        <h3 class="panel-title">Change Email</h3>
                    </div>
                    <form action="{{ URL::to('admin/user/changeemail') }}/{{ $user->id }}" method="post">
                        {{ Form::token() }}

                        <div class="panel-body">

                            <div class="form-group" for="oldEmail">
                                <label class="control-label" for="oldEmail">Old Email</label>
                                <input name="oldEmail" value="{{ (Request::old('oldEmail')) ? Request::old("oldEmail") : $user->email }}" type="email" class="form-control" placeholder="Old Email" readonly>
                            </div>

                            <div class="form-group {{ $errors->has('newEmail') ? 'has-error' : '' }}" for="newEmail">
                                <label class="control-label" for="newEmail">New Email</label>
                                <input name="newEmail" value="" type="email" class="form-control" placeholder="New Email">
                                <?php
                                if($errors->has('newEmail')){
                                    echo '<span class="label label-danger">' . $errors->first('newEmail') . '</span>';
                                }
                                ?>
                            </div>

                            <div class="form-group {{ $errors->has('newEmail_confirmation') ? 'has-error' : '' }}" for="newEmail_confirmation">
                                <label class="control-label" for="newEmail_confirmation">Confirm New Email</label>
                                <input name="newEmail_confirmation" value="" type="email" class="form-control" placeholder="New Email Again">
                                <?php
                                if($errors->has('newEmail_confirmation')){
                                    echo '<span class="label label-danger">' . $errors->first('newEmail_confirmation') . '</span>';
                                }
                                ?>
                            </div>

                        </div>
                        <div class="panel-footer clearfix">
                            <div class="btn-toolbar pull-right" role="toolbar">
                                <input class="btn btn-yellow" type="submit" value="Change Email">
                            </div>
                        </div>
                    </form>
                </div>

            </div>

            <div class="col-md-4">

                <div class="panel panel-dark">
                    <div class="panel-heading">
                        <h3 class="panel-title">Upload Avatar</h3>
                    </div>

                    <form action="{{ URL::to('admin/user/changeavatar') }}/{{ $user->id }}" method="post" enctype="multipart/form-data">
                        {{ Form::token() }}

                        <div class="strip">
                            <p>Ensure your image is square to avoid distortion.</p>
                        </div>

                        <div class="panel-body avatars">
                            <p>Large (300px x 300px)</p>
                            <img src="<?= $profile->avatar->url('medium') ?>" ><br/><br/>
                            <p>Medium (100px x 100px)</p>
                            <img src="<?= $profile->avatar->url('thumb') ?>" ><br/><br/>
                            <p>Small (40px x 40px)</p>
                            <img src="<?= $profile->avatar->url('tiny') ?>" ><br/><br/>
                            <input type="file" id="avatar_upload" name="avatar" />
                        </div>
                        <div class="panel-footer clearfix">
                            <div class="btn-toolbar pull-right" role="toolbar">
                                <input class="btn btn-yellow" type="submit" value="Upload Avatar">
                            </div>
                        </div>
                    </form>
                </div>

            </div>

            <div class="col-md-4">

                <div class="panel panel-dark">
                    <div class="panel-heading">
                        <h3 class="panel-title">Delete Account</h3>
                    </div>
                    <div class="panel-footer clearfix">
                        <div class="btn-toolbar pull-right" role="toolbar">
                            <button class="btn btn-red action_confirm" href="{{ URL::to('admin/user/delete') }}/{{ $user->id}}" data-token="{{ Session::getToken() }}" data-method="post">Delete My Account</button>
                        </div>
                    </div>
                </div>

                @if ($auth['isAdmin'])

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

                @endif

            </div>
        </div>
    </div>
</div>

@stop
