@extends('user.layouts.default')

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

            <div class="col-md-6 col-md-offset-3">
                <div class="panel panel-dark">
                    <div class="panel-heading">
                        <h3 class="panel-title">Complete Your Profile</h3>
                    </div>
                    <form action="{{ URL::to('user/profile') }}/{{ $user->id }}" method="post">

                        {{ Form::token() }}

                        <div class="panel-body">

                             <div class="form-group {{ $errors->has('username') ? 'has-error' : '' }}" for="username">
                                <label class="control-label" for="username">User name</label>
                                <input name="username" type="text" class="form-control" placeholder="username">
                                <?php
                                if($errors->has('username')){
                                    echo '<span class="label label-danger">' . $errors->first('username') . '</span>';
                                }
                                ?>
                            </div>

                            <div class="form-group {{ $errors->has('a3ID') ? 'has-error' : '' }}" for="a3ID">
                                <label class="control-label" for="a3ID">Arma 3 Player ID </label><span class="badge" data-toggle="modal" data-target="#myModal">?</span>
                                <input name="a3ID" value="{{ Request::old('a3ID') }}" type="text" class="form-control" placeholder="Arma 3 ID">
                                <?php
                                if($errors->has('a3ID')){
                                    echo '<span class="label label-danger">' . $errors->first('a3ID') . '</span>';
                                }
                                ?>
                            </div>

                            <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h4 class="modal-title" id="myModalLabel">How to find your Arma 3 Player ID</h4>
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
                                <select name="country" type="text" class="form-control" placeholder="Country">
                                @foreach ($countries as $key =>$value)
                                <option value="{{$key}}">{{$value}}</option>
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
                                <select name="ageGroup" value="{{ Request::old('ageGroup') }}" type="text" class="form-control" placeholder="Age Group">
                                @foreach ($ageGroup as $key =>$value)
                                <option value="{{$key}}">{{$value}}</option>
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
                                <input name="twitchStream" type="text" class="form-control" placeholder="Twitch Stream">
                                <?php
                                if($errors->has('twitchStream')){
                                    echo '<span class="label label-danger">' . $errors->first('twitchStream') . '</span>';
                                }
                                ?>
                            </div>

                            <!--
                            <div class="form-group {{ $errors->has('alias') ? 'has-error' : '' }}" for="alias">
                                <label class="control-label" for="alias">Alias</label>
                                <input name="alias" type="text" class="form-control" placeholder="Alias">
                                <?php
                                if($errors->has('alias')){
                                    echo '<span class="label label-danger">' . $errors->first('alias') . '</span>';
                                }
                                ?>
                            </div>

                            <div class="form-group {{ $errors->has('a2ID') ? 'has-error' : '' }}" for="a2ID">
                                <label class="control-label" for="a2ID">Arma 2 ID</label>
                                <input name="a2ID" type="text" class="form-control" placeholder="Arma 2 ID">
                                <?php
                                if($errors->has('a2ID')){
                                    echo '<span class="label label-danger">' . $errors->first('a2ID') . '</span>';
                                }
                                ?>
                            </div>

                            <div class="form-group {{ $errors->has('primaryProfile') ? 'has-error' : '' }}" for="primaryProfile">
                                <label class="control-label" for="primaryProfile">Primary profile name</label>
                                <input name="primaryProfile" type="text" class="form-control" placeholder="Primary Profile">
                                <?php
                                if($errors->has('primaryProfile')){
                                    echo '<span class="label label-danger">' . $errors->first('primaryProfile') . '</span>';
                                }
                                ?>
                            </div>

                            <div class="form-group {{ $errors->has('secondaryProfile') ? 'has-error' : '' }}" for="secondaryProfile">
                                <label class="control-label" for="secondaryProfile">Secondary profile name</label>
                                <input name="secondaryProfile" type="text" class="form-control" placeholder="Secondary Profile">
                                <?php
                                if($errors->has('secondaryProfile')){
                                    echo '<span class="label label-danger">' . $errors->first('secondaryProfile') . '</span>';
                                }
                                ?>
                            </div>

                            <div class="form-group {{ $errors->has('armaFace') ? 'has-error' : '' }}" for="armaFace">
                                <label class="control-label" for="armaFace">Arma face</label>
                                <input name="armaFace" type="text" class="form-control" placeholder="Arma Face">
                                <?php
                                if($errors->has('armaFace')){
                                    echo '<span class="label label-danger">' . $errors->first('armaFace') . '</span>';
                                }
                                ?>
                            </div>

                            <div class="form-group {{ $errors->has('armaVoice') ? 'has-error' : '' }}" for="armaVoice">
                                <label class="control-label" for="armaVoice">Arma voice</label>
                                <input name="armaVoice" type="text" class="form-control" placeholder="Arma Voice">
                                <?php
                                if($errors->has('armaVoice')){
                                    echo '<span class="label label-danger">' . $errors->first('armaVoice') . '</span>';
                                }
                                ?>
                            </div>

                            <div class="form-group {{ $errors->has('armaPitch') ? 'has-error' : '' }}" for="armaPitch">
                                <label class="control-label" for="armaPitch">Arma pitch</label>
                                <input name="armaPitch" type="text" class="form-control" placeholder="Arma Pitch">
                                <?php
                                if($errors->has('armaPitch')){
                                    echo '<span class="label label-danger">' . $errors->first('armaPitch') . '</span>';
                                }
                                ?>
                            </div>
                            -->

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
        </div>
    </div>
</div>
@stop
