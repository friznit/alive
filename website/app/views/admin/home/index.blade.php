@extends('admin.layouts.default')

{{-- Content --}}
@section('content')


<div class="admin-panel">
    <div class="container">
        <div class="row">
            <div class="col-md-12">

                <h2>Admin</h2>

                @include('alerts/alerts')

            </div>
        </div>
    </div>
</div>


@stop