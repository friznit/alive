@extends('admin.layouts.default')

{{-- Content --}}
@section('content')

@if (Sentry::check())

<div class="admin-panel">
    <div class="container">
        <div class="row">

            <div class="col-md-12">
                <br/><br/>
                @include('alerts/alerts')
            </div>

        </div>
        <div class="row">

            <div class="col-md-6">

                <h2>Join Application</h2>

                <p><em>Application created: {{ $application->created_at }}</em></p>
                <p><em>Application Updated: {{ $application->updated_at }}</em></p>

                <p><b>Username</b> {{{ $application->user->profile->username }}}</p>
                <p><b>Age Group</b> {{{ $application->age_group }}}</p>
                <p><b>Country</b> {{{ $application->country }}}</p>
                <b>Message</b>
                <p>{{{ $application->note }}}</p>

            </div>

            <div class="col-md-6">
                <div class="panel panel-dark">
                    <div class="panel-heading">
                        <h3 class="panel-title">Respond</h3>
                    </div>
                    <form action="{{ URL::to('admin/application/updaterecipient') }}/{{ $application->id }}" method="post">

                        {{ Form::token() }}

                        <div class="panel-body">

                            <div class="form-group {{ ($errors->has('response')) ? 'has-error' : '' }}" for="response">
                                <textarea name="response" type="text" class="form-control" placeholder="Enter Response">{{ (Request::old('response')) ? Request::old("response") : $application->response }}</textarea>
                                <?php
                                if($errors->has('response')){
                                    echo '<span class="label label-danger">' . $errors->first('response') . '</span>';
                                }
                                ?>
                            </div>

                        </div>
                        <div class="panel-footer clearfix">
                            <div class="btn-toolbar pull-right" role="toolbar">
                                <input class="btn btn-yellow" type="submit" value="Respond">
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

@endif

@stop
