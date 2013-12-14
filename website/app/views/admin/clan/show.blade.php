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

            <div class="col-md-12">

                <h2>{{{ $clan->name }}}</h2>

                <p><em>Group created: {{ $clan->created_at }}</em></p>
                <p><em>Last Updated: {{ $clan->updated_at }}</em></p>

                <img src="{{ $clan->avatar->url('medium') }}" ><br/><br/>

                <h4>Members</h4>
                <table class="table table-hover">
                    <tbody>
                        @foreach ($members as $member)
                        <?php

                            $user = Sentry::findUserById($member->user_id);
                            $memberIsGrunt = $user->inGroup($auth['gruntGroup']);
                            $memberIsOfficer = $user->inGroup($auth['officerGroup']);
                            $memberIsLeader = $user->inGroup($auth['leaderGroup']);

                        ?>
                        <tr>
                            <td>{{{ $member->username }}}</td>
                            @if ($memberIsLeader)
                                <td>Leader</td>
                            @endif
                            @if ($memberIsOfficer)
                            <td>Officer</td>
                            @endif
                            @if ($memberIsGrunt)
                            <td></td>
                            @endif
                            <td>{{{ $member->remark }}}</td>
                            <td>
                                @if (($auth['isAdmin'] || $auth['isLeader'] || $auth['isOfficer']) && ($auth['userId'] != $member->user_id))
                                    <button class="btn btn-default" onClick="location.href='{{ URL::to('admin/clan/memberedit') }}/{{ $member->user_id}}'">Edit</button>
                                    <button class="btn btn-default action_confirm" href="{{ URL::to('admin/clan/removemember') }}/{{ $member->user_id}}" data-token="{{ Session::getToken() }}" data-method="post">Remove member</button>
                                    @if ($memberIsGrunt)
                                    <button class="btn btn-default action_confirm" href="{{ URL::to('admin/clan/promote') }}/{{ $member->user_id}}" data-token="{{ Session::getToken() }}" data-method="post">Promote to Officer</button>
                                    @endif
                                @endif
                                @if (($auth['isAdmin'] || $auth['isLeader']) && ($auth['userId'] != $member->user_id))
                                    @if ($memberIsOfficer)
                                    <button class="btn btn-default action_confirm" href="{{ URL::to('admin/clan/demote') }}/{{ $member->user_id}}" data-token="{{ Session::getToken() }}" data-method="post">Demote to member</button>
                                    @endif
                                @endif
                            </td>
                        </tr>
                        @endforeach
                    </tbody>
                </table>

                <?php echo $members->links(); ?>

                @if ($auth['isLeader'])
                <button class="btn btn-yellow" onClick="location.href='{{ URL::to('admin/clan/leaderstepdown') }}/{{ $clan->id}}'">Step down as Leader</button>
                <button class="btn btn-yellow" onClick="location.href='{{ URL::to('admin/clan/edit') }}/{{ $clan->id}}'">Group Settings</button>
                <button class="btn btn-yellow" onClick="location.href='{{ URL::to('admin/clan/edit') }}/{{ $clan->id}}'">Add Group members</button>
                @endif
                @if ($auth['isOfficer'])
                <button class="btn btn-yellow action_confirm" href="{{ URL::to('admin/clan/officerstepdown') }}/{{ $clan->id}}" data-token="{{ Session::getToken() }}" data-method="post">Step down as Officer</button>
                @endif

                @if ($auth['isOfficer'] || $auth['isGrunt'])
                <button class="btn btn-yellow action_confirm" href="{{ URL::to('admin/clan/leave') }}/{{ $clan->id}}" data-token="{{ Session::getToken() }}" data-method="post">Leave this group</button>
                @endif

                @if ($auth['isAdmin'] || $auth['isLeader'] || $auth['isOfficer'])

                @if (isset($applications))

                <h2>Join Applications</h2>
                <table class="table table-hover">
                    <thead>
                        <th>Name</th>
                        <th>Age Group</th>
                        <th>Country</th>
                        <th>Actions</th>
                    </thead>
                    <tbody>
                    @foreach ($applications as $application)
                    <tr>
                        <td>{{{ $application->user->profile->username }}}</a></td>
                        <td>{{{ $application->age_group }}}</a></td>
                        <td>{{{ $application->country }}}</a></td>
                        <td>
                            <button class="btn btn-default" onClick="location.href='{{ URL::to('admin/application/showrecipient') }}/{{ $application->id}}'">View</button>
                            <button class="btn btn-default action_confirm" href="{{ URL::to('admin/application/deleterecipient') }}/{{ $application->id}}" data-token="{{ Session::getToken() }}" data-method="post">Delete</button>
                        </td>
                    </tr>
                    @endforeach
                    </tbody>
                </table>

                @endif

                @endif


                <br/><br/>

            </div>
        </div>
    </div>
</div>

@stop
