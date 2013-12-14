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
                        <h3 class="panel-title">Edit Group</h3>
                    </div>

                    <form action="{{ URL::to('admin/group') }}/{{ $group['id'] }}" method="POST">

                        {{ Form::token() }}

                        <div class="panel-body">

                            <input type="hidden" name="_method" value="PUT">

                            <div class="form-group {{ ($errors->has('name')) ? 'has-error' : '' }}" for="name">
                                <label class="control-label" for="name">Name</label>
                                <input name="name" value="{{ (Request::old('name')) ? Request::old('name') : $group->name }}" type="text" class="form-control" placeholder="Name">
                                <?php
                                if($errors->has('name')){
                                    echo '<span class="label label-danger">' . $errors->first('name') . '</span>';
                                }
                                ?>
                            </div>

                            <div class="form-group" for="permissions">
                                <label class="control-label" for="permissions">Permissions</label>
                                <label class="checkbox inline">
                                    <input type="checkbox" value="1" name="adminPermissions" @if ( isset($group['permissions']['admin']) ) checked @endif> Admin
                                </label>
                                <label class="checkbox inline">
                                    <input type="checkbox" value="1" name="userPermissions" @if ( isset($group['permissions']['users']) ) checked @endif> User
                                </label>
                                <label class="checkbox inline">
                                    <input type="checkbox" value="1" name="clansPermissions" @if ( isset($group['permissions']['clans']) ) checked @endif> Clans
                                </label>
                                <label class="checkbox inline">
                                    <input type="checkbox" value="1" name="clanPermissions" @if ( isset($group['permissions']['clan']) ) checked @endif> Clan
                                </label>
                                <label class="checkbox inline">
                                    <input type="checkbox" value="1" name="clanMemberPermissions" @if ( isset($group['permissions']['clanmembers']) ) checked @endif> Clan Members
                                </label>
                            </div>

                        </div>
                        <div class="panel-footer clearfix">
                            <div class="btn-toolbar pull-right" role="toolbar">
                                <input class="btn btn-yellow" type="submit" value="Save">
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

@stop