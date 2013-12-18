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

            <div class="col-md-4">

                <h2>
                    {{{ $server->name }}}
                </h2>

                <p>{{{ $server->note }}}</p>

                <table class="table">
                    <tr>
                        <td>Created</td>
                        <td>{{ $server->created_at }}</td>
                    </tr>
                    <tr>
                        <td>Updated</td>
                        <td>{{ $server->updated_at }}</td>
                    </tr>
                    @if ($auth['isLeader'])
                    <tr>
                        <td>
                            <button class="btn btn-yellow" onClick="location.href='{{ URL::to('admin/server/edit') }}/{{ $server->id}}'">Server Settings</button>
                        </td>
                        <td></td>
                    </tr>
                    @endif
                </table>

            </div>
        </div>
    </div>
</div>

@stop
