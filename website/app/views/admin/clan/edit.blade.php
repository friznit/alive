@extends('admin.layouts.default')

{{-- Content --}}
@section('content')

<div class="dark-panel form-holder" xmlns="http://www.w3.org/1999/html">

    <div class="container">
        <div class="row">

            <div class="col-md-12">
                @include('alerts/alerts')
            </div>

        </div>
        <div class="row">

            <div class="col-md-4">
                <div class="panel panel-dark">
                    <div class="panel-heading">
                        <h3 class="panel-title">Edit Group</h3>
                    </div>
                    <form action="{{ URL::to('admin/clan/edit') }}/{{ $clan->id }}" method="post">

                        {{ Form::token() }}

                        <div class="panel-body">

                            <div class="form-group {{ ($errors->has('name')) ? 'has-error' : '' }}" for="name">
                                <label class="control-label" for="name">Name</label>
                                <input name="name" value="{{ (Request::old('name')) ? Request::old("name") : $clan->name }}" type="text" class="form-control" placeholder="Name">
                                <?php
                                if($errors->has('name')){
                                    echo '<span class="label label-danger">' . $errors->first('name') . '</span>';
                                }
                                ?>
                            </div>

                            <div class="form-group {{ ($errors->has('title')) ? 'has-error' : '' }}" for="title">
                                <label class="control-label" for="title">Title</label>
                                <input name="title" value="{{ (Request::old('title')) ? Request::old("title") : $clan->title }}" type="text" class="form-control" placeholder="Title">
                                <?php
                                if($errors->has('title')){
                                    echo '<span class="label label-danger">' . $errors->first('title') . '</span>';
                                }
                                ?>
                            </div>

                            <div class="form-group {{ ($errors->has('tag')) ? 'has-error' : '' }}" for="tag">
                                <label class="control-label" for="tag">Tag</label>
                                <input name="tag" value="{{ (Request::old('tag')) ? Request::old("tag") : $clan->tag }}" type="text" class="form-control" placeholder="Tag">
                                <?php
                                if($errors->has('title')){
                                    echo '<span class="label label-danger">' . $errors->first('title') . '</span>';
                                }
                                ?>
                            </div>

                            <div class="form-group {{ ($errors->has('website')) ? 'has-error' : '' }}" for="website">
                                <label class="control-label" for="website">Website</label>
                                <input name="website" value="{{ (Request::old('website')) ? Request::old("website") : $clan->website }}" type="text" class="form-control" placeholder="Website">
                                <?php
                                if($errors->has('website')){
                                    echo '<span class="label label-danger">' . $errors->first('website') . '</span>';
                                }
                                ?>
                            </div>

                            <div class="form-group {{ ($errors->has('country')) ? 'has-error' : '' }}" for="country">
                                <label class="control-label" for="country">Country</label>
                                <select name="country" value="{{ (Request::old('country')) ? Request::old("country") : $clan->country }}" type="text" class="form-control" placeholder="Country">
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

                            <div class="form-group {{ ($errors->has('description')) ? 'has-error' : '' }}" for="description">
                                <label class="control-label" for="description">Description</label>
                                <textarea name="description" type="text" class="form-control" placeholder="Description">{{ (Request::old('description')) ? Request::old("description") : $clan->description }}</textarea>
                                <?php
                                if($errors->has('description')){
                                    echo '<span class="label label-danger">' . $errors->first('description') . '</span>';
                                }
                                ?>
                            </div>

                            <div class="form-group {{ ($errors->has('allowApplicants')) ? 'has-error' : '' }}" for="allowApplicants">
                                <label class="checkbox inline">
                                    <input type="checkbox" name="allowApplicants"
                                    <?php
                                        if($clan->allow_applicants){
                                            echo 'checked';
                                        }
                                    ?>> Allow applicants
                                </label>

                                <?php
                                if($errors->has('allowApplicants')){
                                    echo '<span class="label label-danger">' . $errors->first('allowApplicants') . '</span>';
                                }
                                ?>
                            </div>

                            <div class="form-group {{ ($errors->has('applicationText')) ? 'has-error' : '' }}" for="applicationText">
                                <label class="control-label" for="applicationText">Application Text</label>
                                <textarea name="applicationText" type="text" class="form-control" placeholder="Application Text">{{ (Request::old('applicationText')) ? Request::old("applicationText") : $clan->application_text }}</textarea>
                                <?php
                                if($errors->has('applicationText')){
                                    echo '<span class="label label-danger">' . $errors->first('applicationText') . '</span>';
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

            <div class="col-md-4">

                <div class="panel panel-dark">
                    <div class="panel-heading">
                        <h3 class="panel-title">Add Group Member</h3>
                    </div>

                    <form action="{{ URL::to('admin/clan/memberadd') }}/{{ $clan->id }}" method="post">
                        {{ Form::token() }}

                        <div class="panel-body">

                            <div class="form-group {{ ($errors->has('email')) ? 'has-error' : '' }}" for="email">
                                <label for="email" class="control-label">Email</label>
                                <input name="email" type="email" class="form-control" id="email" placeholder="Email" value="{{ Request::old('email') }}">
                                <?php
                                if($errors->has('email')){
                                    echo '<span class="label label-danger">' . $errors->first('email') . '</span>';
                                }
                                ?>
                            </div>

                            <div class="form-group {{ ($errors->has('username')) ? 'has-error' : '' }}" for="username">
                                <label for="username" class="control-label">User name</label>
                                <input name="username" type="username" class="form-control" id="username" placeholder="Username" value="{{ Request::old('username') }}">
                                <?php
                                if($errors->has('username')){
                                    echo '<span class="label label-danger">' . $errors->first('username') . '</span>';
                                }
                                ?>
                            </div>

                            <div class="form-group {{ ($errors->has('password')) ? 'has-error' : '' }}" for="email">
                                <label for="password" class="control-label">Password</label>
                                <input name="password" value="" type="password" class="form-control" placeholder="Password">
                                <?php
                                if($errors->has('password')){
                                    echo '<span class="label label-danger">' . $errors->first('password') . '</span>';
                                }
                                ?>
                            </div>

                            <div class="form-group {{ ($errors->has('password_confirmation')) ? 'has-error' : '' }}" for="password_confirmation">
                                <label for="password_confirmation" class="control-label">Confirm Password</label>
                                <input name="password_confirmation" value="" type="password" class="form-control" placeholder="Password again">
                                <?php
                                if($errors->has('password_confirmation')){
                                    echo '<span class="label label-danger">' . $errors->first('password_confirmation') . '</span>';
                                }
                                ?>
                            </div>

                            <div class="form-group {{ $errors->has('remark') ? 'has-error' : '' }}" for="remark">
                                <label class="control-label" for="remark">Remark</label>
                                <input name="remark" value="{{ (Request::old('remark')) }}" type="text" class="form-control" placeholder="Remark">
                                <?php
                                if($errors->has('remark')){
                                    echo '<span class="label label-danger">' . $errors->first('remark') . '</span>';
                                }
                                ?>
                            </div>

                        </div>
                        <div class="panel-footer clearfix">
                            <div class="btn-toolbar pull-right" role="toolbar">
                                <input class="btn btn-yellow" type="submit" value="Add member">
                            </div>
                        </div>
                    </form>
                </div>

                <div class="panel panel-dark">
                    <div class="panel-heading">
                        <h3 class="panel-title">Import Squad XML</h3>
                    </div>

                    <form action="{{ URL::to('admin/clan/importsquad') }}/{{ $clan->id }}" method="post">
                        {{ Form::token() }}

                        <div class="panel-body">

                            <p>Create group members via import of squad XML.</p>

                            <div class="form-group {{ ($errors->has('squadURL')) ? 'has-error' : '' }}" for="name">
                                <label class="control-label" for="name">Squad XML URL</label>
                                <input name="squadURL" type="text" class="form-control" placeholder="Squad XML URL">
                                <?php
                                if($errors->has('squadURL')){
                                    echo '<span class="label label-danger">' . $errors->first('squadURL') . '</span>';
                                }
                                ?>
                            </div>
                        </div>
                        <div class="panel-footer clearfix">
                            <div class="btn-toolbar pull-right" role="toolbar">
                                <input class="btn btn-yellow" type="submit" value="Import Squad XML File">
                            </div>
                        </div>
                    </form>
                </div>

                <div class="panel panel-dark">
                    <div class="panel-heading">
                        <h3 class="panel-title">Export Squad XML</h3>
                    </div>

                    <form action="{{ URL::to('admin/clan/exportsquad') }}/{{ $clan->id }}" method="post">
                        {{ Form::token() }}

                        <div class="panel-body">

                            <p>Create squad XML based on the current group settings.</p>

                        </div>
                        <div class="panel-footer clearfix">
                            <div class="btn-toolbar pull-right" role="toolbar">
                                <input class="btn btn-yellow" type="submit" value="Export Squad XML File">
                            </div>
                        </div>
                    </form>
                </div>

            </div>

            <div class="col-md-4">

                <div class="panel panel-dark">
                    <div class="panel-heading">
                        <h3 class="panel-title">Change Avatar</h3>
                    </div>

                    <form action="{{ URL::to('admin/clan/changeavatar') }}/{{ $clan->id }}" method="post" enctype="multipart/form-data">
                        {{ Form::token() }}

                        <div class="panel-body">
                            <img src="<?= $clan->avatar->url('medium') ?>" ><br/><br/>
                            <input type="file" id="avatar_upload" name="avatar" />
                        </div>
                        <div class="panel-footer clearfix">
                            <div class="btn-toolbar pull-right" role="toolbar">
                                <input class="btn btn-yellow" type="submit" value="Change Avatar">
                            </div>
                        </div>
                    </form>
                </div>

                <div class="panel panel-dark">
                    <div class="panel-heading">
                        <h3 class="panel-title">Delete Group</h3>
                    </div>

                    <form action="{{ URL::to('admin/clan/delete') }}/{{ $clan->id }}" method="post">
                        {{ Form::token() }}

                        <div class="panel-body">

                            <p>Delete this group and remove all members.</p>

                        </div>

                        <div class="panel-footer clearfix">
                            <div class="btn-toolbar pull-right" role="toolbar">
                                <button class="btn btn-yellow action_confirm" href="{{ URL::to('admin/clan/delete') }}/{{ $clan->id}}" data-token="{{ Session::getToken() }}" data-method="post">Delete Group</button>
                            </div>
                        </div>
                    </form>
                </div>

            </div>
        </div>
    </div>
</div>

@stop
