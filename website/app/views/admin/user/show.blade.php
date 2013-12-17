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
                    @if ($clan)
                    [{{{ $clan->tag }}}]
                    @endif
                    {{{ $profile->username }}}
                </h2>

                <img src="{{ $profile->avatar->url('medium') }}" ><br/><br/>

                <table class="table">
                    @if (!is_null($profile->country))
                    <tr>
                        <td>Country</td>
                        <td><img src="{{ URL::to('/') }}/img/flags_iso/32/{{ strtolower($profile->country) }}.png" alt="{{ $profile->country_name }}" title="{{ $profile->country_name }}"/></td>
                    </tr>
                    @endif
                    @if (!is_null($profile->twitch_stream) && !$profile->twitch_stream=='')
                    <tr>
                        <td>Twitch Stream</td>
                        <td><a target="_blank" href="{{{ $profile->twitch_stream }}}">{{{ $profile->twitch_stream }}}</a></td>
                    </tr>
                    @endif
                    <tr>
                        <td>Created</td>
                        <td>{{ $user->created_at }}</td>
                    </tr>
                    <tr>
                        <td>Updated</td>
                        <td>{{ $user->updated_at }}</td>
                    </tr>
                    <tr>
                        <td><button class="btn btn-yellow" onClick="location.href='{{ URL::to('admin/user/edit') }}/{{ $user->id}}'">Edit Profile</button></td>
                        <td></td>
                    </tr>
                </table>

            </div>

            <div class="col-md-4 col-md-offset-1">

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
                    <img src="{{ $clan->avatar->url('thumb') }}" ><br/><br/>

                    <?php

                    $userIsOfficer = $user->inGroup($auth['officerGroup']);
                    $userIsLeader = $user->inGroup($auth['leaderGroup']);

                    ?>

                    <table class="table table-hover">
                        <tbody>
                        <tr>
                            @if ($userIsLeader)
                            <td>Position</td>
                            <td>Group Leader of {{{ $clan->name }}}</td>
                            @elseif ($userIsOfficer)
                            <td>Position</td>
                            <td>Group Officer in {{{ $clan->name }}}</td>
                            @else
                            <td>Position</td>
                            <td>Group Member of {{{ $clan->name }}}</td>
                            @endif
                        </tr>
                        <tr>
                            <td><button class="btn btn-yellow" onClick="location.href='{{ URL::to('admin/clan/show') }}/{{ $clan->id }}'">Group details</button></td>
                            <td></td>
                        </tr>
                        </tbody>
                    </table>

                @endif

                @if (is_null($profile->remote_id) && $profile->clan_id > 0)

                <h2>Cloud Connection</h2>

                <p>You are not connected to the cloud data store</p>

                <table class="table table-hover">
                    <tbody>
                    <tr>
                        <td><button class="btn btn-yellow" onClick="location.href='{{ URL::to('admin/user/connect') }}/{{ $clan->id }}'">Connect</button></td>
                    </tr>
                    </tbody>
                </table>

                @endif

            </div>

        </div>
    </div>
</div>

@stop
