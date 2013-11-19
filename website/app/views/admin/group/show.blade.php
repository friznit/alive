@extends('admin.layouts.default')

{{-- Content --}}
@section('content')
<div class="span10 well">
	<h1>{{ $group['name'] }} </h1>
    <p>Permsissions:
        <br /> 
        {{ var_dump($groupPermissions) }}</p>

    <p>Var dump: <br />
        {{ var_dump($group) }}</p>
</div>

@stop