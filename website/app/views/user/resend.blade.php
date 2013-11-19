@extends('user.layouts.default')

{{-- Content --}}
@section('content')

<div class="dark-panel form-holder" id="Media">
    <div class="container">
        <div class="row">
            <div class="col-md-6 col-md-offset-3">
                <div class="panel panel-dark">
                    <div class="panel-heading">
                        <h3 class="panel-title">Resend Activation</h3>
                    </div>
                    <form action="{{ URL::to('user/resend') }}" method="post" role="form">
                        <div class="panel-body">

                            {{ Form::token(); }}

                            <div class="form-group {{ ($errors->has('email')) ? 'has-error' : '' }}">
                                <label for="email" class="control-label">Email</label>
                                <input name="email" type="email" class="form-control" id="email" placeholder="Email" value="{{ Request::old('email') }}">
                                <?php
                                if($errors->has('email')){
                                    echo '<span class="label label-danger">' . $errors->first('email') . '</span>';
                                }
                                ?>
                            </div>

                            @include('alerts/alerts')

                        </div>
                        <div class="panel-footer clearfix">
                            <div class="btn-toolbar pull-right" role="toolbar">
                                <button type="submit" class="btn btn-yellow">Resend Activation</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

@stop