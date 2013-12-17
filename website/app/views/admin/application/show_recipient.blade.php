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

                <table class="table">
                    <tr>
                        <td width="30%">Username</td>
                        <td width="70%">{{{ $application->user->profile->username }}}</td>
                    </tr>
                    <tr>
                        <td>Age Group</td>
                        <td>{{{ $application->age_group }}}</td>
                    </tr>
                    <tr>
                        <td>Country</td>
                        <td><?php
                            if(!is_null($application->country)){
                                ?>
                                <img src="{{ URL::to('/') }}/img/flags_iso/32/{{ strtolower($application->country) }}.png" alt="{{ $application->country_name }}" title="{{ $application->country_name }}"/>
                            <?php
                            }
                            ?>
                        </td>
                    </tr>
                    <tr>
                        <td>Created</td>
                        <td>{{ $application->created_at }}</td>
                    </tr>
                    <tr>
                        <td>Updated</td>
                        <td>{{ $application->updated_at }}</td>
                    </tr>
                </table>

            </div>

            <div class="col-md-6">

                <h2>Application Submission</h2>

                <table class="table">
                    <tr>
                        <td>{{{ $application->note }}}</td>
                    </tr>
                    <tr>
                        <td><button class="btn btn-red action_confirm" href="{{ URL::to('admin/application/deny') }}/{{ $application->id}}" data-token="{{ Session::getToken() }}" data-method="post">Deny Application</button>
                        <button class="btn btn-yellow action_confirm" href="{{ URL::to('admin/application/accept') }}/{{ $application->id}}" data-token="{{ Session::getToken() }}" data-method="post">Accept Application</button></td>
                    </tr>
                </table>

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
