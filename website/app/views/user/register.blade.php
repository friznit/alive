@extends('user.layouts.default')

{{-- Content --}}
@section('content')

<div class="dark-panel form-holder" id="Media">
    <div class="container">
        <div class="row">
            <div class="col-md-6 col-md-offset-3">
                <div class="panel panel-dark">
                    <div class="panel-heading">
                        <h3 class="panel-title">Sign up for War Room</h3>
                    </div>
                    <form action="{{ URL::to('user/register') }}" method="post" role="form">
                        <div class="panel-body">

                                {{ Form::token(); }}

                                <div class="form-group {{ ($errors->has('email')) ? 'has-error' : '' }}" for="email">
                                    <label for="email" class="control-label">Email</label>
                                    <input name="email" type="email" class="form-control" id="email" placeholder="Email" value="{{ Request::old('email') }}">
                                    <?php
                                    if($errors->has('email')){
                                        echo '<span class="label label-danger">' . $errors->first('email') . '</span>';
                                    }
                                    ?>
                                </div>

                                <div class="form-group {{ ($errors->has('password')) ? 'has-error' : '' }}" for="email">
                                    <label for="password" class="control-label">Password</label>
                                    <input name="password" value="" type="password" class="form-control" placeholder="Password">
                                    <?php
                                    if($errors->has('password')){
                                        echo '<span class="label label-danger">' . $errors->first('password') . '</span>';
                                    }
                                    ?>
                                </div>

                                <div class="form-group {{ ($errors->has('password_confirmation')) ? 'has-error' : '' }}" for="password_confirmation">
                                    <label for="password_confirmation" class="control-label">Confirm Password</label>
                                    <input name="password_confirmation" value="" type="password" class="form-control" placeholder="Password again">
                                    <?php
                                    if($errors->has('password_confirmation')){
                                        echo '<span class="label label-danger">' . $errors->first('password_confirmation') . '</span>';
                                    }
                                    ?>
                                </div>

                                @include('alerts/alerts')

                        </div>
                        <div class="panel-footer clearfix">
                            <div class="btn-toolbar pull-right" role="toolbar">
                                <input class="btn btn-dark" type="reset" value="Reset">
                                <button type="submit" class="btn btn-yellow">Sign Up</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

@stop