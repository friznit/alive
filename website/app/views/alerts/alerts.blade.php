@if (Alert::has('success'))

@foreach (Alert::get('success') as $alert)
<div class="alert alert-success">{{ $alert }}</div>
@endforeach

@endif

@if (Alert::has('info'))

@foreach (Alert::get('info') as $alert)
<div class="alert alert-info">{{ $alert }}</div>
@endforeach

@endif

@if (Alert::has('warning'))

@foreach (Alert::get('warning') as $alert)
<div class="alert warning-info">{{ $alert }}</div>
@endforeach

@endif

@if (Alert::has('error'))

@foreach (Alert::get('error') as $alert)
<div class="alert alert-danger">{{ $alert }}</div>
@endforeach

@endif