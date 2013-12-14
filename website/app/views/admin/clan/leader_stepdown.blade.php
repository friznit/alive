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

            <div class="col-md-6 col-md-offset-3">
                <div class="panel panel-dark">
                    <div class="panel-heading">
                        <h3 class="panel-title">Select a replacement leader</h3>
                    </div>
                    <form action="{{ URL::to('admin/clan/leaderstepdown') }}/{{ $clan->id }}" method="post">

                        {{ Form::token() }}

                        <div class="panel-body">

                            <div class="form-group {{ ($errors->has('name')) ? 'has-error' : '' }}" for="name">
                                <label class="control-label" for="name">Name</label>
                                <select name="replacement" class="form-control">
                                @foreach ($members as $member)
                                    @if ($auth['userId'] != $member->user_id)
                                    <option value="{{ $member->user_id }}">{{{ $member->username }}}</option>
                                    @endif
                                @endforeach
                                </select>
                            </div>

                        </div>
                        <div class="panel-footer clearfix">
                            <div class="btn-toolbar pull-right" role="toolbar">
                                <input class="btn btn-yellow" type="submit" value="Stepdown as Leader">
                            </div>
                        </div>
                    </form>
                </div>
            </div>

        </div>
    </div>
</div>

@stop
