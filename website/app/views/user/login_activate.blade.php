@extends('user.layouts.default')

{{-- Content --}}
@section('content')

<div class="dark-panel form-holder">
    <div class="container">
        <div class="row">
            <div class="col-md-6 col-md-offset-3">
                <div class="panel panel-dark">
                    <div class="panel-heading">
                        <h3 class="panel-title">War Room Login</h3>
                    </div>
                    <form action="{{ URL::to('user/login') }}" method="post" role="form">
                        <div class="panel-body">

                                {{ Form::token(); }}

                                <input name="activation" type="hidden" value="true">

                                <div class="form-group {{ ($errors->has('email')) ? 'has-error' : '' }}">
                                    <label for="email" class="control-label">Email</label>
                                    <input name="email" type="email" class="form-control" id="email" placeholder="Email" value="{{ Request::old('email') }}">
                                    <?php
                                        if($errors->has('email')){
                                            echo '<span class="label label-danger">' . $errors->first('email') . '</span>';
                                        }
                                    ?>
                                </div>

                                <div class="form-group {{ ($errors->has('password')) ? 'has-error' : '' }}">
                                    <label for="password" class="control-label">Password</label>
                                    <input name="password" value="" type="password" class="form-control" placeholder="Password">
                                    <?php
                                    if($errors->has('password')){
                                        echo '<span class="label label-danger">' . $errors->first('password') . '</span>';
                                    }
                                    ?>
                                </div>

                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="rememberMe" value="1"> Remember me
                                    </label>
                                </div>

                                @include('alerts/alerts')

                        </div>
                        <div class="panel-footer clearfix">
                            <div class="btn-toolbar pull-right" role="toolbar">
                                <a href="{{ URL::to('user/register') }}" class="btn btn-dark">Need an account? - Sign up</a>
                                <a href="{{ URL::to('user/resetpassword') }}" class="btn btn-dark">Forgot Password?</a>
                                <button type="submit" class="btn btn-yellow">Login</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

@stop