@extends('admin.layouts.default')

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

        {{-- Content --}}
        @section('content')
        <h2>Groups</h2>
        <table class="table">
            <thead>
                <th>Name</th>
                <th>Permissions</th>
                <th>Options</th>
            </thead>
            <tbody>
            @foreach ($allGroups as $group)
                <tr>
                    <td>{{ $group->name }}</td>
                    <td>
                        {{ (isset($group['permissions']['admin'])) ? '<span class="badge">Admin</span>' : ''}}
                        {{ (isset($group['permissions']['users'])) ? '<span class="badge">Users</span>' : ''}}
                        {{ (isset($group['permissions']['clans'])) ? '<span class="badge">Clans</span>' : ''}}
                        {{ (isset($group['permissions']['clan'])) ? '<span class="badge">Clan</span>' : ''}}
                        {{ (isset($group['permissions']['clanmembers'])) ? '<span class="badge">Clan Members</span>' : ''}}
                    </td>
                    <td>
                        <button class="btn btn-default" onClick="location.href='{{ URL::to('admin/group/') }}/{{ $group->id }}/edit'">Edit</button>
                        <button class="btn  btn-default action_confirm {{ ($group->id == 5) ? 'disabled' : '' }}" data-method="delete" href="{{ URL::to('admin/group') }}/{{ $group->id }}">Delete</button>
                    </td>
                </tr>
            @endforeach
            </tbody>
        </table>

        <button class="btn btn-yellow" onClick="location.href='{{ URL::to('admin/group/create') }}'">Create a New Group</button>

        <br/><br/>

        </div>
    </div>
</div>
</div>
@stop

