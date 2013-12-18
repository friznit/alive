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

            <div class="col-md-4 col-md-offset-4">
                <div class="panel panel-dark">
                    <div class="panel-heading">
                        <h3 class="panel-title">Create Server</h3>
                    </div>

                    <form action="{{ URL::to('admin/server/create') }}/{{ $clan->id }}" method="post">

                        {{ Form::token() }}

                        <div class="panel-body">

                            <div class="form-group {{ ($errors->has('name')) ? 'has-error' : '' }}" for="name">
                                <label class="control-label" for="name">Name</label>
                                <input name="name" value="{{ Request::old("name") }}" type="text" class="form-control" placeholder="Name">
                                <?php
                                if($errors->has('name')){
                                    echo '<span class="label label-danger">' . $errors->first('name') . '</span>';
                                }
                                ?>
                            </div>

                            <div class="form-group {{ ($errors->has('hostname')) ? 'has-error' : '' }}" for="hostname">
                                <label class="control-label" for="hostname">Hostname</label>
                                <input name="hostname" value="{{ Request::old("hostname") }}" type="text" class="form-control" placeholder="Hostname">
                                <?php
                                if($errors->has('hostname')){
                                    echo '<span class="label label-danger">' . $errors->first('hostname') . '</span>';
                                }
                                ?>
                            </div>

                            <div class="form-group {{ ($errors->has('ip')) ? 'has-error' : '' }}" for="ip">
                                <label class="control-label" for="ip">IP Address</label>
                                <input name="ip" value="{{ Request::old("ip") }}" type="text" class="form-control" placeholder="IP Address">
                                <?php
                                if($errors->has('ip')){
                                    echo '<span class="label label-danger">' . $errors->first('ip') . '</span>';
                                }
                                ?>
                            </div>

                            <div class="form-group {{ ($errors->has('note')) ? 'has-error' : '' }}" for="note">
                                <label class="control-label" for="note">Notes</label>
                                <textarea name="note" class="form-control" placeholder="Notes">{{ Request::old("note") }}</textarea>
                                <?php
                                if($errors->has('note')){
                                    echo '<span class="label label-danger">' . $errors->first('note') . '</span>';
                                }
                                ?>
                            </div>

                        </div>
                        <div class="panel-footer clearfix">
                            <div class="btn-toolbar pull-right" role="toolbar">
                                <input class="btn btn-yellow" type="submit" value="Create New Server">
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

@stop