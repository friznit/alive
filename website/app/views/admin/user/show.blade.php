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

                <h2>{{{ $profile->username }}}</h2>

                <?php
                    if(!is_null($profile->country)){
                ?>
                <img src="{{ URL::to('/') }}/img/flags_iso/32/{{ strtolower($profile->country) }}.png" alt="{{ $profile->country_name }}" title="{{ $profile->country_name }}"/>
                <?php
                    }
                ?>

                <p><em>Account created: {{ $user->created_at }}</em></p>
                <p><em>Last Updated: {{ $user->updated_at }}</em></p>

                <img src="{{ $profile->avatar->url('medium') }}" ><br/><br/>


                <button class="btn btn-yellow" onClick="location.href='{{ URL::to('admin/user/edit') }}/{{ $user->id}}'">Edit Profile</button>

                <br/><br/>

            </div>

            <div class="col-md-6">

                @if (!$clan)

                    <h2>Group</h2>

                    <p>You are not a member of a group</p>

                    <p>Are you the leader of a group?</p>

                    <table class="table table-hover">
                        <tbody>
                        <tr>
                            <td><button class="btn btn-yellow" onClick="location.href='{{ URL::to('admin/clan/create') }}'">Create a group</button></td>
                        </tr>
                        </tbody>
                    </table>

                    <p>Do you want to join an existing group?</p>

                    <table class="table table-hover">
                        <tbody>
                        <tr>
                            <td><button class="btn btn-yellow" onClick="location.href='{{ URL::to('admin/application/') }}'">Find a group to join</button></td>
                        </tr>
                        </tbody>
                    </table>

                    @if (isset($applications))

                    <h4>Open Group Applications</h4>
                    <table class="table table-hover">
                        <thead>
                            <th>Name</th>
                            <th>Actions</th>
                        </thead>
                        <tbody>
                        @foreach ($applications as $application)
                        <tr>
                            <td>{{{ $application->clan->name }}}</a></td>
                            <td>
                                <button class="btn btn-default" onClick="location.href='{{ URL::to('admin/application/showapplicant') }}/{{ $application->id}}'">View</button>
                                <button class="btn btn-default action_confirm" href="{{ URL::to('admin/application/deleteapplicant') }}/{{ $application->id}}" data-token="{{ Session::getToken() }}" data-method="post">Cancel</button>
                            </td>
                        </tr>
                        @endforeach
                        </tbody>
                    </table>

                    @endif

                @elseif ($profile->clan_id > 0)

                    <h2>{{{ $clan->name }}}</h2>
                    <img src="{{ $clan->avatar->url('medium') }}" ><br/><br/>

                    <table class="table table-hover">
                        <tbody>
                        <tr>
                            <td><button class="btn btn-yellow" onClick="location.href='{{ URL::to('admin/clan/show') }}/{{ $clan->id }}'">Group details</button></td>
                        </tr>
                        </tbody>
                    </table>
                    @if ($auth['isLeader'])
                        <p>Group Leader of {{{ $clan->name }}}</p>
                    @elseif ($auth['isOfficer'])
                        <p>Group Officer in {{{ $clan->name }}}</p>
                    @else
                        <p>Group Member of {{{ $clan->name }}}</p>
                    @endif

                @endif

            </div>

        </div>
    </div>
</div>

@stop
