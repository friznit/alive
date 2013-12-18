@extends('admin.layouts.default')

<div class="admin-panel">
    <div class="container">
        <div class="row">
            <div class="col-md-12">

            {{-- Content --}}
            @section('content')

            <h2>Areas of Operation</h2>
            <div class="row">
    
                <div class="col-md-12">
                    <br/><br/>
                    @include('alerts/alerts')
                </div>
    
            </div>
            <form class="light" action="{{ URL::to('admin/ao/search') }}" method="post">

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
                            <label class="radio-inline">
                                <input type="radio" name="type" value="size"> by Size
                            </label>
                        </div>
                    </div>
                </div>

            </form>

            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Size</th>
                        <th>Config Name</th>
                        <th>Latitude</th>
                        <th>Longitude</th>
                    </tr>
                </thead>
                <tbody>
                @foreach ($allAOs as $ao)
                <tr>
                    <td><a href="{{ URL::to('admin/ao/show') }}/{{ $ao->id }}">{{{ $ao->name }}}</a></td>
                    <td>{{{ $ao->size }}}</td>
                    <td>{{{ $ao->configName }}}</td>
                    <td>{{{ $ao->latitude }}}</td>
                    <td>{{{ $ao->longitude }}}</td>
                    <td>
                        <button class="btn btn-default" onClick="location.href='{{ URL::to('admin/ao/edit') }}/{{ $ao->id}}'">Edit</button>
                        <button class="btn btn-default action_confirm" href="{{ URL::to('admin/ao/delete') }}/{{ $ao->id}}" data-token="{{ Session::getToken() }}" data-method="post">Delete</button>
                    </td>
                </tr>
                @endforeach
                </tbody>
            </table>

            <?php echo $allAOs->links(); ?>
            
            <button class="btn btn-yellow" onClick="location.href='{{ URL::to('admin/ao/create') }}'">Create a New Area of Operation</button>
            
        <br/><br/>

            </div>
        </div>
    </div>
</div>



@stop
