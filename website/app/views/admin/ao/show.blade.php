@extends('admin.layouts.default')

{{-- Content --}}
@section('content')

<div class="admin-panel">
    <div class="container">
        <div class="row">

            <div class="col-md-12">
                <br/><br/>
                @include('alerts/alerts')
            </div>

        </div>
        <div class="row">

            <div class="col-md-6">

                <h2>
                    {{{ $ao->name }}}
                </h2>

                <img src="{{ $ao->image->url('mediumAO') }}" ><br/><br/>
                
                <p>Lat:{{{ $ao->latitude }}} <br /> Long:{{{ $ao->longitude }}}</p>

                <table class="table">
                    <tr>
                        <td>Size</td>
                        <td>{{ $ao->size }}</td>
                    </tr>
                    <tr>
                        <td>Config Name</td>
                        <td>{{ $ao->configName }}</td>
                    </tr>
                    <tr>
                        <td>Created</td>
                        <td>{{ $ao->created_at }}</td>
                    </tr>
                    <tr>
                        <td>Updated</td>
                        <td>{{ $ao->updated_at }}</td>
                    </tr>
                    @if ($auth['isAdmin'])
                    <tr>
                        <td>
                            <button class="btn btn-yellow" onClick="location.href='{{ URL::to('admin/ao/edit') }}/{{ $ao->id}}'">Edit Area of Operation</button>
                        </td>
                        <td></td>
                    </tr>
                    @endif
                </table>

            </div>
            <div class="col-md-6">
            	<img src="{{ $ao->pic->url('mediumPic') }}" ><br/><br/>
            </div>
        </div>
    </div>
</div>

@stop
