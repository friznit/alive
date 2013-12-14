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
                        <h3 class="panel-title">Edit Member</h3>
                    </div>
                    <form action="{{ URL::to('admin/clan/memberedit') }}/{{ $member->user_id }}" method="post">

                        {{ Form::token() }}

                        <div class="panel-body">

                            <div class="form-group {{ $errors->has('a3ID') ? 'has-error' : '' }}" for="a3ID">
                                <label class="control-label" for="a3ID">Arma 3 ID</label>
                                <input name="a3ID" value="{{ (Request::old('a3ID')) ? Request::old("a3ID") : $member->a3_id }}" type="text" class="form-control" placeholder="Arma 3 ID">
                                <?php
                                if($errors->has('a3ID')){
                                    echo '<span class="label label-danger">' . $errors->first('a3ID') . '</span>';
                                }
                                ?>
                            </div>

                            <div class="form-group {{ $errors->has('remark') ? 'has-error' : '' }}" for="remark">
                                <label class="control-label" for="remark">Remark</label>
                                <input name="remark" value="{{ (Request::old('remark')) ? Request::old("remark") : $member->remark }}" type="text" class="form-control" placeholder="Remark">
                                <?php
                                if($errors->has('remark')){
                                    echo '<span class="label label-danger">' . $errors->first('remark') . '</span>';
                                }
                                ?>
                            </div>

                            <!--
                            <div class="form-group {{ $errors->has('a2ID') ? 'has-error' : '' }}" for="a2ID">
                                <label class="control-label" for="a2ID">Arma 2 ID</label>
                                <input name="a2ID" value="{{ (Request::old('a2ID')) ? Request::old("a2ID") : $member->a2_id }}" type="text" class="form-control" placeholder="Arma 2 ID">
                                <?php
                                if($errors->has('a2ID')){
                                    echo '<span class="label label-danger">' . $errors->first('a2ID') . '</span>';
                                }
                                ?>
                            </div>
                            -->

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
