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
                    	

                        <img style="max-width:100%" id="myImgId" alt="Global Map" src="{{ URL::to('/') }}/img/map_background.png" />
                        
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

            <div class="col-md-4">
                <div class="panel panel-dark">
                    <div class="panel-heading">
                        <h3 class="panel-title">Edit Area of Operation</h3>
                    </div>
                    <form action="{{ URL::to('admin/ao/edit') }}/{{ $ao->id }}" method="post">

                        {{ Form::token() }}

                        <div class="panel-body">

                             <div class="form-group {{ $errors->has('name') ? 'has-error' : '' }}" for="name">
                                <label class="control-label" for="name">Area Name</label>
                                <input name="name" value="{{ (Request::old('name')) ? Request::old("name") : $ao->name }}" type="text" class="form-control" placeholder="username">
                                <?php
                                if($errors->has('name')){
                                    echo '<span class="label label-danger">' . $errors->first('name') . '</span>';
                                }
                                ?>
                            </div>

                            <div class="form-group {{ ($errors->has('size')) ? 'has-error' : '' }}" for="size">
                                <label class="control-label" for="size">Size</label>
                                <input name="size" value="{{ (Request::old('size')) ? Request::old("size") : $ao->size }}" type="text" class="form-control" placeholder="size">
                                <?php
                                if($errors->has('size')){
                                    echo '<span class="label label-danger">' . $errors->first('size') . '</span>';
                                }
                                ?>
                            </div>

                            <div class="form-group {{ ($errors->has('configName')) ? 'has-error' : '' }}" for="configName">
                                <label class="control-label" for="configName">Configuration Name</label>
                                <input name="configName" value="{{ (Request::old('configName')) ? Request::old("configName") : $ao->configName }}" type="text" class="form-control" placeholder="configName">
                                <?php
                                if($errors->has('configName')){
                                    echo '<span class="label label-danger">' . $errors->first('configName') . '</span>';
                                }
                                ?>
                            </div>

                            <div class="form-group {{ ($errors->has('imageMapX')) ? 'has-error' : '' }}" for="imageMapX">
                                <label class="control-label" for="imageMapX">Position on Global Map (X)</label>
                                <input id="imageMapX" name="imageMapX" value="{{ (Request::old('imageMapX')) ? Request::old("imageMapX") : $ao->imageMapX }}" type="text" class="form-control" placeholder="imageMapX">
                                <?php
                                if($errors->has('imageMapX')){
                                    echo '<span class="label label-danger">' . $errors->first('imageMapX') . '</span>';
                                }
                                ?>
                            </div>
                            
                           <div class="form-group {{ ($errors->has('imageMapY')) ? 'has-error' : '' }}" for="imageMapY">
                                <label class="control-label" for="imageMapY">Position on Global Map (Y)</label>
                                <input id="imageMapY" name="imageMapY" value="{{ (Request::old('imageMapY')) ? Request::old("imageMapY") : $ao->imageMapY }}" type="text" class="form-control" placeholder="imageMapY">
                                <?php
                                if($errors->has('imageMapY')){
                                    echo '<span class="label label-danger">' . $errors->first('imageMapY') . '</span>';
                                }
                                ?>
                            </div>
                            
                             <div class="form-group {{ ($errors->has('latitude')) ? 'has-error' : '' }}" for="latitude">
                                <label class="control-label" for="latitude">Latitude</label>
                                <input name="latitude" value="{{ (Request::old('latitude')) ? Request::old("latitude") : $ao->latitude }}" type="text" class="form-control" placeholder="latitude">
                                <?php
                                if($errors->has('latitude')){
                                    echo '<span class="label label-danger">' . $errors->first('latitude') . '</span>';
                                }
                                ?>
                            </div>
                            
                            <div class="form-group {{ ($errors->has('longitude')) ? 'has-error' : '' }}" for="longitude">
                                <label class="control-label" for="longitude">Longitude</label>
                                <input name="longitude" value="{{ (Request::old('longitude')) ? Request::old("longitude") : $ao->longitude }}" type="text" class="form-control" placeholder="longitude">
                                <?php
                                if($errors->has('longitude')){
                                    echo '<span class="label label-danger">' . $errors->first('longitude') . '</span>';
                                }
                                ?>
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
            
            <div class="col-md-6">

                <div class="panel panel-dark">
                    <div class="panel-heading">
                        <h3 class="panel-title">Change Image</h3>
                    </div>

                    <form action="{{ URL::to('admin/ao/changeimage') }}/{{ $ao->id }}" method="post" enctype="multipart/form-data">
                        {{ Form::token() }}

                        <div class="strip">
                  				 <p>We recommend using the Arma 3 Map UI image here</p>
                        </div>

                        <div class="panel-body avatars">
                            <p>Medium (512px x 256px)</p>
                            <img src="<?= $ao->image->url('mediumAO') ?>" ><br/><br/>
                            <p>Thumbnail (256px x 128px)</p>
                            <img src="<?= $ao->image->url('thumbAO') ?>" ><br/><br/>
                            <input type="file" id="image_upload" name="image" />
                        </div>
                        <div class="panel-footer clearfix">
                            <div class="btn-toolbar pull-right" role="toolbar">
                                <input class="btn btn-yellow" type="submit" value="Change Image">
                            </div>
                        </div>
                    </form>
                </div>
             </div>
             <div class="col-md-6">

                <div class="panel panel-dark">
                    <div class="panel-heading">
                        <h3 class="panel-title">Change Picture</h3>
                    </div>

                    <form action="{{ URL::to('admin/ao/changepic') }}/{{ $ao->id }}" method="post" enctype="multipart/form-data">
                        {{ Form::token() }}

                        <div class="strip">
                  				 <p>We recommend using the Arma 3 Map Picture here</p>
                        </div>

                        <div class="panel-body avatars">
                            <p>Small (512px x 512px)</p>
                            <img src="<?= $ao->pic->url('smallPic') ?>" ><br/><br/>
                            <p>Thumbnail (256px x 256px)</p>
                            <img src="<?= $ao->pic->url('thumbPic') ?>" ><br/><br/>
                            <input type="file" id="pic_upload" name="pic" />
                        </div>
                        <div class="panel-footer clearfix">
                            <div class="btn-toolbar pull-right" role="toolbar">
                                <input class="btn btn-yellow" type="submit" value="Change Picture">
                            </div>
                        </div>
                    </form>
                </div>
			</div>
		</div>
    </div>
</div>

@stop
