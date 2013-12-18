@extends('admin.layouts.default')

<div class="admin-panel">
    <div class="container">
        <div class="row">
            <div class="col-md-12">

            {{-- Content --}}
            @section('content')

            <h2>Search Results for "{{{ $query }}}"</h2>

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
                @foreach ($allaos as $ao)
                <tr>
                    <td><a href="{{ URL::to('admin/ao/show') }}/{{ $ao->name }}">{{{ $ao->name }}}</a></td>
                    <td>{{{ $ao->size}}}</td>
                    <td>{{{ $ao->configName }}}</td>
                    <td>{{{ $ao->latitude }}}</td>
                    <td>{{{ $ao->longitude }}}</td>
                </tr>
                @endforeach
                </tbody>
            </table>

            <?php echo $allaos->links(); ?>

            </div>
        </div>
    </div>
</div>



@stop
