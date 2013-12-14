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

                <h2>{{{ $clan->name }}}</h2>

                <p><em>Group created: {{ $clan->created_at }}</em></p>
                <p><em>Last Updated: {{ $clan->updated_at }}</em></p>

                <img src="{{ $clan->avatar->url('medium') }}" ><br/><br/>

                <h4>Application Details</h4>
                <p>{{{ $clan->application_text }}}</p>

                <br/><br/>

            </div>
            <div class="col-md-6">
                <div class="panel panel-dark">
                    <div class="panel-heading">
                        <h3 class="panel-title">Lodge Application</h3>
                    </div>
                    <form action="{{ URL::to('admin/application/lodge') }}/{{ $clan->id }}" method="post">

                        {{ Form::token() }}

                        <div class="panel-body">

                            <div class="form-group {{ ($errors->has('username')) ? 'has-error' : '' }}" for="username">
                                <label class="control-label" for="username">Name</label>
                                <input name="username" value="{{ (Request::old('username')) ? Request::old("username") : $profile->username }}" type="text" class="form-control" placeholder="Username">
                                <?php
                                if($errors->has('username')){
                                    echo '<span class="label label-danger">' . $errors->first('username') . '</span>';
                                }
                                ?>
                            </div>

                            <div class="form-group {{ ($errors->has('ageGroup')) ? 'has-error' : '' }}" for="ageGroup">
                                <label class="control-label" for="ageGroup">Your age group</label><br/>
                                <label class="checkbox-inline">
                                    <input type="radio" name="ageGroup" value="10-16"/> 10-16
                                </label>
                                <label class="checkbox-inline">
                                    <input type="radio" name="ageGroup" value="16-20"/> 16-20
                                </label>
                                <label class="checkbox-inline">
                                    <input type="radio" name="ageGroup" value="20-26"/> 20-26
                                </label>
                                <label class="checkbox-inline">
                                    <input type="radio" name="ageGroup" value="26-35"/> 26-35
                                </label>
                                <label class="checkbox-inline">
                                    <input type="radio" name="ageGroup" value="35-50"/> 35-50
                                </label>
                            </div>

                            <div class="form-group {{ ($errors->has('country')) ? 'has-error' : '' }}" for="country">
                                <label class="control-label" for="country">Country</label>
                                <select name="country" type="text" class="form-control" placeholder="Country">
                                @foreach ($countries as $key =>$value)
                                @if ($key == $clan->country)
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

                            <div class="form-group {{ ($errors->has('note')) ? 'has-error' : '' }}" for="note">
                                <label class="control-label" for="note">Application Note</label>
                                <textarea name="note" type="text" class="form-control" placeholder="Enter Note"></textarea>
                                <?php
                                if($errors->has('note')){
                                    echo '<span class="label label-danger">' . $errors->first('note') . '</span>';
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
        </div>
    </div>
</div>

@endif

@stop
