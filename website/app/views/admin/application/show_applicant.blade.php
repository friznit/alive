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

            <div class="col-md-4">

                <h2>
                    @if ($clan)
                    [{{{ $clan->tag }}}]
                    @endif
                    {{{ $clan->name }}}
                </h2>

                <img src="{{ $clan->avatar->url('medium') }}" ><br/><br/>

                <table class="table">
                    @if (!is_null($clan->country))
                    <tr>
                        <td>Country</td>
                        <td><img src="{{ URL::to('/') }}/img/flags_iso/32/{{ strtolower($clan->country) }}.png" alt="{{ $clan->country_name }}" title="{{ $clan->country_name }}"/><br/></td>
                    </tr>
                    @endif
                    @if (!is_null($clan->website))
                    <tr>
                        <td>Website</td>
                        <td><a href="{{{ $clan->website }}}">{{{ $clan->website }}}</a></td>
                    </tr>
                    @endif
                    <tr>
                        <td>Created</td>
                        <td>{{ $clan->created_at }}</td>
                    </tr>
                    <tr>
                        <td>Updated</td>
                        <td>{{ $clan->updated_at }}</td>
                    </tr>
                </table>

                <p>{{{ $clan->description }}}</p>

            </div>
            <div class="col-md-7 col-md-offset-1">

                <h2>
                    {{{ $clan->name }}} Response
                </h2>

                @if ($application->denied === 1)
                <p class="well">Your application has been denied</p><br/>
                @else

                <table class="table">
                    <tr>
                        <td>{{{ $application->response }}}</td>
                    </tr>
                </table>

                <h2>Your submission</h2>

                <div class="panel panel-dark">
                    <div class="panel-heading">
                        <h3 class="panel-title">Update Application</h3>
                    </div>
                    <form action="{{ URL::to('admin/application/updateapplicant') }}/{{ $application->id }}" method="post">

                        {{ Form::token() }}

                        <div class="panel-body">

                            <div class="form-group {{ ($errors->has('note')) ? 'has-error' : '' }}" for="note">
                                <label class="control-label" for="note">Application Submission</label>
                                <textarea name="note" type="text" class="form-control" placeholder="Enter Note">{{ (Request::old('note')) ? Request::old("note") : $application->note }}</textarea>
                                <?php
                                if($errors->has('note')){
                                    echo '<span class="label label-danger">' . $errors->first('note') . '</span>';
                                }
                                ?>
                            </div>

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

@endif

@stop
