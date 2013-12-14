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

                <h4>Squad XML Import Results</h4>

                <p>These results have been emailed to you.<br/>
                We advise you to check your email before you navigate away from this page.<br/>
                <b>If the email does not arrive copy the information below, this is the only time the generated passwords will be displayed to you.</b></p>

                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>Username</th>
                            <th>Email</th>
                            <th>Password</th>
                            <th>Created</th>
                            <th>Details</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach ($results as $member)
                        <tr>
                            <td>{{{ $member->username }}}</td>
                            <?php
                            $created = 'No';
                            if($member->created){
                                $created = 'Yes';
                            ?>
                            <td>{{ $member->email }}</td>
                            <td>{{ $member->password }}</td>
                            <td>{{ $created }}</td>
                            <?php
                            }else{
                            ?>
                            <td></td>
                            <td></td>
                            <td>{{ $created }}</td>
                            <?php
                            }
                            ?>
                            <td>{{{ $member->reason }}}</td>

                        </tr>
                        @endforeach
                    </tbody>
                </table>

                <br/><br/>

            </div>
        </div>
    </div>
</div>

@stop
