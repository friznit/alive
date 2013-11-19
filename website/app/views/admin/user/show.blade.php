@extends('admin.layouts.default')

{{-- Content --}}
@section('content')

@if (Sentry::check())


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

                <h2>Profile</h2>

                <p><em>Account created: {{ $user->created_at }}</em></p>
                <p><em>Last Updated: {{ $user->updated_at }}</em></p>

                <table class="table table-hover">
                    <tbody>
                        <tr>
                            <td>Email</td>
                            <td>{{{ $user->email }}}</td>
                        </tr>
                        <tr>
                            <td>First Name</td>
                            <td>{{{ $user->first_name }}}</td>
                        </tr>
                        <tr>
                            <td>Last Name</td>
                            <td>{{{ $user->last_name }}}</td>
                        </tr>
                    </tbody>
                </table>

                <button class="btn btn-yellow" onClick="location.href='{{ URL::to('admin/user/edit') }}/{{ $user->id}}'">Edit Profile</button>

                <br/><br/>

            </div>
        </div>
    </div>
</div>

@endif


@stop
