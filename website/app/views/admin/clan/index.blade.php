@extends('admin.layouts.default')

<div class="admin-panel">
    <div class="container">
        <div class="row">
            <div class="col-md-12">

            {{-- Content --}}
            @section('content')

            <h2>Groups</h2>

            <form class="light" action="{{ URL::to('admin/clan/search') }}" method="post">

                {{ Form::token() }}

                <div class="row">
                    <div class="col-lg-4">
                        <div class="input-group">
                            <input type="text" name="query" class="form-control">
                            <span class="input-group-btn">
                                <input class="btn btn-default" type="submit" value="Search">
                            </span>
                        </div>
                        <?php
                        if($errors->has('query')){
                            echo '<span class="label label-danger">' . $errors->first('query') . '</span>';
                        }
                        ?>
                        <div class="input-group">
                            <label class="radio-inline">
                                <input type="radio" name="type" value="name" checked> by Name
                            </label>
                        </div>
                    </div>
                </div>

            </form>

            <table class="table table-hover">
                <thead>
                    <th>Name</th>
                    <th>Options</th>
                </thead>
                <tbody>
                @foreach ($allClans as $clan)
                <tr>
                    <td><a href="{{ URL::to('admin/clan/show') }}/{{ $clan->id }}">{{{ $clan->name }}}</a></td>
                    <td>
                        <button class="btn btn-default" onClick="location.href='{{ URL::to('admin/clan/edit') }}/{{ $clan->id}}'">Edit</button>
                        <button class="btn btn-default action_confirm" href="{{ URL::to('admin/clan/delete') }}/{{ $clan->id}}" data-token="{{ Session::getToken() }}" data-method="post">Delete</button>
                    </td>
                </tr>
                @endforeach
                </tbody>
            </table>

            <?php echo $allClans->links(); ?>

            </div>
        </div>
    </div>
</div>

@stop
