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
                        <h3 class="panel-title">Create Group</h3>
                    </div>

                    <form action="{{ URL::to('admin/clan/create') }}" method="post">

                        {{ Form::token() }}

                        <div class="panel-body">

                            <div class="form-group {{ ($errors->has('newGroup')) ? 'has-error' : '' }}" for="newGroup">
                                <label class="control-label" for="newGroup">Group Name</label>
                                <input name="newGroup" value="{{ Request::old("newGroup") }}" type="text" class="form-control" placeholder="New Group">
                                <?php
                                if($errors->has('newGroup')){
                                    echo '<span class="label label-danger">' . $errors->first('newGroup') . '</span>';
                                }
                                ?>
                            </div>

                            <div class="form-group {{ ($errors->has('tag')) ? 'has-error' : '' }}" for="tag">
                                <label class="control-label" for="tag">Tag</label>
                                <input name="tag" value="{{ Request::old('tag') }}" type="text" class="form-control" placeholder="Tag">
                                <?php
                                if($errors->has('title')){
                                    echo '<span class="label label-danger">' . $errors->first('title') . '</span>';
                                }
                                ?>
                            </div>

                        </div>
                        <div class="panel-footer clearfix">
                            <div class="btn-toolbar pull-right" role="toolbar">
                                <input class="btn btn-yellow" type="submit" value="Create New Group">
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

@stop