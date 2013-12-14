@extends('admin.layouts.default')

<div class="admin-panel">
    <div class="container">
        <div class="row">
            <div class="col-md-12">

            {{-- Content --}}
            @section('content')

            @if (Sentry::check())

            <h2>Groups</h2>

            <table class="table table-hover">
                <thead>
                    <th>Name</th>
                    <th>Country</th>
                    <th>Options</th>
                </thead>
                <tbody>
                @foreach ($allClans as $clan)
                <tr>
                    <td><a href="{{ URL::to('admin/clan/show') }}/{{ $clan->id }}">{{{ $clan->name }}}</a></td>
                    <td>{{{ $clan->country }}}</td>
                    <td>
                        <?php
                        $applied = false;
                        foreach($applications as $application){
                            $application_id = $application->clan_id;
                            if($clan->id == $application_id){
                                $applied = true;
                            }
                        }
                        if(!$applied){
                        ?>
                        <button class="btn btn-default" onClick="location.href='{{ URL::to('admin/application/lodge') }}/{{ $clan->id}}'">Apply</button>
                        <?php
                        }
                        ?>
                    </td>
                </tr>
                @endforeach
                </tbody>
            </table>

            <?php echo $allClans->links(); ?>

            @endif

            </div>
        </div>
    </div>
</div>



@stop
