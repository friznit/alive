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
        
        <div class = "row">
        	<div class="col-md-13">
                <div class="panel panel-dark">
                    <div class="panel-heading">
                        <h3 class="panel-title">Select Position on Map</h3>
                    </div>
                    <div class="panel-body">
                    	

                        <img id="myImgId" alt="Global Map" src="{{ URL::to('/') }}/img/map_background.png"/>
                        
                        <script type="text/javascript">
                        <!--
						
						
                        var myImg = document.getElementById("myImgId");
                        myImg.onmousedown = GetCoordinates;
						                        //-->
                        </script>

                    </div>
                </div>
            </div>
        </div>
        <div class="row">

            <div class="col-md-4 col-md-offset-4">
                <div class="panel panel-dark">
                    <div class="panel-heading">
                        <h3 class="panel-title">Create Area of Operation</h3>
                    </div>

                    <form action="{{ URL::to('admin/ao/create') }}" method="post">

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

                            <div class="form-group {{ ($errors->has('size')) ? 'has-error' : '' }}" for="size">
                                <label class="control-label" for="size">Size</label>
                                <input name="size" value="{{ Request::old("size") }}" type="number" class="form-control" placeholder="Size">
                                <?php
                                if($errors->has('size')){
                                    echo '<span class="label label-danger">' . $errors->first('size') . '</span>';
                                }
                                ?>
                            </div>
                            
                            <div class="form-group {{ ($errors->has('configName')) ? 'has-error' : '' }}" for="configName">
                                <label class="control-label" for="configName">Configuration Name</label>
                                <input name="configName" value="{{ Request::old("configName") }}" type="text" class="form-control" placeholder="configName">
                                <?php
                                if($errors->has('configName')){
                                    echo '<span class="label label-danger">' . $errors->first('configName') . '</span>';
                                }
                                ?>
                            </div>

                            <div class="form-group {{ ($errors->has('imageMapX')) ? 'has-error' : '' }}" for="imageMapX">
							<label class="control-label" for="imageMapX">Position (X)</label>
                                <input id="imageMapX" name="imageMapX" value="{{ Request::old("imageMapX") }}" type="number" class="form-control">
                                <?php
                                if($errors->has('imageMapX')){
                                    echo '<span class="label label-danger">' . $errors->first('imageMapX') . '</span>';
                                }
                                ?>
                            </div>
                            
                            <div class="form-group {{ ($errors->has('imageMapY')) ? 'has-error' : '' }}" for="imageMapY">
							<label class="control-label" for="imageMapY">Position (Y)</label>
                                <input id="imageMapY" name="imageMapY" value="{{ Request::old("imageMapY") }}" type="number" class="form-control">
                                <?php
                                if($errors->has('imageMapY')){
                                    echo '<span class="label label-danger">' . $errors->first('imageMapY') . '</span>';
                                }
                                ?>
                            </div>
                            
                            <div class="form-group {{ ($errors->has('latitude')) ? 'has-error' : '' }}" for="latitude">
                                <label class="control-label" for="latitude">Latitude</label>
                                <input name="latitude" value="{{ Request::old("latitude") }}" type="number" class="form-control" placeholder="latitude">
                                <?php
                                if($errors->has('latitude')){
                                    echo '<span class="label label-danger">' . $errors->first('latitude') . '</span>';
                                }
                                ?>
                            </div>
                            
                        	<div class="form-group {{ ($errors->has('longitude')) ? 'has-error' : '' }}" for="longitude">
                                <label class="control-label" for="longitude">Longitude</label>
                                <input name="longitude" value="{{ Request::old("longitude") }}" type="number" class="form-control" placeholder="longitude">
                                <?php
                                if($errors->has('longitude')){
                                    echo '<span class="label label-danger">' . $errors->first('longitude') . '</span>';
                                }
                                ?>
                            </div>

                        </div>
                        <div class="panel-footer clearfix">
                            <div class="btn-toolbar pull-right" role="toolbar">
                                <input class="btn btn-yellow" type="submit" value="Create New Area of Operation">
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

@stop